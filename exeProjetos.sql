CREATE DATABASE Projeto
GO
USE Projeto
GO

CREATE TABLE users (
id						INT		IDENTITY							NOT NULL,
nome					VARCHAR(45)									NOT NULL,
username				VARCHAR(45) UNIQUE							NOT NULL,
senha					VARCHAR(45)	DEFAULT('123mudar')				NOT NULL,
email					VARCHAR(45)									NOT NULL
PRIMARY KEY (id)
)
GO

CREATE TABLE projects (
id						INT IDENTITY (10001, 1)						NOT NULL,
nome					VARCHAR(45)									NOT NULL,
descricao				VARCHAR(45)									NOT NULL,
dataa					DATE CHECK(dataa > '2014-09-01')			NOT NULL,
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
ALTER COLUMN senha	  VARCHAR(8)									NOT NULL 
GO

EXEC sp_help users
EXEC sp_help projects
EXEC sp_help users_has_projects



INSERT INTO users (id, nome, username, senha, email)
VALUES 
(1, 'Maria', 'Rh_maria', '123mudar', 'maria@empresa.com'),
(2, 'Paulo', 'Ti_paulo', '123@456', 'paulo@empresa.com'),
(3, 'Ana', 'Rh_ana', '123mudar', 'ana@empresa.com'),
(4, 'Clara', 'Ti_clara', '123mudar', 'clara@empresa.com'),
(5, 'Aparecido', 'Rh_apareci', '55@!cido', 'aparecido@empresa.com')
GO

INSERT INTO	projects (id, nome, descricao, dataa)
VALUES
(10001, 'Re-folha', 'Refatoração das folhas', '05/09/2014'),
(10002, 'Manutenção PCs ', 'Manutenção PCs', '06/09/2014'),
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

use master
drop database Projeto