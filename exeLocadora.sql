CREATE DATABASE locadora
GO
USE locadora
GO

CREATE TABLE filme (
id							INT						NOT NULL,
titulo						VARCHAR(100)			NOT NULL,
ano							INT	CHECK(ano < 2021)	NOT NULL,
PRIMARY KEY(id)
)
GO

CREATE TABLE estrela(
id							INT						NOT NULL,
nome						VARCHAR(50)				NOT NULL,
PRIMARY KEY(id)
)
GO

CREATE TABLE filme_estrela(
filme_id					INT						NOT NULL,
estrela_id					INT						NOT NULL,
PRIMARY KEY(filme_id, estrela_id),
FOREIGN KEY(filme_id)	REFERENCES filme(id),
FOREIGN KEY(estrela_id) REFERENCES estrela(id)
)
GO

INSERT INTO filme (id, titulo, ano)
VALUES (1001, 'Whiplash', 2015)
INSERT INTO filme (id, titulo, ano)
VALUES (1002, 'Birdman', 2015)
INSERT INTO filme (id, titulo, ano)
VALUES (1003, 'Interestelar', 2014)
INSERT INTO filme (id, titulo, ano)
VALUES (1004, 'A culpa é das estrelas', 2014)
INSERT INTO filme (id, titulo, ano)
VALUES (1005, 'Alexandre e o dia terrível, horrível, espantoso e horroroso', 2014)
INSERT INTO filme (id, titulo, ano)
VALUES (1006, 'Sing', 2016)
GO

ALTER TABLE estrela
ADD nome_real		VARCHAR(50)			 NULL
go
INSERT INTO estrela (id, nome, nome_real)
VALUES
(9901, 'Michael Keaton', 'Michael John Douglas'),
(9902, 'Emma Stone', 'Emily Jean Stone'),
(9903, 'Miles Teller', NULL),
(9904, 'Steve Carell', 'Steven John Carell'),
(9905, 'Jennifer Garner', 'Jennifer Anne Garner')
GO

UPDATE estrela
SET nome_real = 'Miles Alexander Teller'
WHERE id = 9003


INSERT INTO filme_estrela (filme_id, estrela_id)
VALUES (1002, 9901)
INSERT INTO filme_estrela (filme_id, estrela_id)
VALUES (1002, 9902)
INSERT INTO filme_estrela (filme_id, estrela_id)
VALUES (1001, 9903)
INSERT INTO filme_estrela (filme_id, estrela_id)
VALUES (1005, 9904)
INSERT INTO filme_estrela (filme_id, estrela_id)
VALUES (1005, 9905)
GO

SELECT * FROM filme
SELECT * FROM estrela
SELECT * FROM filme_estrela

CREATE TABLE dvd (
num									INT														NOT NULL,
data_fabricacao						DATETIME CHECK(data_fabricacao < GETDATE())      		NOT NULL,
filmeid								INT														NOT NULL
PRIMARY KEY(num)
FOREIGN KEY(filmeid) REFERENCES filme(id)
)
GO

CREATE TABLE cliente (
num_cadastro						INT														NOT NULL,
nome								VARCHAR(70)												NOT NULL,
logradouro							VARCHAR(150)											NOT NULL,
num									INT	CHECK(num > 0)										NOT NULL,
cep									CHAR(8)	CHECK(LEN(cep) = 8)								NULL
PRIMARY KEY(num_cadastro)
)
GO

CREATE TABLE locacao (
dvdnum								INT														NOT NULL,
clientenum_cadastro					INT														NOT NULL,
data_locacao						DATETIME DEFAULT(GETDATE())								NOT NULL,
data_devolucao						DATETIME												NOT NULL,
valor								DECIMAL(7,2) CHECK(valor > 0.00)						NOT NULL,

PRIMARY KEY (data_locacao, dvdnum, clientenum_cadastro),
FOREIGN KEY (dvdnum)				REFERENCES dvd(num),
FOREIGN KEY (clientenum_cadastro)	REFERENCES cliente(num_cadastro),
)
GO
INSERT INTO dvd 
VALUES
(10001, 2020-12-02 , 1001),
(10002, 2019-10-18 , 1002),
(10003, 2020-04-03 , 1003),
(10004, 2020-12-02 , 1001),
(10005, 2019-10-18 , 1004),
(10006, 2020-04-03 , 1002),
(10007, 2020-12-02 , 1005),
(10008, 2019-10-18 , 1002),
(10009, 2020-04-03 , 1003)
GO
INSERT INTO cliente
VALUES
(5501, 'Matilde Luz', 'Rua Síria', 150, '03086040'),
(5502, 'Carlos Carreiro', 'Rua Bastolomeu Aires', 1250, '04419110'),
(5503, 'Daniel Ramalho', 'Rua Itajutiba', 169, NULL),
(5504, 'Roberta Bento', 'Rua Jayme Von Rosenburg', 36, NULL),
(5505, 'Rosa Cerqueira', 'Rua Arnaldo Simmões Pinto', 235, '02917110')
GO
INSERT INTO locacao
VALUES
(10001, 5502, 2021-02-18, 2021-02-21, 3.50),
(10009, 5502, 2021-02-18, 2021-02-21, 3.50),
(10002, 5503, 2021-02-18, 2021-02-19, 3.50),
(10002, 5505, 2021-02-20, 2021-02-23, 3.00),
(10004, 5505, 2021-02-20, 2021-02-23, 3.00),
(10005, 5505, 2021-02-20, 2021-02-23, 3.00),
(10001, 5501, 2021-02-24, 2021-02-26, 3.50),
(10008, 5501, 2021-02-24, 2021-02-26, 3.50)
GO

SELECT * FROM dvd
SELECT * FROM cliente
SELECT * FROM locacao

UPDATE cliente
SET cep = '08411150'
WHERE num_cadastro = 5503
GO

UPDATE cliente
SET cep = '02918190'
WHERE num_cadastro = 5504
GO

UPDATE locacao
SET valor = 3.25
WHERE clientenum_cadastro = 5502 AND data_locacao = 2021-02-18
GO

UPDATE locacao
SET valor = 3.10
WHERE clientenum_cadastro = 5501 and data_locacao = '2021-02-24'
GO
UPDATE dvd
SET data_Fabricacao = '2019-07-14'
WHERE num = 10005
GO
UPDATE estrela
SET nome_real = 'Miles Alexander Teller'
WHERE id = 9903

DELETE filme
WHERE titulo = 'Sing'


SELECT '2014' FROM filme


SELECT id, ano FROM filme
WHERE titulo = 'Birdman'



SELECT id, ano from filme
WHERE titulo LIKE '%plash%'


SELECT id, nome, nome_real from estrela
WHERE nome LIKE '%Steve%'


SELECT filme_id, CONVERT(CHAR(10), data_fabricacao, 103) AS Fab FROM dvd 
WHERE data_fabricacao >= '01-01-2020'


SELECT clientenum_cadastro, dvd_num, data_locacao, data_devolucao, valor+(2.00) AS valor_multa FROM locacao
WHERE clientenum_cadastro = 5505

SELECT logradouro, num, cep FROM cliente
WHERE nome = 'Matilde Luiz'

SELECT nome_real from estrela
WHERE nome = 'Michael Keaton'

SELECT num_cadastro, nome, logradouro+' '+CONVERT(CHAR(10),num)+ ' '+cep as end_comp from cliente
WHERE num_cadastro >= 5503


USE master
DROP DATABASE locadora