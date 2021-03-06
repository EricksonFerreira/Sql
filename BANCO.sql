o que é um banco de dados? 
	É um conjunto de arquivos integrados e compartilhados que atende a um ou vários sistemas;

O que é um SGBD?
	É um software que permite o acesso ao banco de dados
	Possibilita a criação do banco de Dados e também a manipulação de dados;

O que é Modelo de Dados?
	É a representação que contém a descrição formal dos dados que estão armazenados no banco de dados;
	Informa as características dos dados;
	Não informa os dados armazenados no SGBD;

Qual a técnica  mais utilizada no modelo Conceitual?
	Modelo Entidade-Relacionamento
	Ele é representado  através do Diagrama Entidade-Relacionamento(DER);

O que são ENTIDADES no Modelo Entidade-Relacionamento?
	São as "coisas" do negócio e representam os dados genéricos do sistema;

O que são RELACIONAMENTOS no modelo Entidade-Relacionamento?
	são associações que existem entre as entidades;

O que é INSTÂNCIA ou OCORRÊNCIA no modelo Entidade-Relacionamento?
	É cada elemento de uma entidade;

-- ENTIDADE    = nome da tabela;
-- ATRIBUTOS   = atributos
-- OCORRÊNCIAS = dados salvos no banco de dados

O que é ENTIDADE FORTE e ENTIDADE FRACA?
	Entidade forte é a entidade que existe independente das outras entidades;
	Entidade fraca é a entidade que só existe se existir outra entidade relacionada;
	Ex: FORTE = Cliente e FRACA = Sócio ou Dependente

O que são cardinalidades no modelo Entidade-Relacionamento?
	É o numero (mínimo e máximo) de ocorrências de uma entidade que podem estar associadas
		a uma ocorrência de entidade, através de um relacionamento;

O que é Relacionamento Um para Um 1:1?
	Quando uma ocorrência da entidade A relaciona-se com somente uma ocorrência da entidade B e vice-versa.

O que é Relacionamento Um para Muitos 1:N?
	Quando uma ocorrência da entidade A relaciona-se com muitas ocorrência da entidade B,mas cada ocorrência
		da entidade B somente pode estar relacionada a uma ocorrência da entidade A.

O que é Relacionamento de Muitos para Muitos N:N?
	Quando uma ocorrência da entidade A relaciona-se com muitas ocorrência da entidade B e vice-versa.

Qual o modelo lógico mais utilizado?
	Relacional;

-- Modelo Lógico usa a linguagem Gráfica
-- Modelo Físico usa a linguagem Textual




DROP DATABASE IF EXISTS DML;

CREATE DATABASE DML;
USE DML;

