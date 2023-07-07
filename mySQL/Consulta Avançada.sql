use projetoestudo;

select * from vendas;
select * from produtos;

/* Consultando e agrupando pelo id_produto e pela data_venda, o total de unidades vendidas de cada produto */
select b.id_produto, date_format(a.data_venda, '%Y/%M') as 'Mes e Ano', sum(a.quantidade_venda) 'Total'
       from vendas a inner join produtos b
       on b.id_produto = a.id_produto
       group by b.id_produto, date_format(data_venda, '%Y/%M');