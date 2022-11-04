CREATE DATABASE Projeto
GO
USE Projeto
GO

CREATE TABLE users (
id						INT		IDENTITY(1, 1)						NOT NULL,
nome					VARCHAR(45)									NOT NULL,
username				VARCHAR(45)									NOT NULL,
senha					VARCHAR(45)	DEFAULT('123mudar')				NOT NULL,
email					VARCHAR(45)									NOT NULL
PRIMARY KEY (id)
)
GO

CREATE TABLE projects (
id						INT IDENTITY (10001, 1)						NOT NULL,
nome					VARCHAR(45)									NOT NULL,
descricao				VARCHAR(45)									NULL,
dataa					DATE CHECK(dataa > '20140901')				NOT NULL,
PRIMARY KEY (id)
)
GO

CREATE TABLE users_has_projects (
users_id				INT											NOT NULL,
projects_id				INT											NOT NULL
PRIMARY KEY (users_id, projects_id)
FOREIGN KEY (users_id)		REFERENCES users(id),
FOREIGN KEY (projects_id)	REFERENCES projects(id)
)
GO


ALTER TABLE users
ALTER COLUMN username VARCHAR(10)									NOT NULL 
GO

ALTER TABLE users
ADD CONSTRAINT UQ__users__F3DBC572E4506E57 UNIQUE(username)
GO

ALTER TABLE users
ALTER COLUMN senha	  VARCHAR(8)									NOT NULL 
GO


EXEC sp_help users
EXEC sp_help projects
EXEC sp_help users_has_projects

DBCC CHECKIDENT('users' , RESEED, 1)
GO

INSERT INTO users (id, nome, username, senha, email)
VALUES 
(1, 'Maria', 'Rh_maria', '123mudar', 'maria@empresa.com'),
(2, 'Paulo', 'Ti_paulo', '123@456', 'paulo@empresa.com'),
(3, 'Ana', 'Rh_ana', '123mudar', 'ana@empresa.com'),
(4, 'Clara', 'Ti_clara', '123mudar', 'clara@empresa.com'),
(5, 'Aparecido', 'Rh_apareci', '55@!cido', 'aparecido@empresa.com')
GO

DBCC CHECKIDENT('projects', RESEED, 10001)
GO
INSERT INTO	projects (id, nome, descricao, dataa)
VALUES
(10001, 'Re-folha', 'Refatora��o das folhas', '05/09/2014'),
(10002, 'Manuten��o PCs ', 'Manuten��o PCs', '06/09/2014'),
(10003, 'Auditoria', '', '07/09/2014')
GO

INSERT INTO users_has_projects (users_id, projects_id)
VALUES
(1, 10001),
(5, 10001),
(3, 10003),
(4, 10002),
(2, 10002)
GO


SELECT * FROM users
SELECT * FROM projects
SELECT * FROM users_has_projects




UPDATE projects
SET dataa = '12/09/2014'
WHERE id = 10002

UPDATE users
SET username = 'Rh_cido'
WHERE id = 5

UPDATE users
SET senha = '888@*'
WHERE id = 1 AND senha = '123mudar'

DELETE users_has_projects
WHERE users_id = 2

SELECT * FROM users
SELECT * FROM projects
SELECT * FROM users_has_projects

INSERT INTO users
VALUES (6, 'Jo�o', 'TI_joao', '123mudar', 'joao@empresa.com')
GO

INSERT INTO projects
VALUES (10004, 'Atualiza��o de Sistemas' , 'Modifica��o de Sistemas Operacionais nos PCs' , '12/09/2014')
GO

SELECT DISTINCT us.id, us.nome, us.email, pj.id, pj.nome, pj.descricao, pj.dataa
FROM users us, projects pj, users_has_projects uspj
WHERE us.id = uspj.users_id
	  and pj.id = uspj.projects_id
	  and pj.nome = 'Re-folha'

SELECT DISTINCT pj.nome
FROM projects pj, users_has_projects uspj
WHERE pj.id = uspj.projects_id
		AND uspj.users_id IS NULL

SELECT us.nome
FROM users us, users_has_projects uspj
WHERE us.id = uspj.users_id
		AND uspj.projects_id IS NULL

use master
drop database Projeto