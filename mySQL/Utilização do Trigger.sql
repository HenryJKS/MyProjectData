use projetoestudo;


/* Criação da tabela venda alterando o default da data_venda */
create table Vendas (
id_venda integer primary key not null,
quantidade_venda integer not null,
data_venda date not null,
id_produto integer not null,
foreign key (id_produto) references produtos(id_produto)
);

/* Criação de uma tabela axuilidar de vendas, onde posso aplicar o Trigger */
create table aux_venda (
data_venda date not null,
total_venda double not null
);

/* Inserindo valores na tabela Vendas */
insert into Vendas (
id_venda, quantidade_venda, data_venda, id_produto)
values
(3, 5, '2023-02-01', 4);

/* Criação Trigger, a função é agrupar o total de vendas em R$ pela data a cada Insert */
DELIMITER //
create trigger TG_Calcula_Vendas after insert on vendas
for each row begin
delete from aux_data;

insert into aux_data
select data_venda, sum(quantidade_venda * preco_produto) from 
vendas a inner join produtos b
on
a.id_produto = b.id_produto
group by data_venda;

end //

/* Criação Trigger, a função é agrupar o total de vendas em R$ pela data a cada Delete */
DELIMITER //
create trigger TG_Calcula_Vendas after delete on vendas
for each row begin
delete from aux_data;

insert into aux_data
select data_venda, sum(quantidade_venda * preco_produto) from 
vendas a inner join produtos b
on
a.id_produto = b.id_produto
group by data_venda;

end //

/* Select na tabela agrupando em Ano */
select year(data_venda), sum(total_venda)
from aux_venda
group by year(data_venda);



