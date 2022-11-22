CREATE DATABASE locadora
GO
USE locadora
GO

CREATE TABLE filme (
id							INT						NOT NULL,
titulo						VARCHAR(70)				NOT NULL,
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
data_fabricacao						DATE CHECK(data_fabricacao < GETDATE())      			NOT NULL,
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
data_locacao						DATE DEFAULT(GETDATE())									NOT NULL,
data_devolucao						DATE													NOT NULL,
valor								DECIMAL(7,2) CHECK(valor > 0.00)						NOT NULL,

PRIMARY KEY (data_locacao, dvdnum, clientenum_cadastro),
FOREIGN KEY (dvdnum)				REFERENCES dvd(num),
FOREIGN KEY (clientenum_cadastro)	REFERENCES cliente(num_cadastro),
)
GO
INSERT INTO dvd 
VALUES
(10001, '20201202' , 1001),
(10002, '20191018' , 1002),
(10003, '20200403' , 1003),
(10004, '20201202' , 1001),
(10005, '20191018' , 1004),
(10006, '20200403' , 1002),
(10007, '20201202' , 1005),
(10008, '20191018' , 1002),
(10009, '20200403' , 1003)
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
(10001, 5502, '20210218', '20210221', 3.50),
(10009, 5502, '20210218', '20210221', 3.50),
(10002, 5503, '20210218', '20210219', 3.50),
(10002, 5505, '20210220', '20210223', 3.00),
(10004, 5505, '20210220', '20210223', 3.00),
(10005, 5505, '20210220', '20210223', 3.00),
(10001, 5501, '20210224', '20210226', 3.50),
(10008, 5501, '20210224', '20210226', 3.50)
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
WHERE clientenum_cadastro = 5502 AND data_locacao = '20210218'
GO

UPDATE locacao
SET valor = 3.10
WHERE clientenum_cadastro = 5501 and data_locacao = '20210224'
GO
UPDATE dvd
SET data_Fabricacao = '20190714'
WHERE num = 10005
GO
UPDATE estrela
SET nome_real = 'Miles Alexander Teller'
WHERE id = 9903

DELETE filme
WHERE titulo = 'Sing'
/*consultar num_cadastro do cliente, nome do cliente, titulo do filme, fabricação do dvd
valor da locação, dos dvds que tem a maior data de fabricação dentre todos os cadastrados.*/
SELECT cl.num_cadastro, cl.nome, fl.titulo, dvd.data_fabricacao, loca.valor
FROM cliente cl, filme fl, dvd, locacao loca
WHERE cl.num_cadastro = loca.clientenum_cadastro
		and dvd.num =  loca.dvdnum
		and fl.id = dvd.filmeid
		and dvd.data_fabricacao in (
			SELECT max(dvd.data_fabricacao)
			FROM dvd
)
/*2. consultar, num_cadastro do cliente, nome do cliente, data de locação formato dd/mm/aaaa e a quantidade
de DVDS alugados por cliente(chamar essa de coluna de qtd) e por data de locação*/
SELECT cl.num_cadastro, cl.nome, CONVERT(char(10), data_locacao, 103) as Data_Locação,
	COUNT(loca.dvdnum) as qtd
FROM cliente cl, locacao loca, dvd
WHERE cl.num_cadastro = loca.clientenum_cadastro
	and dvd.num = loca.dvdnum
	GROUP BY cl.num_cadastro, cl.nome, loca.data_locacao
	ORDER BY cl.num_cadastro ASC

--3)--
SELECT  cl.num_cadastro, cl.nome, CONVERT(char(10), data_locacao, 103) as Data_Locação, 
		SUM(lc.valor) as Valor_Total
FROM cliente cl, locacao lc, dvd
WHERE cl.num_cadastro = lc.clientenum_cadastro
		and dvd.num = lc.dvdnum
		GROUP BY cl.num_cadastro, cl.nome, lc.data_locacao, lc.valor
		ORDER BY cl.num_cadastro ASC

--4)--
SELECT cl.num_cadastro, cl.nome, cl.logradouro +'-'+CAST(cl.num AS VARCHAR(4)) AS Endereço,
		CONVERT(char(10), data_locacao, 103) AS Data_Locação
FROM cliente cl, locacao lc, dvd
WHERE cl.num_cadastro = lc.clientenum_cadastro
	and dvd.num = lc.dvdnum
	GROUP BY cl.num_cadastro, cl.nome, cl.logradouro, cl.num, lc.data_locacao



USE master
DROP DATABASE locadora