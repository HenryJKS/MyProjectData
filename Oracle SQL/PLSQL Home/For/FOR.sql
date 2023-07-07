-- Usando FOR
-- Usamos LOOP quando a condição de saída é inderteminada
-- Quando sabemos a quantidade de repetições poderiamos utilizar uma estrutura mais simples, o for

SELECT * FROM CLIENTE;

DECLARE
    v_SEGMERCADO CLIENTE.SEGMERCADO_ID%TYPE := 3;
    v_NUMCLIENTES INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_NUMCLIENTES FROM CLIENTE;
    
    FOR v_ID in 1..v_NUMCLIENTES LOOP
        ALTERA_SEGMERCADO(v_ID, v_SEGMERCADO);
    END LOOP;
   
END;

