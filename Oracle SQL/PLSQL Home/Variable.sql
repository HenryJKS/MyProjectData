-- VARIABLE
-- Usamos Variable quando queremos declarar uma varíavel fora de um bloco de comando

VARIABLE g_DESCRICAO VARCHAR2(100);
EXECUTE :g_DESCRICAO:= obter_descricao_segmercado(3);
PRINT g_DESCRICAO;


-- Podemos usar dentro de um PL/SQL
SET SERVEROUT ON;

DECLARE 
    v_DESCRICAO SEGMERCADO.DESCRICAO%TYPE;
    V_ID SEGMERCADO.ID%TYPE := 1;
BEGIN
    v_DESCRICAO := obter_descricao_segmercado(4);
    
    DBMS_OUTPUT.PUT_LINE(v_DESCRICAO);
END;
