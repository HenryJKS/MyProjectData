use projetoestudo;

/* Cursor Multiplas Colunas, retornará o nome, preço e unidades do produto */

DELIMITER $$
USE `projetoestudo`$$
CREATE PROCEDURE `cursor_multiplo` ()
BEGIN

declare produto varchar(80);
declare preco double;
declare unidades int;
declare fim_loop int default 0;

declare cursormultiplo cursor for select nome_produto, preco_produto, unidades_disponivel from produtos;

declare continue handler for not found set fim_loop = 1;

open cursormultiplo;

	while fim_loop = 0
    do 
		fetch cursormultiplo into produto, preco, unidades;
        
        if fim_loop = 0 then
        select concat("Nome do Produto: ", produto, " - ", "Preço do Produto: ", preco, " - ", "Unidades: ", unidades) as DadosProdutos;
        end if;
	
    end while;

close cursormultiplo;


END$$

DELIMITER ;

/* Chamando o cursor */
call cursor_multiplo;