CREATE TABLE SCP_PAISES(
	PAI_SIGLA	VARCHAR(3)  NOT NULL,
	PAI_NOME	VARCHAR(45) NOT NULL,

	PRIMARY KEY(PAI_SIGLA)
);
CREATE TABLE SCP_CIDADES(
	CID_CODIGO		INT	NOT NULL	AUTO_INCREMENT,
	CID_NOME		VARCHAR(45) NOT NULL,
	CID_PAI_SIGLA	VARCHAR(3),
	
	PRIMARY KEY(CID_CODIGO),
	CONSTRAINT FK_CID_PAI FOREIGN KEY (CID_PAI_SIGLA) REFERENCES SCP_PAISES(PAI_SIGLA)
);
CREATE TABLE SCP_FUNCOES(
	FNC_CODIGO		INT	NOT NULL	AUTO_INCREMENT,
	FNC_NOME		VARCHAR(45) NOT NULL,
	FNC_GRATIFICACOES	FLOAT(4),
	
	PRIMARY KEY(FNC_CODIGO)
);
CREATE TABLE SCP_SETORES(
	SET_SIGLA			VARCHAR(10)	NOT NULL,
	SET_NOME			VARCHAR(45) NOT NULL,
	SET_RAMAL			VARCHAR(4),
	SET_FUN_CODIGO		INT ,

	PRIMARY KEY(SET_SIGLA)
);
CREATE TABLE SCP_FUNCIONARIOS(
	FUN_CODIGO			INT	 AUTO_INCREMENT,
	FUN_NOME			VARCHAR(45) NOT NULL,
	FUN_SEXO			VARCHAR(1),
	FUN_ESTADO_CIVIL	VARCHAR(10),
	FUN_RG				VARCHAR(8),
	FUN_CPF				VARCHAR(8),
	FUN_DATA_NASC		DATETIME,
	FUN_SALARIO			FLOAT(4),
	FUN_TELEFONE		VARCHAR(15),
	FUN_EMAIL			VARCHAR(30),
	FUN_CID_CODIGO		INT,
	FUN_SET_SIGLA		VARCHAR(10),
	FUN_FNC_CODIGO		INT,

	PRIMARY KEY(FUN_CODIGO),
	CONSTRAINT FK_FUN_CID FOREIGN KEY (FUN_CID_CODIGO) REFERENCES SCP_CIDADES(CID_CODIGO),
	CONSTRAINT FK_FNC_CODIGO FOREIGN KEY (FUN_FNC_CODIGO) REFERENCES SCP_FUNCOES(FNC_CODIGO)
);
CREATE TABLE SCP_TIPOS_PRODUTO(
	TIP_CODIGO		INT	NOT NULL AUTO_INCREMENT,
	TIP_NOME		VARCHAR(20) NOT NULL,
	
	PRIMARY KEY(TIP_CODIGO)
);
CREATE TABLE SCP_PRODUTOS(
	PRO_CODIGO			INT	 NOT NULL AUTO_INCREMENT,
	PRO_NOME			VARCHAR(20) NOT NULL,
	PRO_DESCRICAO		VARCHAR(45),
	PRO_APRESENTACAO	VARCHAR(45),
	PRO_VALOR_VENDA		FLOAT(4),
	PRO_QTDE_ESTOQUE	INT,
	PRO_QTDE_MINIMA		INT,
	PRO_VALOR_COMPRA	INT,
	PRO_TIP_CODIGO		INT,

	PRIMARY KEY(PRO_CODIGO),
	CONSTRAINT FK_PRO_TIP FOREIGN KEY (PRO_TIP_CODIGO) REFERENCES SCP_TIPOS_PRODUTO(TIP_CODIGO)
);
CREATE TABLE SCP_CLIENTES(
	CLI_CODIGO		INT	NOT NULL AUTO_INCREMENT,
	CLI_NOME		VARCHAR(45) NOT NULL,
	CLI_TIPO		VARCHAR(10) NOT NULL,
	CLI_CONTATO		VARCHAR(45),
	CLI_CARGO		VARCHAR(45),
	CLI_ENDERECO	VARCHAR(45),
	CLI_CID_CODIGO	INT,
	
	PRIMARY KEY(CLI_CODIGO),
	CONSTRAINT FK_CLI_CID FOREIGN KEY (CLI_CID_CODIGO) REFERENCES SCP_CIDADES(CID_CODIGO)
);
CREATE TABLE SCP_PEDIDOS(
	PED_CODIGO		INT	NOT NULL AUTO_INCREMENT,
	PED_DATA		DATETIME NOT NULL,
	PED_FRETE		FLOAT(4),
	PED_TIPO_ENVIO	VARCHAR(20),
	PED_FUN_CODIGO	INT,
	PED_CLI_CODIGO	INT,
	
	PRIMARY KEY(PED_CODIGO),
	CONSTRAINT FK_PED_FUN FOREIGN KEY (PED_FUN_CODIGO) REFERENCES SCP_FUNCIONARIOS(FUN_CODIGO),
	CONSTRAINT FK_PED_CLI FOREIGN KEY (PED_CLI_CODIGO) REFERENCES SCP_CLIENTES(CLI_CODIGO)
);
CREATE TABLE SCP_ITENS(
	ITE_PED_CODIGO	INT,
	ITE_PRO_CODIGO	INT,
	ITE_QUANTIDADE	INT NOT NULL,
	ITE_VALOR		FLOAT(4) NOT NULL,
	
	CONSTRAINT FK_ITE_PED FOREIGN KEY (ITE_PED_CODIGO) REFERENCES SCP_PEDIDOS(PED_CODIGO),
	CONSTRAINT FK_ITE_PRO FOREIGN KEY (ITE_PRO_CODIGO) REFERENCES SCP_PRODUTOS(PRO_CODIGO),
	CONSTRAINT PK_ITE_COMP PRIMARY KEY CLUSTERED (ITE_PED_CODIGO, ITE_PRO_CODIGO)
);

