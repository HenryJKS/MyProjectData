-- Package para EXCEPTION
-- Podemos criar um pacote para erros em que todos outros pacote vão usar, isso cria uma padronização de exception

CREATE OR REPLACE PACKAGE EXCEPTION_PAC
IS
    e_NULL EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_NULL, -1400);
    e_FK EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_FK, -2291);
    e_PK EXCEPTION;
    PRAGMA EXCEPTION_INIT (e_PK, -0001);
END;
/

/* Com Package criado, podemos entrar nos packages dos objetos, e inserir os exceptions no final
   EX: WHEN EXCEPTION_PAC.e_NULL THEN
        RAISE_APPLICATION_ERROR(-20012, 'Insira um valor!');
*/

INSERT INTO CLIENTE VALUES(2, 'TESTE', '12392', 3, SYSDATE, 100000, 'AA');