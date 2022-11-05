CREATE DATABASE exeClinica

GO
USE exeClinica

------------------------tabela PACIENTE-------------------------------------
CREATE TABLE Paciiente (
Num_Beneficiario	INT				NOT NULL,
Nome				VARCHAR(100)	NOT NULL,
Logradouro			VARCHAR(200)	NOT NULL,
Numero				INT				NOT NULL,
CEP					CHAR(8)			NOT NULL,
Complemento			VARCHAR(255)	NOT NULL,
Telefone			VARCHAR(11)		NOT NULL,
PRIMARY KEY(Num_Beneficiario)
)
GO
------------------------dados PACIENTE-------------------------------------
INSERT INTO Paciiente (Num_Beneficiario, Nome, Logradouro, Numero, CEP, Complemento, Telefone)
VALUES (99901, 'Washington Silva', 'R. Anhaia', 150, '02345000', 'Casa', 922229999)

INSERT INTO Paciiente (Num_Beneficiario, Nome, Logradouro, Numero, CEP, Complemento, Telefone)
VALUES (99902, 'Luis Ricardo', 'R. Voluntários da Pátria', 2251, '03254010', 'Bloco B. Apto 25', 923450987)

INSERT INTO Paciiente (Num_Beneficiario, Nome, Logradouro, Numero, CEP, Complemento, Telefone)
VALUES (99903, 'Maria Elisa', 'Av. Aguia de Haia', 1188, '06987020', 'Apto 1208', 912348765)

INSERT INTO Paciiente (Num_Beneficiario, Nome, Logradouro, Numero, CEP, Complemento, Telefone)
VALUES (99904, 'José Araujo', 'R. VX de Novembro', 18, '03678000', 'Casa', 945674312)

INSERT INTO Paciiente (Num_Beneficiario, Nome, Logradouro, Numero, CEP, Complemento, Telefone)
VALUES (99905, 'Joana Paula', 'R. 7 de Abril', 97, '01214000', 'Conjunto 3 - Apto 801', 912095674)

SELECT * FROM Paciiente
-------------------------tabela ESPECIALIDADE------------------------------
CREATE TABLE Especialidade (
ID				INT				NOT NULL,
Especialidade	VARCHAR(100)	NOT NULL,
PRIMARY KEY(ID)
)
GO
-------------------------dados ESPECIALIDADE------------------------------
INSERT INTO Especialidade (ID, Especialidade)
VALUES (1, 'Otorringolaringologista')

INSERT INTO Especialidade (ID, Especialidade)
VALUES (2, 'Urologista')

INSERT INTO Especialidade (ID, Especialidade)
VALUES (3, 'Geriatra')

INSERT INTO Especialidade (ID, Especialidade)
VALUES (4, 'Pediatra')

SELECT * FROM Especialidade
-------------------------tabela MÉDICO-------------------------------------------
CREATE TABLE Medico (
Codigo				INT				NOT NULL,
Nome				VARCHAR(100)	NOT NULL,
Logradouro			VARCHAR(200)	NOT NULL,
Numero				INT				NOT NULL,
CEP					CHAR(8)			NOT NULL,
Complemento			VARCHAR(255)	NOT NULL,
Contato				VARCHAR(11)		NOT NULL,
EspecialidadeID		INT				NOT NULL
PRIMARY KEY(Codigo)
FOREIGN KEY(EspecialidadeID)
	REFERENCES Especialidade(ID)
)
GO
-------------------------dados MÉDICO-------------------------------------------
INSERT INTO Medico (Codigo, Nome, Logradouro, Numero, CEP, Complemento, contato, EspecialidadeID)
VALUES (100001, 'Ana Paula', 'R. 7 de Setembro', 256, '03698000', 'Casa', 915689456, 1)

INSERT INTO Medico (Codigo, Nome, Logradouro, Numero, CEP, Complemento, contato, EspecialidadeID)
VALUES (100002, 'Maria Aparecida', 'Av. Brasil', 32, '02145070', 'Casa', 923235454, 1)

INSERT INTO Medico (Codigo, Nome, Logradouro, Numero, CEP, Complemento, contato, EspecialidadeID)
VALUES (100003, 'Lucas Borges', ' Av. do Estado', 3210, '05241000', 'Apto 205', 963698585, 2)

INSERT INTO Medico (Codigo, Nome, Logradouro, Numero, CEP, Complemento, contato, EspecialidadeID)
VALUES (100004, 'Gabriel Oliveira', 'Av. Dom Helder Camara', 350, '03145000', 'Apto 602', 932458745, 3)

SELECT * FROM Medico

-------------------------tabela CONSULTA-----------------------------------------
CREATE TABLE Consultaa (
PaciienteNum_Beneficiario		INT					NOT NULL,
MedicoCodigo					INT					NOT NULL,
Data_hora						DATETIME			NOT NULL,
Observacao						VARCHAR(255)		NOT NULL,					
PRIMARY KEY(PaciienteNum_Beneficiario, MedicoCodigo, Data_hora),
FOREIGN KEY(PaciienteNum_Beneficiario)
	REFERENCES Paciiente(Num_Beneficiario),
FOREIGN KEY(MedicoCodigo)
	REFERENCES Medico(Codigo),
)
GO
--------------------------dados CONSULTA----------------------------------------
INSERT INTO Consultaa (PaciienteNum_Beneficiario, MedicoCodigo, Data_hora, Observacao  )
VALUES (99901, 100002, '2021-09-04 13:20', 'Infecção Urina')

INSERT INTO Consultaa (PaciienteNum_Beneficiario, MedicoCodigo, Data_hora, Observacao  )
VALUES (99902, 100003, '2021-09-04 13:15', 'Gripe')

INSERT INTO Consultaa (PaciienteNum_Beneficiario, MedicoCodigo, Data_hora, Observacao  )
VALUES (99901, 100001, '2021-09-04 12:30', 'Infecção Garganta')

SELECT * FROM Consultaa
--------------------------adicionar dia_atendimento para MÉDICO------------
ALTER TABLE Medico
ADD dia_atendimento		VARCHAR(100)	NULL
---------------------------atualizar os dados para dia_atendimento do MEDICO------
UPDATE Medico
SET dia_atendimento = '2ª Feira'
WHERE Codigo = 100001

UPDATE Medico
SET dia_atendimento = '4ª Feira'
WHERE Codigo = 100002

UPDATE Medico
SET dia_atendimento = '2ª Feira'
WHERE Codigo = 100003

UPDATE Medico
SET dia_atendimento = '5ª Feira'
WHERE Codigo = 100004

SELECT * FROM Medico

-----------------------Pediatria indisponível, excluir-----------------------------------------------
DELETE Especialidade
WHERE ID = 4

SELECT * FROM Especialidade
-----------------------Renomear dia_atendimento para dia_semana_atendimento-----
EXEC sp_rename 'dbo.Medico.dia_atendimento',
'dia_semana_atendimento', 'column'

SELECT * FROM Medico
---------------------atualizar dados do MEDICO LUCAS---------------------------------------
UPDATE Medico
SET Logradouro = 'Av. Bras Leme'
WHERE Codigo = 100003

UPDATE Medico
SET Numero = 876
WHERE Codigo = 100003

UPDATE Medico
SET CEP = '02122000'
WHERE Codigo = 100003

UPDATE Medico
SET Complemento = 'Apto 504'
WHERE Codigo = 100003


SELECT * FROM Medico
---------------------mudar o tipo de observação------------------------------------------
ALTER TABLE Consulta
ALTER COLUMN Observacao		VARCHAR(200)	NOT NULL

