-- *** CRIAÇÃO DE TABELAS ***
CREATE TABLE PESSOA(
  CPF VARCHAR(11) CONSTRAINT NN_CPF_PESSOA NOT NULL UNIQUE,
  NOME VARCHAR(80),
  NASCIMENTO DATE,
  END_RUA VARCHAR(80),
  END_BAIRRO VARCHAR(80),
  END_CIDADE VARCHAR(80),
  
  CONSTRAINT PK_PESSOA PRIMARY KEY(CPF)
);

CREATE TABLE EMPRESA(
  CNPJ VARCHAR(20) CONSTRAINT NN_CNPJ_EMPRESA NOT NULL UNIQUE,
  NOME VARCHAR(80) NOT NULL,
  FUNDACAO DATE,
  
  CONSTRAINT PK_EMPRESA PRIMARY KEY(CNPJ)
);

CREATE TABLE SETOR(
  COD VARCHAR(20) CONSTRAINT NN_COD_SETOR NOT NULL UNIQUE,
  CNPJ_EMPRESA VARCHAR(20) CONSTRAINT NN_CNPJ_EMPRESA NOT NULL,
  NOME VARCHAR(100),
  
  CONSTRAINT PK_SETOR PRIMARY KEY(COD),
  CONSTRAINT FK_EMPRESA FOREIGN KEY (CNPJ_EMPRESA) REFERENCES EMPRESA(CNPJ) ON DELETE CASCADE,
  CONSTRAINT AK_SETOR_EMPRESA UNIQUE (NOME, CNPJ_EMPRESA)
);

CREATE TABLE BOLSA_DE_VALORES(
  COD VARCHAR(20) CONSTRAINT NN_COD_BOLSA NOT NULL UNIQUE,
  PAIS VARCHAR(60),
  FUNDACAO DATE,
  
  CONSTRAINT PK_BOLSA PRIMARY KEY(COD)
);


CREATE TABLE ACAO(
  COD VARCHAR(20) CONSTRAINT NN_COD_ACAO NOT NULL UNIQUE,
  ORD_COD NUMBER,
  CNPJ_EMPRESA VARCHAR(20),
  CPF_DONO VARCHAR(11),
  PRECO NUMBER(6,2) NOT NULL,
  
  CONSTRAINT PK_ACAO PRIMARY KEY(COD),
  CONSTRAINT FK_EMPRESA FOREIGN KEY (CNPJ_EMPRESA) REFERENCES EMPRESA(CNPJ) ON DELETE CASCADE,
  CONSTRAINT FK_DONO_ACAO FOREIGN KEY (CPF_DONO) REFERENCES PESSOA(CPF),
  CONSTRAINT AK_ORD_EMPRESA UNIQUE (ORD_COD, CNPJ_EMPRESA)
);

CREATE TABLE ACAO_PREFERENCIAL(
  COD VARCHAR(20) CONSTRAINT NN_COD_ACAO_PREF NOT NULL UNIQUE,
  COD_ACAO VARCHAR(20),
  CLASSE VARCHAR(40),
  
  CONSTRAINT PK_ACAO_PREFERENCIAL PRIMARY KEY(COD),
  CONSTRAINT FK_ACAO FOREIGN KEY (COD_ACAO) REFERENCES ACAO(COD) ON DELETE CASCADE
);

CREATE TABLE ACAO_ORDINARIA(
  COD VARCHAR(20) CONSTRAINT NN_COD_ACAO_ORD NOT NULL UNIQUE,
  COD_ACAO VARCHAR(20),
  
  CONSTRAINT PK_ACAO_ORDINARIA PRIMARY KEY(COD),
  CONSTRAINT FK_ACAO FOREIGN KEY (COD_ACAO) REFERENCES ACAO(COD) ON DELETE CASCADE
);

CREATE TABLE CONTROLE_EMPRESA(
  COD VARCHAR(20) CONSTRAINT NN_COD_CONTROLE NOT NULL UNIQUE,
  CNPJ_CONTROLADORA VARCHAR(20),
  CNPJ_CONTROLADA VARCHAR(20),
  
  CONSTRAINT PK_CONTROLE_EMPRESA PRIMARY KEY(COD),
  CONSTRAINT FK_EMPRESA_CONTROLADORA FOREIGN KEY (CNPJ_CONTROLADORA) REFERENCES EMPRESA(CNPJ) ON DELETE CASCADE,
  CONSTRAINT FK_EMPRESA_CONTROLADA FOREIGN KEY (CNPJ_CONTROLADA) REFERENCES EMPRESA(CNPJ) ON DELETE CASCADE
);

