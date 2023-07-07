-- EXCEPTION
-- Conhecemos EXCEPTION como tratamentos erros, onde ao invés de aparecer o código do erro, ou a informação
-- Podemos mandar uma informação mais amigável para tratarmos o erro


SELECT * FROM CLIENTE;

SET SERVEROUTPUT ON;
DECLARE
BEGIN 
    INCLUIR_CLIENTE(15, 'FARMACIA X', 18495719439, 1, 90000);
    
END;



create or replace PROCEDURE incluir_cliente
(
p_ID CLIENTE.ID%type,
p_RAZAO CLIENTE.RAZAO_SOCIAL%type,
p_CNPJ CLIENTE.CNPJ%type,
p_SEGMERCADO CLIENTE.SEGMERCADO_ID%type,
p_FATURAMENTO CLIENTE.FATURAMENTO_PREVISTO%type
)
IS
  v_CATEGORIA CLIENTE.CATEGORIA%type;
  V_CNPJ_SAIDA CLIENTE.CNPJ%TYPE;
BEGIN

   v_CATEGORIA := categoria_cliente(p_FATURAMENTO);
   FORMATACAO_CNPJ(p_CNPJ, v_CNPJ_SAIDA);
   
   INSERT INTO CLIENTE
   VALUES 
   (p_ID, p_RAZAO, v_CNPJ_SAIDA, p_SEGMERCADO, SYSDATE, p_FATURAMENTO, v_CATEGORIA);
   COMMIT;
   
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
    DBMS_OUTPUT.PUT_LINE('ERROR: ID já cadastrado insira outro!');
END;