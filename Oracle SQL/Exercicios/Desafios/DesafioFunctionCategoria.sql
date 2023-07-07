-- Criando uma fun��o para criar a CLASSIFICA��O DA CATEGORIA
-- PRECISAMOS CRIAR UMA CONDI��O PARA CATEGORIA:
-- PEQUENO AT� 10000
-- M�DIO ENTRE 10001 E 50000
-- M�DIO GRANDE ENTRE 50001 E 100000
-- GRANDE MAIS DE 100000

SELECT CLASSIFICANDO_CATEGORIA(FATURAMENTO_PREVISTO) FROM CLIENTE;

EXECUTE INCLUIR_CLIENTE('2', 'SUPERMERCADOS ATACADISTA', '29401759183', 2, 48500, 'MEDIO');

CREATE OR REPLACE FUNCTION CLASSIFICANDO_CATEGORIA
(v_FATURAMENTO CLIENTE.FATURAMENTO_PREVISTO%TYPE)

RETURN CLIENTE.CATEGORIA%TYPE

IS
v_CATEGORIA CLIENTE.CATEGORIA%TYPE;
BEGIN
     IF 
        v_FATURAMENTO <= 10000 THEN v_CATEGORIA := 'PEQUENO';
    ELSIF
        v_FATURAMENTO BETWEEN 10001 AND 50000 THEN v_CATEGORIA := 'MEDIO';
    ELSIF 
        v_FATURAMENTO BETWEEN 50001 AND 100000 THEN v_CATEGORIA := 'MEDIO GRANDE';
    ELSE 
        v_CATEGORIA := 'GRANDE';
    END IF;
    
    RETURN v_CATEGORIA;
END;