ALTER TABLE SCP_FUNCIONARIOS ADD CONSTRAINT FK_FUN_SET FOREIGN KEY (FUN_SET_SIGLA) REFERENCES SCP_SETORES(SET_SIGLA);
ALTER TABLE SCP_SETORES ADD CONSTRAINT FK_SET_FUN FOREIGN KEY (SET_FUN_CODIGO) REFERENCES SCP_FUNCIONARIOS(FUN_CODIGO);

-- Atividade DML
-- 
-- 1. Não sei o que é num.ref na primeira pergunta
-- SELECT PRO_CODIGO AS 'PRODUTO', PRO_NOME AS 'PRODUTO', PRO_QTDE_ESTOQUE AS 'ESTOQUE REAL', PRO_QTDE_MINIMA AS 'ESTOQUE MINÍMO' FROM SCP_PRODUTOS;
--
-- 2. SELECT PRO_VALOR_VENDA - PRO_VALOR_COMPRA AS 'LUCRO' FROM SCP_PRODUTOS;



-- Column == Coluna == atributo
-- Table == Tabela

-- As Constraint é regra aplicada nas colunas das tabelas, 
-- 		são usadas para limitar os tipos de dados inseridos na tabela;

-- INSERT INTO
-- adicionando valores nas colunas da tabela
INSERT INTO table(column1, column2) VALUES ('value1', 'value2');

-- ALTER TABLE
-- apagar a coluna da tabela
ALTER TABLE table DROP COLUMN column1; 
-- apagar a constraint da tabela
ALTER TABLE table DROP CONSTRAINT nome_constraint;
-- adicionar uma coluna na tabela
ALTER TABLE table ADD column1 tipoColumn;
-- adicionar uma coluna na tabela e uma constraint
	ALTER TABLE table ADD column1 tipoColumn 
	 CONSTRAINT name_constraint 
	  FOREIGN KEY (nameColumnTable) 
	   	REFERENCES tableReference(columnReference);
--modificando o tipo da column
ALTER TABLE table MODIFY column typeColumn;

-- CONSTRAINT
-- adicionando uma constraint de chave estrangeira
CONSTRAINT name_constraint FOREIGN KEY (nameColumnTable) REFERENCES tableReference(columnReference);
-- adicionando uma constraint de chave primaria
CONSTRAINT name_constraint PRIMARY KEY (nameColumnTable);
-- adicionando uma constraint para deixar a columa única
CONSTRAINT name_constraint UNIQUE (nameColumnTable);

-- INNER JOIN
--pegando dados da tabela1 quando a coluna da tabela1 for igual a coluna da tabela2
SELECT columns FROM table1 INNER JOIN table2 ON table1.column = table2.column;
-- EX: SELECT nome FROM alunos INNER JOIN timeFutebol ON alunos.nome = timeFutebol.nomeAlunos;

--pegando dados da tabela1 e da tabela 2 quando a coluna da tabela1 for igual a coluna da tabela2
SELECT table1.column1, table1.column2, table3.columns 
	FROM table1 INNER JOIN table2 
		ON table1.column = table2.column;
-- EX: 	SELECT alunos.nome, alunos.idade, timeFutebol.posicao 
--			FROM alunos INNER JOIN timeFutebol 
--				ON alunos.nome = timeFutebol.nomeAlunos;

-- Join com Alias
SELECT A.column1, B.column2, table3.columns 
	FROM table1 as 'A' INNER JOIN table2 as 'B'
		ON table1.column = table2.column;
-- EX: 	SELECT Jogadores.nome, Jogadores.idade, Team.posicao 
--			FROM alunos as 'Jogadores' INNER JOIN timeFutebol as 'Team'
--				ON Jogadores.nome = Team.nomeAlunos;