-- PL/SQL
-- DBMS_OUTPUT um package.

-- Ligar a sa�da de dados
SET SERVEROUTPUT ON;

DECLARE AMOUNT INTEGER(10);


BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello World');
END;
/

SET SERVEROUTPUT OFF;

-- Verificar o package
-- desc dbms_output;