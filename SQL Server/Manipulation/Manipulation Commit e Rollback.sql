-- Commit / Rollback

-- Comando para iniciar a transa��o
BEGIN TRANSACTION;

INSERT INTO VENDEDORES
VALUES
('239', 'Maria Joana', 'Copacabana', 0.2, '2015-01-01',1);

-- Final da manipula��o
-- COMMIT (CONFIRMAR AS MANIPULA��ES)
-- ROLLBACK (VOLTAR COMO ANTES SEM AS MANIPULA��ES)