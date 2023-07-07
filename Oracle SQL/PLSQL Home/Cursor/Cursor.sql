-- Cursor
-- Usamos o CURSOR para apontar para cada linha e fazer a manipulação que queremos
-- Diferente do FOR, LOOP, WHILE nós alteramos por sequencia numérica, porém nem sempre a coluna vai ter a sequencia
-- Por isso usamos o CURSOR.

-- Usando Cursor no Loop
DECLARE 
    v_SEGMERCADO CLIENTE.SEGMERCADO_ID%type := 3; 
    v_ID CLIENTE.ID%type;
    CURSOR v_CURSOR IS SELECT ID FROM CLIENTE ORDER BY ID;
BEGIN 
    OPEN v_CURSOR; 
    LOOP
        FETCH v_CURSOR INTO v_ID;
        ALTERA_SEGMERCADO(v_ID, v_SEGMERCADO);
        EXIT WHEN v_CURSOR%NOTFOUND;
    END LOOP;
    CLOSE v_CURSOR;
END;

-- Usando Cursor com FOR
-- Quando usamos FOR não precisa declarar o CURSOR IMPLICITAMENTE
DECLARE 
    v_SEGMERCADO CLIENTE.SEGMERCADO_ID%type := 4;  
    v_ID CLIENTE.ID%type;
    
BEGIN 
    FOR C IN (SELECT ID FROM CLIENTE ORDER BY ID) LOOP
        ALTERA_SEGMERCADO(C.ID, v_SEGMERCADO);
    END LOOP;
END;

SELECT * FROM CLIENTE ORDER BY ID;
EXECUTE INCLUIR_CLIENTE(30, 'Loja NNM', '38495819384', 2, 60000);


