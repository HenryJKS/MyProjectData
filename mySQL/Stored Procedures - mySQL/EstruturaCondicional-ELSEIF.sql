use projetoestudo;

/* Criar um ELSEIF com Stored Procedures */
/* A estrutura vai verificar se o valor do Aluguel está Barato/Normal/Caro */
DELIMITER $$
USE `projetoestudo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `status_conta_aluguel`(codConta int)
BEGIN

declare ValorAluguel double;
declare Exibir varchar(50);
select conta_aluguel into ValorAluguel from conta where id_conta = codConta;

IF ValorAluguel <= 5000 
	THEN SET Exibir = 'Barato';
ELSEIF ValorAluguel > 5000 and ValorAluguel <= 7500 THEN
	SET Exibir = 'Normal';
    ELSE
    SET Exibir = 'Caro';
    
end if;

select Exibir;

END$$

DELIMITER ;

call status_conta_aluguel();




