-- Commit / Rollback

-- Comando para iniciar a transação
BEGIN TRANSACTION;

INSERT INTO VENDEDORES
VALUES
('239', 'Maria Joana', 'Copacabana', 0.2, '2015-01-01',1);

-- Final da manipulação
-- COMMIT (CONFIRMAR AS MANIPULAÇÕES)
-- ROLLBACK (VOLTAR COMO ANTES SEM AS MANIPULAÇÕES)