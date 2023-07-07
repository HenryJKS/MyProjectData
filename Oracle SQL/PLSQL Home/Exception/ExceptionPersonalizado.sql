-- EXCEPTION Customizado
-- Podemos criar um retorno do erro customizado no formato de como a Oracle mostra, com "raise_application_error"
-- Podemos também criar uma própria EXCEPTION
-- O Oracle disponibiliza um conjunto de 999 números que podemos usar como número do erro customizado. Eles variam de -20.000 a -20.999.

SELECT * FROM CLIENTE;
EXECUTE INCLUIR_CLIENTE(18, 'Loja X', '19458490531', 10, 20000);



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
  /* Criando propria EXCEPTION */ e_IDNULO exception;
  PRAGMA EXCEPTION_INIT(e_IDNULO, -1400);
BEGIN

   v_CATEGORIA := categoria_cliente(p_FATURAMENTO);
   FORMATACAO_CNPJ(p_CNPJ, v_CNPJ_SAIDA);
   
   INSERT INTO CLIENTE
   VALUES 
   (p_ID, p_RAZAO, v_CNPJ_SAIDA, p_SEGMERCADO, SYSDATE, p_FATURAMENTO, v_CATEGORIA);
   COMMIT;
   
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        RAISE_APPLICATION_ERROR(-20010, 'Cliente ja cadastrado');
    WHEN e_IDNULO THEN
        RAISE_APPLICATION_ERROR(-20015, 'Não pode inserir valores nulos');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20025, 'Erro não esperado');
END;