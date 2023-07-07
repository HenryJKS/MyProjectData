






CREATE TABLE Agg_Ano_Fat (
                Cod_Ano VARCHAR(50) NOT NULL,
                ID_Vendedor INT NOT NULL,
                ID_Fabrica INT NOT NULL,
                ID_Cliente INT NOT NULL,
                ID_Produto INT NOT NULL,
                Faturamento DOUBLE PRECISION NOT NULL,
                ContadorLinha INT NOT NULL,
                PRIMARY KEY (Cod_Ano, ID_Vendedor, ID_Fabrica, ID_Cliente, ID_Produto)
);






ALTER TABLE Agg_Ano_Fat ADD CONSTRAINT dim_organizacional_agg_ano_fat_fk
FOREIGN KEY (ID_Vendedor)
REFERENCES Dim_Organizacional (ID_Vendedor)
ON DELETE NO ACTION
ON UPDATE NO ACTION;



ALTER TABLE Agg_Ano_Fat ADD CONSTRAINT dim_produto_agg_ano_fat_fk
FOREIGN KEY (ID_Produto)
REFERENCES Dim_Produto (ID_Produto)
ON DELETE NO ACTION
ON UPDATE NO ACTION;


ALTER TABLE Agg_Ano_Fat ADD CONSTRAINT dim_cliente_agg_ano_fat_fk
FOREIGN KEY (ID_Cliente)
REFERENCES Dim_Cliente (ID_Cliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION;


ALTER TABLE Agg_Ano_Fat ADD CONSTRAINT dim_fabrica_agg_ano_fat_fk
FOREIGN KEY (ID_Fabrica)
REFERENCES Dim_Fabrica (ID_Fabrica)
ON DELETE NO ACTION
ON UPDATE NO ACTION;