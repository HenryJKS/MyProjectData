-- Percent Type
-- Com percent type podemos declarar var�aveis sem precisar declarar o tipo.
-- Podemos declarar usando colunas da tabela, e essa var�avel ter� o mesmo tipo da coluna usada

SET SERVEROUTPUT ON;

SELECT * FROM SEGMERCADO;


DECLARE
    v_ID SEGMERCADO.ID%type := 3;
    v_DESCRICAO SEGMERCADO.DESCRICAO%type := 'Atacado';
BEGIN
    
    INSERT INTO SEGMERCADO VALUES (v_ID, v_DESCRICAO);
    

END;

