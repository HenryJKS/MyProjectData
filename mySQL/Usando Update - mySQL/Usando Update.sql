use projetoestudo;

select * from empregado;

/* Usando update para alterar dados em tabelas existentes */
update empregado set nome = 'Lucas', sobrenome = 'Silvera', data_nascimento = '1980-05-10', 
					 salario = 4500, comissao = 0.20, ferias = 0 
                     where id_empregado = 1;
                     

/* Alterando a comissao de um empregado só */
update empregado set comissao = comissao * 1.25 where id_empregado = 1; /* Empregado Lucas Silvera */


/* Usando update para importar dado de uma coluna que seja igual a coluna que estou usando */
update empregado a 
	   inner join
	   outratabela.empregado b
       on a.id_empregado = b.id_empregado
       set a.salario = b.salario;
/* Neste caso estou importando os dados da coluna "Salario" da tabela "outratabela.empregado", 
   para a minha coluna atual "Salario" da tabela "empregado" */

