-- Break em loop
-- Usamos EXIT para parar o LOOP sem necessidade de uma condição

SELECT * FROM CLIENTE;

DECLARE 
   v_SEGMERCADO CLIENTE.SEGMERCADO_ID%type := 2;
     v_ID CLIENTE.ID%type :=1;
     v_NUMCLI INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_NUMCLI FROM CLIENTE;
  LOOP
    IF v_ID <= v_NUMCLI THEN
        ALTERA_SEGMERCADO (v_ID,v_SEGMERCADO);
        v_ID := v_ID + 1;
    ELSE
        EXIT; 
    END IF;
    
    END LOOP;
END;

    