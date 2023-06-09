-- EXCEPTION OTHERS
-- Usamos OTHERS quando n�o identificamos todos erros, e podemos fazer uma tratamento para todos os erros
-- Mas podemos classificar esses erros, usando "slqerrm()"
SELECT * FROM CLIENTE;

UPDATE CLIENTE SET FATURAMENTO_PREVISTO = 50000 WHERE ID = 16;
EXECUTE INCLUIR_CLIENTE (16,'CLIENTE NOVO 3','5498695486',1,NULL);
EXECUTE INCLUIR_CLIENTE (18,'CLIENTE NOVO 3 RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR','5498695486',1,80000);

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
        RAISE_APPLICATION_ERROR(-20015, 'N�o pode inserir valores nulos');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20025, 'Erro n�o esperado - TEXTO ORIGINAL DO ERRO: ' || sqlerrm());
END;