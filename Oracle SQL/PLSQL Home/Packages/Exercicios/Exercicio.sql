-- Exercicio PACKAGE
-- Identifique todos OBJETOS relacionados a tabela do PRODUTO_EXERCICIO
-- Identifcado, crie um package (CABEÇALHO E COPOR) e um sinomimo para ele.
-- Após isso de o prilégio para o usuario user_app


SELECT * FROM DEPTREE_TEMPTAB;

EXECUTE DEPTREE_FILL('table', 'user_dev', 'PRODUTO_EXERCICIO');

SELECT NESTED_LEVEL, SCHEMA, TYPE, NAME, SEQ# FROM DEPTREE ORDER BY SEQ#;

/
CREATE OR REPLACE PACKAGE PRODUTO_EXERCICIO_PAC
IS 
    FUNCTION RETORNA_CATEGORIA
(p_COD IN produto_exercicio.cod%type)
RETURN produto_exercicio.categoria%type;

    FUNCTION RETORNA_IMPOSTO 
(p_COD_PRODUTO produto_venda_exercicio.cod_produto%type)
RETURN produto_venda_exercicio.percentual_imposto%type;

    PROCEDURE INCLUINDO_DADOS_VENDA 
(
p_ID produto_venda_exercicio.id%type,
p_COD_PRODUTO produto_venda_exercicio.cod_produto%type,
p_DATA produto_venda_exercicio.data%type,
p_QUANTIDADE produto_venda_exercicio.quantidade%type,
p_PRECO produto_venda_exercicio.preco%type
);

    PROCEDURE INCLUINDO_PRODUTO 
(p_COD produto_exercicio.cod%type
, p_DESCRICAO produto_exercicio.descricao%type
, p_CATEGORIA produto_exercicio.categoria%type);

END;
/

-------------------------------------------------------
CREATE OR REPLACE PACKAGE BODY PRODUTO_EXERCICIO_PAC
IS
    FUNCTION RETORNA_CATEGORIA
(p_COD IN produto_exercicio.cod%type)
RETURN produto_exercicio.categoria%type
IS
   v_CATEGORIA produto_exercicio.categoria%type;
BEGIN
    SELECT CATEGORIA INTO v_CATEGORIA FROM PRODUTO_EXERCICIO WHERE COD = p_COD;
    RETURN v_CATEGORIA;
END;

    FUNCTION RETORNA_IMPOSTO 
(p_COD_PRODUTO produto_venda_exercicio.cod_produto%type)
RETURN produto_venda_exercicio.percentual_imposto%type
IS
   v_CATEGORIA produto_exercicio.categoria%type;
   v_IMPOSTO produto_venda_exercicio.percentual_imposto%type;
BEGIN
    v_CATEGORIA := retorna_categoria(p_COD_PRODUTO);
    IF TRIM(v_CATEGORIA) = 'Sucos de Frutas' THEN
        v_IMPOSTO := 10;
    ELSIF TRIM(v_CATEGORIA) = 'Águas' THEN
        v_IMPOSTO := 20;
    ELSIF TRIM(v_CATEGORIA) = 'Mate' THEN
        v_IMPOSTO := 15;
    END IF;
    RETURN v_IMPOSTO;
END;

    PROCEDURE INCLUINDO_DADOS_VENDA 
(
p_ID produto_venda_exercicio.id%type,
p_COD_PRODUTO produto_venda_exercicio.cod_produto%type,
p_DATA produto_venda_exercicio.data%type,
p_QUANTIDADE produto_venda_exercicio.quantidade%type,
p_PRECO produto_venda_exercicio.preco%type
)
IS
   v_VALOR produto_venda_exercicio.valor_total%type;
   v_PERCENTUAL produto_venda_exercicio.percentual_imposto%type;
BEGIN
   v_PERCENTUAL := retorna_imposto(p_COD_PRODUTO);
   v_VALOR := p_QUANTIDADE * p_PRECO;
   INSERT INTO PRODUTO_VENDA_EXERCICIO 
   (id, cod_produto, data, quantidade, preco, valor_total, percentual_imposto) 
   VALUES 
   (p_ID, p_COD_PRODUTO, p_DATA, p_QUANTIDADE, p_PRECO, v_VALOR, v_PERCENTUAL);
    COMMIT;
END;
    
    PROCEDURE INCLUINDO_PRODUTO 
(p_COD produto_exercicio.cod%type
, p_DESCRICAO produto_exercicio.descricao%type
, p_CATEGORIA produto_exercicio.categoria%type)
IS
BEGIN
   INSERT INTO PRODUTO_EXERCICIO (COD, DESCRICAO, CATEGORIA) VALUES (p_COD, REPLACE(p_DESCRICAO,'-','>')
   , p_CATEGORIA);
   COMMIT;
END;
END;
/

CREATE PUBLIC SYNONYM PRODUTO_EXERCICIO_PAC FOR user_dev.PRODUTO_EXERCICIO_PAC;


GRANT EXECUTE ON PRODUTO_EXERCICIO_PAC TO user_app;