SET DEFINE OFF;

CREATE OR REPLACE PROCEDURE apply_bulk_treatment_adjustment (
    p_percentage_increase IN NUMBER
) AS
    -- Define nested table collection types
    TYPE t_treatment_ids IS TABLE OF treatments.treatment_id%TYPE;
    TYPE t_costs IS TABLE OF treatments.cost%TYPE;
    
    l_treatment_ids t_treatment_ids;
    l_costs t_costs;
    
    -- Exception for bulk errors
    e_bulk_fail EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_bulk_fail, -24381); -- ORA-24381: error(s) in DML array operation
BEGIN
    -- Step 1: Retrieve multiple rows into collections using BULK COLLECT
    SELECT treatment_id, cost 
    BULK COLLECT INTO l_treatment_ids, l_costs
    FROM treatments;
    
    IF l_treatment_ids.COUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No treatments found for bulk adjustment.');
        RETURN;
    END IF;
    
    -- Step 2: Modify collection data in memory
    FOR i IN 1..l_costs.COUNT LOOP
        l_costs(i) := l_costs(i) * (1 + (p_percentage_increase / 100));
    END LOOP;
    
    -- Step 3: Use FORALL for bulk update with SAVE EXCEPTIONS
    FORALL i IN 1..l_treatment_ids.COUNT SAVE EXCEPTIONS
        UPDATE treatments
        SET cost = l_costs(i)
        WHERE treatment_id = l_treatment_ids(i);
        
    DBMS_OUTPUT.PUT_LINE('Successfully updated ' || SQL%ROWCOUNT || ' treatment costs using bulk processing.');
    COMMIT;
    
EXCEPTION
    WHEN e_bulk_fail THEN
        DECLARE
            l_error_count NUMBER := SQL%BULK_EXCEPTIONS.COUNT;
        BEGIN
            DBMS_OUTPUT.PUT_LINE('Bulk update completed with ' || l_error_count || ' error(s):');
            FOR i IN 1..l_error_count LOOP
                DBMS_OUTPUT.PUT_LINE('Error Index: ' || SQL%BULK_EXCEPTIONS(i).ERROR_INDEX || 
                                     ' | Error Code: ' || SQL%BULK_EXCEPTIONS(i).ERROR_CODE);
            END LOOP;
        END;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unexpected error during bulk processing: ' || SQLERRM);
        ROLLBACK;
END apply_bulk_treatment_adjustment;
/
