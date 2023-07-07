use projetoestudo;


/* Criação da tabela produtos */
create table Produtos (
id_produto int auto_increment primary key not null,
nome_produto varchar(50) not null,
preço_produto double not null,
unidades_disponivel int not null,
id_empresa int not null,
foreign key (id_empresa )references empresa(id_empresa)
);

/* Renomeando uma coluna */
alter table produtos rename column preço_produto to preco_produto;

/* Inserindo dados com auto_increment */
insert into Produtos (
nome_produto, preco_produto, unidades_disponivel, id_empresa)
values
("Conector 1 Via", 13, 100, 1),
("Conector 2 Vias", 24, 200, 1),
("Conector 3 Vias", 33, 150, 1),
("Conector 4 Vias", 44, 150, 1),
("Conector 5 Vias", 52, 220, 1),
("Conector 6 Vias", 62, 170, 1),
("Conector 7 Vias", 72, 100, 1),
("Conector 8 Vias", 82, 120, 1),
("Conector 9 Vias", 92, 200, 1),
("Conector 10 Vias", 102, 90, 1);

select * from produtos;
