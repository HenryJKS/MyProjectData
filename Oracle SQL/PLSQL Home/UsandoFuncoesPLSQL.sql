-- Usando Função em PL/SQL
-- Podemos usar várias funções já criada do SQL no PL/SQL

SELECT * FROM PRODUTO_EXERCICIO;

DECLARE
   v_COD produto_exercicio.cod%type := '67120';
   v_DESCRICAO produto_exercicio.descricao%type := 'Frescor da Montanha - Aroma Limão - 1 Litro';
   v_CATEGORIA produto_exercicio.categoria%type := 'Águas';
BEGIN
   INSERT INTO PRODUTO_EXERCICIO (COD, DESCRICAO, CATEGORIA) VALUES (v_COD, REPLACE(v_DESCRICAO, '-', '>') , v_CATEGORIA);
   COMMIT;
END;
