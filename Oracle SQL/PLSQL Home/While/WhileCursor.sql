-- While com Cursor
-- Podemos usar a condição contraria do NOTFOUND
-- e precisamos declarar explicitamente que precisa ir para o próximo valor
-- Ou seja fazer o FETCH no final
DECLARE
    v_SEGMERCADO CLIENTE.SEGMERCADO_ID%type := 2;
    v_ID CLIENTE.ID%type; 
    CURSOR cur_CLIENTE IS (SELECT ID FROM CLIENTE);
BEGIN
    OPEN cur_CLIENTE; 
    FETCH cur_CLIENTE INTO v_ID; -- Primeiro FETCH para apontar na primeira linha
    WHILE cur_CLIENTE%FOUND LOOP
        ALTERA_SEGMERCADO(v_ID, v_SEGMERCADO);
    FETCH cur_CLIENTE INTO v_ID; -- Segundo FETCH para apontar na próxima linha
    END LOOP;
    CLOSE cur_CLIENTE;
END;

SELECT * FROM CLIENTE;