CREATE TABLE PARTICIPA_EMPRESA(
  COD VARCHAR(20) CONSTRAINT NN_COD_PARTICIPA NOT NULL UNIQUE,
  CNPJ_EMPRESA VARCHAR(20),
  CPF_PESSOA VARCHAR(11),
  CARGO VARCHAR(50),
  TIPO VARCHAR(50),
  
  CONSTRAINT PK_PARTICIPA_EMPRESA PRIMARY KEY(COD),
  CONSTRAINT FK_EMPRESA_PARTICIPA FOREIGN KEY (CNPJ_EMPRESA) REFERENCES EMPRESA(CNPJ) ON DELETE CASCADE,
  CONSTRAINT FK_PESSOA_PARTICIPA FOREIGN KEY (CPF_PESSOA) REFERENCES PESSOA(CPF) ON DELETE CASCADE,
  CONSTRAINT AK_PESSOA_EMPRESA UNIQUE (CNPJ_EMPRESA, CPF_PESSOA)
);

CREATE TABLE NEGOCIA_ACAO(
  COD VARCHAR(20) CONSTRAINT NN_COD_NEGOCIA NOT NULL UNIQUE,
  COD_ACAO VARCHAR(20),
  CPF_PESSOA VARCHAR(11),
  INSTANTE DATETIME,
  TAXA NUMBER(3,2),
  COD_BOLSA VARCHAR(20),
  
  CONSTRAINT PK_NEGOCIA_ACAO PRIMARY KEY(COD),
  CONSTRAINT FK_ACAO_NEGOCIA FOREIGN KEY (COD_ACAO) REFERENCES ACAO(COD) ON DELETE CASCADE,
  CONSTRAINT FK_PESSOA_NEGOCIA FOREIGN KEY (CPF_PESSOA) REFERENCES PESSOA(CPF) ON DELETE CASCADE,
  CONSTRAINT FK_BOLSA_NEGOCIA FOREIGN KEY (COD_BOLSA) REFERENCES BOLSA_DE_VALORES(COD),
  CONSTRAINT AK_PESSOA_ACAO UNIQUE (COD_ACAO, CPF_PESSOA, COD_BOLSA)
);


-- *** INSERÇÃO DE DADOS EM TABELAS ***
INSERT INTO PESSOA VALUES ("07032769489", "EDUARDO", "1999-05-07", "SEBASTIÃO DE ALENCASTRO SALAZAR", "VÁRZEA", "RECIFE");
INSERT INTO PESSOA VALUES ("07032669489", "FERNANDO", "1999-05-02", "AV AFONSO OLINDENSE", "VÁRZEA", "RECIFE");
INSERT INTO PESSOA VALUES ("07232669489", "VICTOR", "1999-05-21", "RUA 25 DE MARÇO", "ALTO DO AÇUDE", "PAU DOS FERROS");
INSERT INTO PESSOA VALUES ("77232669489", "JUAN", "1999-05-21", "RUA TAL", "ALTO DO AÇUDE", "OLINDA");

INSERT INTO EMPRESA VALUES ("4156151215452", "APPLE", "2005-05-21");
INSERT INTO EMPRESA VALUES ("5156151215452", "GOOGLE", "2007-05-21");
INSERT INTO EMPRESA VALUES ("8156151215452", "ALPHABET", "2008-05-21");

INSERT INTO CONTROLE_EMPRESA VALUES ("1", "8156151215452", "5156151215452");

INSERT INTO PARTICIPA_EMPRESA VALUES ("1", "4156151215452", "07032769489", "CEO", "SOCIO");
INSERT INTO PARTICIPA_EMPRESA VALUES ("2", "4156151215452", "07032669489", "ENGENHEIRO DE SOFTWARE", "TERCEIRIZADO");
INSERT INTO PARTICIPA_EMPRESA VALUES ("3", "5156151215452", "07232669489", "CTO", "SOCIO");

INSERT INTO ACAO VALUES ("1", "1", "8156151215452", "07032769489", 120.50);
INSERT INTO ACAO VALUES ("2", "1", "5156151215452", "07032769489", 110.20);
INSERT INTO ACAO VALUES ("3", "2", "5156151215452", "07232669489", 110.20);

INSERT INTO BOLSA_DE_VALORES VALUES ("1", "BRASIL", "2021-12-20");
 
INSERT INTO NEGOCIA_ACAO VALUES ("1", "1", "07032669489", "2021-12-20 12:20:03", 3.5, "1");
INSERT INTO NEGOCIA_ACAO VALUES ("2", "1", "07232669489", "2021-12-20 12:20:03", 3.5, "1");
INSERT INTO NEGOCIA_ACAO VALUES ("3", "1", "77232669489", "2021-12-20 12:20:03", 3.5, "1");
  
