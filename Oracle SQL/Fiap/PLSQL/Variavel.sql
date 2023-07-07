SET SERVEROUTPUT ON;

DECLARE
    v_ei NUMBER(5,2) := 10;
    v_ln VARCHAR(50) := 'Chispista';
    v_sal number(10,2) not null := 0;
    c_tax CONSTANT INT :=1;


BEGIN
    DBMS_OUTPUT.PUT_LINE('Codigo do funcionario: ' || V_EI || ' ' || V_LN);
END;