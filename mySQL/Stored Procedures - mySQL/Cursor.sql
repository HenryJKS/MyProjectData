use projetoestudo;

/* Uso do CURSOR, para somar todos salário dos clientes */

DELIMITER $$
USE `projetoestudo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `cursor_salariototal`()
BEGIN

declare salario_emp double default 0;
declare salario_total double default 0;
declare fim_loop int default 0;

declare cursorsalario cursor for select salario from empregado;

declare continue handler for not found set fim_loop = 1;

open cursorsalario;

while fim_loop = 0
do 
 fetch cursorsalario into salario_emp;
    
    if fim_loop = 0 then
    set salario_total = salario_total + salario_emp;
    end if;
    
end while;

select salario_total;


close cursorsalario;

END$$

DELIMITER ;

/* Chamando o cursor */
call cursor_salariototal();

