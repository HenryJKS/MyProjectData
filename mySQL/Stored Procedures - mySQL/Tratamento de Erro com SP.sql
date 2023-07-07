use projetoestudo;

/*Tratamento de erro com SP */

DELIMITER $$
USE `projetoestudo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `novo_empregado`(id int, nome varchar(50), sobrenome varchar(50), datanascimento date, 
									salario double, comissao double, ferias bit, id_empresa int)
BEGIN

/* Declarando uma variavel para retornar um mensagem informando o tratamento */
declare mensagem varchar(50);

/* Declarando um tratamento de erro quando inserir um empregado já cadastrado */
declare exit handler for 1062
BEGIN
/* Retornará essa mensagem caso o empregado já estiver cadastrado com a mesma PK */
	set mensagem = 'Empregado já cadastrado';
    select mensagem;
END;


insert into empregado (id_empregado, nome, sobrenome, data_nascimento, salario, comissao, ferias, id_empresa)
	values           
					  (id, nome, sobrenome, datanascimento, salario, comissao, ferias, id_empresa);
                      
/* Será retornado essa mensagem caso o empregado for cadastrado */
set mensagem = 'Empregado Cadastrado com Sucesso';
select mensagem;


END$$

DELIMITER ;


/* Criando um cadastro do Empregado */

call novo_empregado (7, 'João', 'Cordeiro', '1990-12-20', 6500, 0.10, 1, 1);




