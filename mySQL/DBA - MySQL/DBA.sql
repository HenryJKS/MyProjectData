

/* Mostrar o diretório da DataBase */
show variables where variable_name like '%dir';

/* Backup Logíco */
mysqldump -uroot -p --databases nomedatabela > localdobackup

/* Verificar o custo da consulta */
EXPLAIN FORMAT=JSON (Consulta) \G