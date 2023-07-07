-- Exercicio
-- Trate o erro gerado por esse código.
SET SERVEROUTPUT ON;

DECLARE
   v_PRODUTO produto_exercicio.cod%type:= 41232;
   e_VIOLACAO EXCEPTION;
   PRAGMA EXCEPTION_INIT(e_VIOLACAO, -2292);
BEGIN
   EXCLUINDO_PRODUTO(v_PRODUTO);
   
   EXCEPTION
    WHEN e_VIOLACAO THEN
        RAISE_APPLICATION_ERROR(-20020, 'PRODUTO '|| v_PRODUTO || 'Não pode deletar um registro dependente,verifique as tabelas que dependam dele');
END;

