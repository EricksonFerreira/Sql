DROP DATABASE IF EXISTS CLINICA;
CREATE DATABASE CLINICA;
USE CLINICA;

CREATE TABLE QUARTO(
 QRT_CODIGO INT NOT NULL AUTO_INCREMENT,
 QRT_NUMERO VARCHAR(5) NOT NULL,
 QRT_ANDAR VARCHAR(3) NOT NULL,
 PRIMARY KEY (QRT_CODIGO)
);
CREATE TABLE ESPECIALIDADES(
 ESP_CODIGO INT NOT NULL AUTO_INCREMENT,
 ESP_MED_CRM INT NOT NULL,
 ESP_NOME VARCHAR(45) NOT NULL,
 PRIMARY KEY (ESP_CODIGO)
);
CREATE TABLE MEDICO(
 MED_CRM INT NOT NULL AUTO_INCREMENT,
 MED_NOME VARCHAR(45) NOT NULL,
 MED_DATASALARIO DATETIME NOT NULL,
 MED_SALARIO FLOAT NOT NULL,
 MED_ESP_CODIGO INT NOT NULL,
 PRIMARY KEY (MED_CRM),
 CONSTRAINT FK_MED_ESP FOREIGN KEY (MED_ESP_CODIGO) REFERENCES ESPECIALIDADES(ESP_CODIGO)
);
CREATE TABLE PACIENTE(
 PAC_CPF VARCHAR(20) NOT NULL,
 PAC_NOME VARCHAR(45) NOT NULL,
 PAC_RG VARCHAR(20) NOT NULL,
 PAC_ENDERECO VARCHAR(45) NOT NULL,
 PAC_TELEFONE VARCHAR(20) NOT NULL,
 PAC_DATANASCIMENTO VARCHAR(12) NOT NULL,
 PAC_QRT_CODIGO INT NOT NULL,
 PRIMARY KEY(PAC_CPF),
 CONSTRAINT FK_PAC_QRT FOREIGN KEY (PAC_QRT_CODIGO) REFERENCES QUARTO(QRT_CODIGO)
);
CREATE TABLE CONSULTA(
 CON_CODIGO INT NOT NULL AUTO_INCREMENT,
 CON_DATA DATETIME NOT NULL,
 CON_MED_CRM INT NOT NULL,
 CON_PAC_CPF VARCHAR(20) NOT NULL,
 PRIMARY KEY (CON_CODIGO),
 CONSTRAINT FK_CON_MED FOREIGN KEY (CON_MED_CRM) REFERENCES MEDICO(MED_CRM),
 CONSTRAINT FK_CON_PAC FOREIGN KEY (CON_PAC_CPF) REFERENCES PACIENTE(PAC_CPF)
);

-- =============================================X=============================
-- =============================================X=============================
-- =============================================X=============================
-- =============================================X=============================
-- =============================================X=============================
-- =============================================X=============================

DROP DATABASE IF EXISTS CLINICA_VETERINARIA;
CREATE DATABASE CLINICA_VETERINARIA;
USE CLINICA_VETERINARIA;

