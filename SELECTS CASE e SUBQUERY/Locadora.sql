CREATE DATABASE locadora
GO
USE locadora
GO

CREATE TABLE filme (
id							INT						NOT NULL,
titulo						VARCHAR(70)			NOT NULL,
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
data_fabricacao						DATE CHECK(data_fabricacao < GETDATE())      		NOT NULL,
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
data_locacao						DATE DEFAULT(GETDATE())								NOT NULL,
data_devolucao						DATE												NOT NULL,
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

--nome do filme, maior que dez colocar reticencias--
SELECT id, ano, 
	CASE WHEN (LEN(titulo) > 10)
	THEN
		SUBSTRING(titulo, 1, 10) + '...'
	 ELSE
		SUBSTRING(titulo, 1, 10)
	 END AS titulo
	 FROM filme
	 WHERE id IN
		 (
			SELECT DISTINCT filmeid
			FROM dvd
			WHERE datediff(day, data_fabricacao, '20200101') < 0
		 )

 --quantidade de meses desde a fabricação do filme--
SELECT data_fabricacao,
 			DATEDIFF(MONTH, '20200403', GETDATE()) AS qtd_meses_desde_fabricacao, + filmeid
FROM dvd
WHERE num = 10003

--quantidade de dias alugados e valor--
SELECT dvdnum, clientenum_cadastro, data_locacao, data_devolucao,
	datediff(day, data_locacao, data_devolucao) as dias_alugados, + valor 
FROM locacao
WHERE clientenum_cadastro IN
	(
	SELECT DISTINCT num_cadastro
	FROM cliente
	WHERE nome like '%rosa%'
	)
-- endereço completo, cep de quem alugou o filme de 10002--
SELECT num_cadastro, 
		nome+ ', ' +logradouro+ ','+cast(num AS VARCHAR(5))+ ', '
		+SUBSTRING(cep, 1,5) + '-' +SUBSTRING(cep,6,3) AS Endereço_completo
FROM cliente
WHERE num_cadastro in
(
	SELECT DISTINCT clientenum_cadastro
	FROM locacao
	WHERE dvdnum = 10002
)
USE master
DROP DATABASE locadora