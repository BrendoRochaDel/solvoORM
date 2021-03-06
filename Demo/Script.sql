CREATE TABLE TBLPES (
    CODPES  INTEGER NOT NULL,
    TIPPES  CHAR(1) NOT NULL,
    NOMPES  VARCHAR(100),
    INSPES  VARCHAR(15)
);

ALTER TABLE TBLPES ADD CONSTRAINT PK_TBLPES PRIMARY KEY (CODPES, TIPPES);

/* Trigger: TRGPES */
CREATE OR ALTER TRIGGER TRGPES FOR TBLPES
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
 IF  (COALESCE(NEW.CODPES, 0) = 0) THEN
  BEGIN
   SELECT MAX(CODPES) + 1
   FROM TBLPES
   INTO  NEW.CODPES;
   IF (NEW.CODPES IS NULL) THEN
    NEW.CODPES = 1;
  END
END;

COMMENT ON TABLE TBLPES IS 
'Tabela Pessoa';

COMMENT ON COLUMN TBLPES.CODPES IS 
'Codigo Pessoa';

COMMENT ON COLUMN TBLPES.TIPPES IS 
'Tipo Pessoa';

COMMENT ON COLUMN TBLPES.NOMPES IS 
'Nome Pessoa';

COMMENT ON COLUMN TBLPES.INSPES IS 
'Inscricao Pessoa';

CREATE TABLE TBLCTT (
    MATEPGCTT  INTEGER NOT NULL,
    CODPES     INTEGER NOT NULL,
    TIPPES     CHAR(1) NOT NULL,
    DTAADMCTT  DATE,
    SALCTT     NUMERIC(12,2)
);

ALTER TABLE TBLCTT ADD CONSTRAINT PK_TBLCTT PRIMARY KEY (MATEPGCTT);

ALTER TABLE TBLCTT ADD CONSTRAINT FK_TBLCTT_1 FOREIGN KEY (CODPES, TIPPES) REFERENCES TBLPES (CODPES, TIPPES)

CREATE OR ALTER TRIGGER TRGCTT FOR TBLCTT
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
 IF  (COALESCE(NEW.MATEPGCTT, 0) = 0) THEN
  BEGIN
   SELECT MAX(MATEPGCTT) + 1
   FROM TBLCTT
   INTO  NEW.MATEPGCTT;
   IF (NEW.MATEPGCTT IS NULL) THEN
    NEW.MATEPGCTT = 1;
  END
END;

COMMENT ON TABLE TBLCTT IS 
'Tabela Contrato';

COMMENT ON COLUMN TBLCTT.MATEPGCTT IS 
'Matricula Empregado Contrato';

COMMENT ON COLUMN TBLCTT.CODPES IS 
'Codigo Pessoa';

COMMENT ON COLUMN TBLCTT.TIPPES IS 
'Tipo Pessoa';

COMMENT ON COLUMN TBLCTT.DTAADMCTT IS 
'Data Admissao Contrato';

COMMENT ON COLUMN TBLCTT.SALCTT IS 
'Salario Contrato';

CREATE TABLE TBLDEP (
    CODPES     INTEGER NOT NULL,
    TIPPES     CHAR(1) NOT NULL,
    MATEPGRES  INTEGER NOT NULL,
    IDADEP     INTEGER,
    PARDEP     INTEGER
);

ALTER TABLE TBLDEP ADD CONSTRAINT PK_TBLDEP PRIMARY KEY (CODPES, TIPPES, MATEPGRES);

ALTER TABLE TBLDEP ADD CONSTRAINT FK_TBLDEP_1 FOREIGN KEY (CODPES, TIPPES) REFERENCES TBLPES (CODPES, TIPPES);
ALTER TABLE TBLDEP ADD CONSTRAINT FK_TBLDEP_2 FOREIGN KEY (MATEPGRES) REFERENCES TBLCTT (MATEPGCTT);

COMMENT ON TABLE TBLDEP IS 
'Tabela Dependente';

COMMENT ON COLUMN TBLDEP.CODPES IS 
'Codigo Pessoa';

COMMENT ON COLUMN TBLDEP.TIPPES IS 
'Tipo Pessoa';

COMMENT ON COLUMN TBLDEP.MATEPGRES IS 
'Matricula Empregado Responsavel';

COMMENT ON COLUMN TBLDEP.IDADEP IS 
'Idade Dependente';

COMMENT ON COLUMN TBLDEP.PARDEP IS 
'Parentesco Dependente';
