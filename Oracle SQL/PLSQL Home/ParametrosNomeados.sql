-- Parametro Nomeados
-- Passamos os parametros de forma nomeada para não precisar respeitar a ordem de escrita dos parametros de entrada


SELECT * FROM CLIENTE;

DECLARE
   v_SEGMERCADO CLIENTE.SEGMERCADO_ID%type :=1;
     v_NUMCLI INTEGER;
BEGIN
  SELECT COUNT (*) INTO v_NUMCLI FROM CLIENTE;
    FOR v_ID IN 1..v_NUMCLI LOOP
        ALTERA_SEGMERCADO (p_IDSEGMERCADO => v_SEGMERCADO, p_ID => v_ID);
    END LOOP;
END;
