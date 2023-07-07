USE TesteLookup;

CREATE TABLE `dim_pessoa` (
	`Id_Pessoa` INT(11) NOT NULL,
	`Cod_Pessoa` VARCHAR(50) NULL DEFAULT NULL,
	`Nome_Pessoa` VARCHAR(250) NULL DEFAULT NULL,
	`Departamento` VARCHAR(250) NULL DEFAULT NULL,
	PRIMARY KEY (`Id_Pessoa`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

CREATE TABLE `dim_pessoa_data` (
	`Id_Pessoa` INT(11) NOT NULL,
	`Cod_Pessoa` VARCHAR(50) NULL DEFAULT NULL,
	`Desc_Pessoa` VARCHAR(250) NULL DEFAULT NULL,
	`Departamento` VARCHAR(250) NULL DEFAULT NULL,
	`Versao` INT(11) NULL DEFAULT NULL,
	`Data_Inicial` DATE NULL DEFAULT NULL,
	`Data_Final` DATE NULL DEFAULT NULL,
	PRIMARY KEY (`Id_Pessoa`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

CREATE TABLE `dim_pessoa_incremento` (
	`Id_Pessoa` INT(11) NOT NULL AUTO_INCREMENT,
	`Cod_Pessoa` VARCHAR(50) NULL DEFAULT '0',
	`Nome_Pessoa` VARCHAR(250) NULL DEFAULT '0',
	`Departamento` VARCHAR(250) NULL DEFAULT '0',
	PRIMARY KEY (`Id_Pessoa`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=6
;

CREATE TABLE `fato` (
	`Id_Pessoa` INT(11) NOT NULL,
	`Data` DATE NOT NULL,
	`Valor` DOUBLE NULL DEFAULT NULL,
	PRIMARY KEY (`Id_Pessoa`, `Data`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

CREATE TABLE `fato_data` (
	`Id_Pessoa` INT(11) NOT NULL,
	`Data` DATE NOT NULL,
	`Valor` FLOAT NULL DEFAULT NULL,
	PRIMARY KEY (`Id_Pessoa`, `Data`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

CREATE TABLE `fato_incremento` (
	`Id_Pessoa` INT(11) NOT NULL,
	`Data` DATE NOT NULL,
	`Valor` DOUBLE NULL DEFAULT NULL,
	PRIMARY KEY (`Id_Pessoa`, `Data`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;
