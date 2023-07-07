-- Criação de SCRIPT para achar todas dependencias
-- Podemos ver que Procedures ou Functions possuem dependencias de tabelas, assim podemos mapear essas dependencias
-- Caso queremos dar sinonimos para todos esses objetos, ficaria muito dificil caso tenhamos muito
-- Por isso podemos criar um script para mapear todas dependencias

-- Para isso precisamos rodas o script "UDLTREE"
-- Local: C:\app\User\product\21c\dbhomeXE\rdbms\admin

SELECT * FROM DEPTREE_TEMPTAB;

-- No primeiro paramatro, colocaremos qual objeto vamos usar
-- No segundo parametro, é o usuario dono do objeto
-- No terceiro parametro, sera o nome do objeto
EXECUTE DEPTREE_FILL('table', 'user_dev', 'CLIENTE');

-- Com a procedure executada, a gente pode consultar na VIEW para ter as informações mais amigáveis
SELECT NESTED_LEVEL, SCHEMA, TYPE, NAME, SEQ# FROM DEPTREE ORDER BY SEQ#;

SELECT DISTINCT NAME FROM DEPTREE;