CREATE TABLE ANIMAIS(
 ANI_CODIGO INT NOT NULL AUTO_INCREMENT,
 ANI_NOME VARCHAR(30) NOT NULL,
 ANI_RACA VARCHAR(20) NOT NULL,
 ANI_COR VARCHAR(12) NOT NULL,
 PRIMARY KEY (ANI_CODIGO)
);
CREATE TABLE CLIENTE(
 CLI_CPF VARCHAR(20) NOT NULL,
 CLI_NOME VARCHAR(45) NOT NULL,
 CLI_ENDERECO VARCHAR(45) NOT NULL,
 CLI_TELEFONE VARCHAR(20) NOT NULL,
 CLI_ANI_CODIGO INT NOT NULL,
 PRIMARY KEY(CLI_CPF),
 CONSTRAINT FK_CLI_ANI FOREIGN KEY (CLI_ANI_CODIGO) REFERENCES ANIMAIS(ANI_CODIGO)
);
CREATE TABLE ATENDENTE(
  ATE_CPF VARCHAR(20) NOT NULL,
  ATE_NOME VARCHAR(45) NOT NULL,
  ATE_RG VARCHAR(20) NOT NULL,
  ATE_MATRICULA VARCHAR(15) NOT NULL,
  ATE_ENDERECO VARCHAR(45) NOT NULL,
  SALARIO FLOAT NOT NULL,
  PRIMARY KEY(ATE_CPF)
);
CREATE TABLE MEDICO(
 MED_CPF VARCHAR(20) NOT NULL,
 MED_NOME VARCHAR(45) NOT NULL,
 MED_ENDERECO VARCHAR(25) NOT NULL,
 MED_TELEFONE VARCHAR(15) NOT NULL,
 PRIMARY KEY (MED_CPF)
);
CREATE TABLE TECNICO(
 TEC_CPF VARCHAR(20) NOT NULL,
 TEC_NOME VARCHAR(45) NOT NULL,
 TEC_ENDERECO VARCHAR(25) NOT NULL,
 TEC_TELEFONE VARCHAR(15) NOT NULL,
 PRIMARY KEY (TEC_CPF)
);
CREATE TABLE CONSULTA_NORMAL(
 CON_CODIGO INT NOT NULL AUTO_INCREMENT,
 CON_DATA DATETIME NOT NULL,
 CON_TEC_CPF VARCHAR(20) NOT NULL,
 CON_MED_CPF VARCHAR(20) NOT NULL,
 CON_ANI_CODIGO INT NOT NULL,
 PRIMARY KEY (CON_CODIGO),
 CONSTRAINT FK_CON_MED FOREIGN KEY (CON_MED_CPF) REFERENCES MEDICO(MED_CPF),
 CONSTRAINT FK_CON_TEC FOREIGN KEY (CON_TEC_CPF) REFERENCES TECNICO(TEC_CPF),
 CONSTRAINT FK_CON_ANI FOREIGN KEY (CON_ANI_CODIGO) REFERENCES ANIMAIS(ANI_CODIGO)
);
CREATE TABLE CIRURGIA(
 CIR_CODIGO INT NOT NULL AUTO_INCREMENT,
 CIR_DATA DATETIME NOT NULL,
 CIR_MED_CPF VARCHAR(20) NOT NULL,
 CIR_ANI_CODIGO INT NOT NULL,
 PRIMARY KEY (CIR_CODIGO),
 CONSTRAINT FK_CIR_MED FOREIGN KEY (CIR_MED_CPF) REFERENCES MEDICO(MED_CPF),
 CONSTRAINT FK_CIR_ANI FOREIGN KEY (CIR_ANI_CODIGO) REFERENCES ANIMAIS(ANI_CODIGO)
);
CREATE TABLE AGENDAMENTO(
 AGE_CODIGO INT NOT NULL AUTO_INCREMENT,
 AGE_DATA DATETIME NOT NULL,
 AGE_CLI_CPF VARCHAR(20) NOT NULL,
 AGE_ATE_CPF VARCHAR(20) NOT NULL,
 PRIMARY KEY (AGE_CODIGO),
 CONSTRAINT FK_AGE_CLI FOREIGN KEY (AGE_CLI_CPF) REFERENCES CLIENTE(CLI_CPF),
 CONSTRAINT FK_AGE_ATE FOREIGN KEY (AGE_ATE_CPF) REFERENCES ATENDENTE(ATE_CPF)
);

-- =============================================X=============================
-- =============================================X=============================
-- =============================================X=============================
-- =============================================X=============================
-- =============================================X=============================
-- =============================================X=============================

DROP DATABASE IF EXISTS ZOOLOGICO;
CREATE DATABASE ZOOLOGICO;
USE ZOOLOGICO;

CREATE TABLE BIOLOGO(
 BIO_CPF VARCHAR(15) NOT NULL,
 BIO_NOME VARCHAR(45) NOT NULL,
 PRIMARY KEY(BIO_CPF)
);
CREATE TABLE SETORES(
 SET_CODIGO INT NOT NULL,
 SET_AREA VARCHAR(45) NOT NULL,
 SET_BIO_CPF VARCHAR(15) NOT NULL,
 PRIMARY KEY(SET_CODIGO),
 CONSTRAINT FK_SET_BIO FOREIGN KEY (SET_BIO_CPF) REFERENCES BIOLOGO(BIO_CPF)
);
CREATE TABLE JAULA(
 JAU_CODIGO INT NOT NULL,
 JAU_AREA VARCHAR(45) NOT NULL,
 JAU_SET_CODIGO INT NOT NULL,
 PRIMARY KEY(JAU_CODIGO),
 CONSTRAINT FK_JAU_SET FOREIGN KEY (JAU_SET_CODIGO) REFERENCES SETORES(SET_CODIGO)
);
CREATE TABLE ANIMAIS(
 ANI_CODIGO INT NOT NULL AUTO_INCREMENT,
 ANI_NOME VARCHAR(20) NOT NULL,
 ANI_ESPECIE VARCHAR(15) NOT NULL,
 ANI_PESO FLOAT NOT NULL,
 ANI_REGIAO VARCHAR(15) NOT NULL,
 ANI_DATANASC DATETIME NOT NULL,
 ANI_JAU_CODIGO INT NOT NULL,
 PRIMARY KEY (ANI_CODIGO),
 CONSTRAINT FK_ANI_JAU FOREIGN KEY (ANI_JAU_CODIGO) REFERENCES JAULA(JAU_CODIGO)
);