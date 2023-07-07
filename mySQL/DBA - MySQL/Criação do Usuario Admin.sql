

/* Criando usuario Admin por linha de comando */
create user 'admin02'@'localhost' identified by 'admin02';

grant all privileges on *.* to 'admin02'@'localhost' with grant option;

/* Deletando um usuario */
DROP USER "admin02"@"localhost";

