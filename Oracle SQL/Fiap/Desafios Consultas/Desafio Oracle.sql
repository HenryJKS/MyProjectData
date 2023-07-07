-- 1 1.	Faça uma consulta que exiba o primeiro nome (first_name), 
-- o último nome (last_name), o código do cargo (job_id)
-- e o nome do departamento (department_name) dos empregados os quais 
-- são SUPERIORES ao empregado cujo o último nome (last_name) é igual a Pataballa.

SELECT A.FIRST_NAME, A.LAST_NAME, A.JOB_ID, B.DEPARTMENT_NAME 
FROM EMPLOYEES A 
INNER JOIN DEPARTMENTS B 
ON A.DEPARTMENT_ID = B.DEPARTMENT_ID START WITH A.LAST_NAME = 'Pataballa'
CONNECT BY PRIOR A.MANAGER_ID = A.EMPLOYEE_ID;

/* 2.	Construa uma instrução com CTE (Common Table Expression) que exiba os departamentos (depatment_name) 
que apresentam os salários (salary) abaixo da média dos somatórios de salários de todos os departamentos. 
Ordene a consulta pelo nome do departamento de maneira ascendente. 
Utilize os apelidos nas colunas conforme a saída apresentada a seguir */

SELECT A.DEPARTMENT_NAME, SUM(B.SALARY)
FROM DEPARTMENTS A 
INNER JOIN EMPLOYEES B
ON A.DEPARTMENT_ID = B.DEPARTMENT_ID
GROUP BY A.DEPARTMENT_NAME
HAVING SUM(B.SALARY) < (SELECT AVG(DEPT_TOTAL) FROM (SELECT SUM(A.SALARY) DEPT_TOTAL, B.DEPARTMENT_NAME 
                      FROM EMPLOYEES A INNER JOIN DEPARTMENTS B
                      ON A.DEPARTMENT_ID = B.DEPARTMENT_ID
                      GROUP BY B.DEPARTMENT_NAME))
ORDER BY A.DEPARTMENT_NAME;


/* 3.	Execute os comandos a seguir: 
Construa UMA instrução que insira nas seguintes tabelas a seguir:
•	Insira na tabela it_dept_employees os empregados que trabalham no department_name chamado IT ou que tenham o job_id como AD_VP.
•	Insira na tabela sales_dept_employees os empregados que trabalham department_name chamado Sales ou no department_name chamado Executive.
•	Insira na tabela other_dept_employees os empregados que não foram inseridos nas tabelas anteriores.
Atenção: Garanta que o empregado só será inserido em apenas uma tabela! Não insira o empregado em mais de uma tabela.*/

drop table it_dept_employees purge;
drop table sales_dept_employees purge;
drop table other_dept_employees purge;

create table  it_dept_employees 
(employee_id number(6), first_name varchar(20), last_name varchar(25), email varchar(25));

create table sales_dept_employees
(employee_id number(6), first_name varchar(20), last_name varchar(25), job_id varchar(10));

create table other_dept_employees 
(employee_id number(6), last_name varchar(25), email varchar(25), salary number(8,2), department_name varchar(30));

INSERT FIRST
    WHEN DEPARTMENT_NAME = 'IT' OR JOB_ID = 'AD_VP' THEN 
        INTO IT_DEPT_EMPLOYEES VALUES(EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL)
    WHEN DEPARTMENT_NAME = 'Sales' OR DEPARTMENT_NAME = 'Executive' THEN
        INTO SALES_DEPT_EMPLOYEES VALUES(EMPLOYEE_ID, FIRST_NAME, LAST_NAME, JOB_ID)
    ELSE 
        INTO OTHER_DEPT_EMPLOYEES VALUES(EMPLOYEE_ID, LAST_NAME, EMAIL, SALARY, DEPARTMENT_NAME)
SELECT A.DEPARTMENT_NAME, B.JOB_ID, B.FIRST_NAME, B.LAST_NAME, B.EMAIL, B.EMPLOYEE_ID, B.SALARY
FROM DEPARTMENTS A RIGHT JOIN EMPLOYEES B
ON A.DEPARTMENT_ID = B.DEPARTMENT_ID;

SELECT * FROM it_dept_employees ;
SELECT * FROM sales_dept_employees;
SELECT * FROM other_dept_employees;


/* 4.	Execute as instruções a seguir: 

drop table dim_Produtos purge;
drop table dim_lojas purge;
drop table fato_vendas;

create table dim_Produtos
(produto_id int,	nome varchar(35), categoria varchar(25));
insert into dim_Produtos values(1,'Tv 4K – 50 Pol.','Eletrônicos');
insert into dim_Produtos values(2,'Camisa de Linho Egípcio','Vestuário');
insert into dim_Produtos values(3,'Notebook i7 – 1TB – 32GB mem','Eletrônicos');
insert into dim_Produtos values(4,'Teclado BlueTooth','Acessórios');
insert into dim_Produtos values(5,'Camisa Polo','Vestuário');

create table dim_lojas
(loja_id	int, nome varchar(15),cidade varchar(25));
insert into dim_lojas values(1,'Loja SP','São Paulo');
insert into dim_lojas values(2,'Loja RJ','Rio de Janeiro');
insert into dim_lojas values(3,'Loja RS','Rio Grande do Sul');

create table fato_vendas
(produto_id int ,loja_id int, data date, quantidade	int, valor_unitario number(6,2));
insert into fato_vendas values(1,1,'11-APR-23',10,100.00);
insert into fato_vendas values(2,2,'12-APR-23',5,50.00);
insert into fato_vendas values(1,3,'13-APR-23',2,100.00);
insert into fato_vendas values(3,1,'14-APR-23',7,80.00);
insert into fato_vendas values(4,2,'15-APR-23',3,20.00);
insert into fato_vendas values(5,3,'16-APR-23',8,60.00);
commit;
?
Crie uma consulta que exiba a receita total de vendas da empresa no período entre 11-APR-23' e 16-APR-23', agrupando por loja e produto. Exiba na mesma consulta a receita total por loja e na última linha a recita total de todas as lojas. Ordene a saída pela coluna LOJA de maneira ascendente. Nomeie os cabeçalhos conforme a saída exibida a seguir:

*/

SELECT * FROM DIM_PRODUTOS;
SELECT * FROM DIM_LOJAS;
SELECT * FROM FATO_VENDAS;

SELECT A.NOME "Loja", C.NOME "PRODUTO", SUM(B.QUANTIDADE * B.VALOR_UNITARIO)
FROM DIM_LOJAS A
INNER JOIN FATO_VENDAS B
ON A.LOJA_ID = B.LOJA_ID
INNER JOIN DIM_PRODUTOS C
ON C.PRODUTO_ID = B.PRODUTO_ID
WHERE B.DATA BETWEEN '11-04-23' AND '16-04-23' /* se 11-04-23 não for, tente 11-APR-23 */
GROUP BY ROLLUP(A.NOME, C.NOME)
ORDER BY A.NOME, C.NOME;