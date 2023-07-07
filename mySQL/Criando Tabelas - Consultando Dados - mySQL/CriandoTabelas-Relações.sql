/* Criação da Database */
create database ProjetoEstudo;

/* Selecionar Database */
use projetoestudo;

/* Criação das tabelas com relação */
create table Empresa (
id_empresa integer primary key not null,
nome_empresa varchar(50) not null
);

/* Adicionar uma coluna em uma tabela já existente */
alter table empresa add nome_empresa varchar(50) not null after id_empresa;

/* Remover uma coluna em uma tabela já existente */
alter table empresa drop column id_empregado;
alter table empresa drop column faturamento;
alter table empresa drop column custo_total;

/* Criação das tabelas empregados */
create table Empregado(
id_empregado integer primary key not null,
nome varchar(50) not null,
sobrenome varchar(50) not null,
data_nascimento date not null,
salario double not null,
comissao double not null,
ferias bit not null,
id_empresa integer not null,
foreign key (id_empresa) references empresa(id_empresa)
);

/*Criação de relação entre tabelas já existente */
alter table empregado 
add constraint fk_empregado_empresa
foreign key (id_empregado)
references empresa(id_empresa);

/*Adicionar AUTO_INCREMENT em uma coluna existente */
alter table empregado modify column id_empregado integer auto_increment;

/* Remover uma relação em uma coluna existente */
alter table empregado
drop foreign key fk_empregado_empresa;


/*Adicionando dados nas colunas */
insert into empresa
(id_empresa, nome_empresa)
values
(1, 'Produto Variados LTDA.');

insert into empregado
(id_empregado, id_empresa, nome, sobrenome, data_nascimento, salario, comissao, ferias)
values
(1, 1, 'Laudemar', 'Tavares', '1973-04-15', 7000, 0.15, 1),
(2, 1, 'Stefany', 'Paulo', '1964-09-16', 4500, 0.05, 1),
(3, 1, 'Giovani', 'Macedo', '1980-11-06', 3500, 0.20, 1),
(4, 1, 'Elisângela', 'Figueiredo', '1990-05-12', 3500, 0.30, 0),
(5, 1, 'Italo', 'Mota', '1990-09-22', 2500, 0.20, 1);

/* Testando a relação das tabelas */
select a.nome_empresa, b.nome, b.salario
from empresa a
inner join empregado b
on a.id_empresa = b.id_empresa;













