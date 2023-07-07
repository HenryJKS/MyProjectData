CREATE TABLE [dbo].[Dim_Cliente]
(
	[Cod_Cliente] NVARCHAR(50) NOT NULL PRIMARY KEY, 
    [Desc_Cliente] NCHAR(200) NULL, 
    [Cod_Cidade] NCHAR(50) NULL, 
    [Desc_Cidade] NCHAR(200) NULL,
     [Cod_Estado] NCHAR(50) NULL, 
    [Desc_Estado] NCHAR(200) NULL,
     [Cod_Regiao] NCHAR(50) NULL, 
    [Desc_Regiao] NCHAR(200) NULL,
     [Cod_Segmento] NCHAR(50) NULL, 
    [Desc_Segmento] NCHAR(200) NULL
)
