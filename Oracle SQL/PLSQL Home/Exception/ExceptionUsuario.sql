-- EXCEPTION de usuarios
-- São erros em que o SQL não consegue tratar, porém para nós é considerado um erro
-- Podemos tratar esses erros criando nosso proprio EXCEPTION
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
  e_IDNULO exception;
  PRAGMA EXCEPTION_INIT(e_IDNULO, -1400);
  e_FATURAMENTONULO EXCEPTION;
BEGIN
    -- Criando a condição para verificar se o valor é nulo
    -- RAISE, ele força a parada da procedure e vai para a sessão de EXCEPTION
   IF p_FATURAMENTO IS NULL THEN
     RAISE e_FATURAMENTONULO;
   END IF;
   
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
    WHEN e_FATURAMENTONULO THEN
        RAISE_APPLICATION_ERROR(-20020, 'Faturamento foi incluindo com valor nulo');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20025, 'Erro não esperado - TEXTO ORIGINAL DO ERRO: ' || sqlerrm());
END;