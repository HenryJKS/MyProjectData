-- Procedures
-- Precisamos declarar os parametros que utilizaremos na procedure
-- Podemos usar o REPLACE para caso queremos alterar o PROCEDURE

SELECT * FROM SEGMERCADO;

-- Criação ou Alterando a PROCEDURE
CREATE OR REPLACE PROCEDURE incluir_segmercado
(p_ID IN SEGMERCADO.ID%TYPE, p_DESCRICAO IN SEGMERCADO.DESCRICAO%TYPE)
IS
BEGIN
    INSERT INTO SEGMERCADO (ID, DESCRICAO) VALUES (p_ID, UPPER(p_DESCRICAO));
    COMMIT;
END;

-- Executando uma PROCEDURE
EXECUTE incluir_segmercado(4, 'Farmaceuticos');