use projetoestudo;

/* Criando uma Stored Procedures para atualizar o preço dos produtos */
DELIMITER $$
USE `projetoestudo`$$
CREATE PROCEDURE `atualizar_preco` ()
BEGIN

update produtos set preco_produto = preco_produto * (1 + 0.20) where id_produto = 1;

END$$

DELIMITER ;


/* Chamar o SP */
call atualizar_preco;


/* Criando uma Stored Procedures para adicionar um novo empregado com parametro */
DELIMITER $$
USE `projetoestudo`$$
CREATE PROCEDURE `novo_empregado` (id int, nome varchar(50), sobrenome varchar(50), datanascimento date, 
									salario double, comissao double, ferias bit, id_empresa int)
                                    
BEGIN

insert into empregado (id_empregado, nome, sobrenome, data_nascimento, salario, comissao, ferias, id_empresa)
	values           
					  (id, nome, sobrenome, datanascimento, salario, comissao, ferias, id_empresa);

END $$

DELIMITER ;

/* Chamando o SP com parametros */

call novo_empregado (6, 'Gilberto', 'Silva', '1999-04-12', 3800, 0.15, 0, 1);


