-- Usando parametro INT OUT
-- é possível fazer com que uma varíavel seja de entrada e saída


CREATE OR REPLACE PROCEDURE FORMATACAO_CNPJ_SIMPLES
(p_CNPJ IN OUT CLIENTE.CNPJ%type )
IS
BEGIN
    p_CNPJ := SUBSTR(p_CNPJ,1,3) || '/' || SUBSTR(p_CNPJ,4,2) || '-' || SUBSTR(p_CNPJ,6);
END;

SET SERVEROUTPUT ON;

DECLARE
p_CNPJ CLIENTE.CNPJ%TYPE;

BEGIN
    
    p_CNPJ := '1234567890';
    
    FORMATACAO_CNPJ_SIMPLES(p_CNPJ);
    
    DBMS_OUTPUT.PUT_LINE(p_CNPJ);
END;