DELETE FROM NEGOCIA_ACAO WHERE COD = "3";


-- *** CONSULTAS ***

-- CONSULTA SIMPLES
SELECT * FROM PESSOA;
SELECT * FROM ACAO;

-- OBTEM NUMERO DE PESSOAS POR - CONSULTA COM GROUP BY/HAVING
SELECT END_CIDADE, COUNT(NOME) AS NUM_PESSOAS FROM PESSOA GROUP BY END_CIDADE;

-- OBTEM EMPRESAS QUE SÃO HOLDINGS (CONTROLADAS POR OUTRA EMPRESA) - CONSULTA COM JUNÇÃO INTERNA
SELECT A.NOME AS NOME_HOLDING FROM EMPRESA A
  INNER JOIN CONTROLE_EMPRESA B ON A.CNPJ = B.CNPJ_CONTROLADORA;

-- OBTEM EMPRESAS QUE NÃO TEM NENHUMA EMPRESA QUE CONTROLA ELAS - CONSULTA COM JUNÇÃO EXTERNA
SELECT A.NOME AS NOME_EMPRESA FROM EMPRESA A
  LEFT Outer JOIN CONTROLE_EMPRESA B ON A.CNPJ = B.CNPJ_CONTROLADA
  WHERE B.CNPJ_CONTROLADORA IS NULL;

-- OBTEM AÇÕES COM PREÇO ACIMA DA MÉDIA - CONSULTA COM SUBCONSULTA ESCALAR
SELECT COD, PRECO FROM ACAO WHERE PRECO > (SELECT AVG(PRECO) FROM ACAO);

-- OBTEM PESSOAS QUE POSSUEM AÇÕES EM HOLDINGS - CONSULTA COM SUBCONSULTA TABELA
SELECT CPF, NOME FROM PESSOA WHERE CPF IN (SELECT CPF_DONO FROM ACAO A INNER JOIN CONTROLE_EMPRESA C ON A.CNPJ_EMPRESA = C.CNPJ_CONTROLADORA);

-- OBTEM PESSOAS DO MESMO BAIRRO QUE O USUÁRIO DE CPF 07032769489 - CONSULTA COM SUBCONSULTA LINHA
SELECT * FROM PESSOA WHERE (END_BAIRRO, END_CIDADE) = (SELECT END_BAIRRO, END_CIDADE FROM PESSOA WHERE CPF = "07032769489");

-- OBTEM CIDADES ONDE PELO MENOS UMA PESSOA TEM UMA AÇÃO - CONSULTA COM SEMI JUNÇÃO
SELECT P.END_CIDADE FROM PESSOA P WHERE EXISTS (SELECT * FROM ACAO A WHERE A.CPF_DONO = P.CPF);

-- OBTEM PESSOAS QUE NÃO TRABALHAM EM NENHUMA EMPRESA - CONSULTA COM ANTI JUNÇÃO
SELECT P.* FROM PESSOA P WHERE NOT EXISTS (SELECT * FROM PARTICIPA_EMPRESA PE WHERE P.CPF = PE.CPF_PESSOA);

-- OBTEM CPF DE PESSOAS QUE TRABALHAM EM UMA EMPRESA OU POSSUEM UMA AÇÃO - CONSULTA COM OPERAÇÃO DE CONJUNTOS
SELECT CPF_PESSOA FROM PARTICIPA_EMPRESA
  UNION
  SELECT CPF_DONO AS CPF_PESSOA FROM ACAO;

-- *** PROCEDIMENTOS PL/SQL ***
-- PROCEDIMENTO PARA AUMENTAR EM 5% O VALOR DE UMA AÇÃO CASO UMA NOVA NEGOCIAÇÃO SEJA CRIADA
CREATE TRIGGER VALORIZA_ACAO_TRIGGER
  AFTER INSERT ON NEGOCIA_ACAO
  FOR EACH ROW
BEGIN
  UPDATE ACAO SET PRECO = PRECO * 1.05
  WHERE COD = NEW.COD_ACAO;
END;

-- PROCEDIMENTO PARA REDUZIR EM 5% O VALOR DE UMA AÇÃO CASO UMA NOVA NEGOCIAÇÃO SEJA CRIADA
CREATE TRIGGER DESVALORIZA_ACAO_TRIGGER
  AFTER DELETE ON NEGOCIA_ACAO
  FOR EACH ROW
BEGIN
  UPDATE ACAO SET PRECO = PRECO * 0.95
  WHERE COD = OLD.COD_ACAO;
END;