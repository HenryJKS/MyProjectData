SET SERVEROUTPUT ON;

DECLARE 
    v_ID CLIENTE.ID%TYPE;
    v_RAZAO_SOCIAL CLIENTE.RAZAO_SOCIAL%TYPE;
    -- Declara��o do CURSOR, com comando SQL para ele saber quais linhas vai armazenar na memoria
    CURSOR cur_CLIENTE is SELECT ID, RAZAO_SOCIAL FROM CLIENTE ORDER BY ID;
BEGIN
    -- Abrindo o CURSOR
    OPEN cur_CLIENTE;
    LOOP 
        -- O Cursor vai apontar para primeira linhas, com loop ele vai come�ar a pontar uma linha abaixo at� o final
        FETCH cur_CLIENTE INTO v_ID, v_RAZAO_SOCIAL;
        -- Sair do Cursor quando n�o for encontrado mais nenhum
    EXIT WHEN cur_CLIENTE%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('ID = ' || v_ID || '||'|| 'Razao Social = ' || v_RAZAO_SOCIAL);
    END LOOP;
END;