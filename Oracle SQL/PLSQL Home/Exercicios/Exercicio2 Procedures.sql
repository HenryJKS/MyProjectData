-- Exercicio 2
-- Crie 3 Procedures:
-- INCLUINDO_PRODUTO - Inclui um produto novo, passando como parâmetros todos os campos para inclusão de um produto na tabela.
-- ALTERANDO_CATEGORIA_PRODUTO - Altera apenas a categoria do produto, dado um código.
-- EXCLUINDO_PRODUTO - Exclui um produto, passando como parâmetro o seu código.

SELECT * FROM PRODUTO_EXERCICIO;

CREATE OR REPLACE PROCEDURE INCLUINDO_PRODUTO
(p_COD PRODUTO_EXERCICIO.COD%TYPE, p_DESCRICAO PRODUTO_EXERCICIO.DESCRICAO%TYPE, p_CATEGORIA PRODUTO_EXERCICIO.CATEGORIA%TYPE)
IS
BEGIN
    INSERT INTO PRODUTO_EXERCICIO VALUES (p_COD, p_DESCRICAO, p_CATEGORIA);
    COMMIT;
END;

EXECUTE INCLUINDO_PRODUTO('33854', 'Frescor da Montanha - Aroma Laranja - 1 Litro', 'Mate');
EXECUTE INCLUINDO_PRODUTO('89254', 'Frescor da Montanha - Aroma Uva - 1 Litro', 'Águas');

-------------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE ALTERANDO_CATEGORIA_PRODUTO
(p_COD PRODUTO_EXERCICIO.COD%TYPE)
IS
p_CATEGORIA PRODUTO_EXERCICIO.CATEGORIA%TYPE := 'Águas';
BEGIN
    UPDATE PRODUTO_EXERCICIO SET CATEGORIA = p_CATEGORIA where COD = p_COD;
END;

EXECUTE ALTERANDO_CATEGORIA_PRODUTO('33854');

-------------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE EXCLUINDO_PRODUTO
(p_COD PRODUTO_EXERCICIO.COD%TYPE)
IS
BEGIN
    DELETE FROM PRODUTO_EXERCICIO WHERE COD = p_COD;
END;

EXECUTE EXCLUINDO_PRODUTO('89254');