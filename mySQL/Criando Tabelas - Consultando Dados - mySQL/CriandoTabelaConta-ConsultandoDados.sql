/* Criação da tabela conta */
create table conta (
id_conta integer primary key not null,
conta_energia double not null,
conta_internet double not null,
conta_aluguel double not null,
data_conta date not null,
id_empresa integer not null,
foreign key (id_empresa) references empresa(id_empresa)
);

/* Inserindo dados para tabela */
insert into conta
(id_conta, conta_energia, conta_internet, conta_aluguel, data_conta, id_empresa)
values
(1, 580.12, 220.45, 7200, '2022-01-31', 1),
(2, 553.30, 210.30, 7200, '2022-02-28', 1),
(3, 600.12, 223.22, 7200, '2022-03-31', 1),
(4, 595.53, 222.98, 7200, '2022-04-30', 1),
(5, 586.57, 215.12, 7200, '2022-05-31', 1),
(6, 583.40, 234.04, 7200, '2022-06-30', 1),
(7, 570.94, 231.49, 7200, '2022-07-31', 1),
(8, 589.01, 237.37, 9500, '2022-08-31', 1),
(9, 567.29, 220.91, 9500, '2022-09-30', 1),
(10, 542.85, 225.41, 9500, '2022-10-31', 1),
(11, 545.90, 227.59, 9500, '2022-11-30', 1),
(12, 520.13, 208.96, 9500, '2022-12-31', 1),
(13, 528.01, 210.10, 10500, '2023-01-31', 1),
(14, 532.12, 212.09, 10500, '2023-02-28', 1),
(15, 537.77, 209.19, 10500, '2023-03-31', 1),
(16, 590.00, 221.56, 10500, '2023-04-30', 1)
;

/* Deletando dados de uma coluna */
delete from conta where id_conta = 2;

/* Selecionando somente o ano de 2022 da data_conta, com a soma de todas as contas de alugel desse período */
select year(data_conta) 'Ano 2022' , sum(conta_aluguel) 'Conta Aluguel' from conta
where year(data_conta) = 2022
group by year(data_conta);

/* Selecionando somente o ano de 2022 de todas as contas, somando todas elas desse período */
select year(data_conta) 'Todo Período' , round(sum(conta_aluguel + conta_internet + conta_energia), 2) 'Conta do Período' 
from conta
group by year(data_conta);

