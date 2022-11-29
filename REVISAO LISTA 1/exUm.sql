CREATE database aluno
go
use aluno
go

Create Table Aluno (
ra			int			not null,
nome		varchar(10) not null,
sobrenome	varchar(30) not null,
rua			varchar(30) not null,
num			int			not null,
bairro		varchar(30) not null,
cep			char(7)		not null,
telefone	char(8)         null
Primary Key (ra)
)
Go

Create Table Curso (
codigo		int			not null,
nome		varchar(20) not null,
carga		int			not null,
turno		varchar(10) not null
Primary Key (codigo)
)
Go

Create Table Disciplina (
codigo		int			not null,
nome		varchar(20) not null,
carga		int			not null,
turno		varchar(10) not null,
semestre    int			not null
Primary Key (codigo)
)
Go

Insert Into Aluno Values 
(12345, 'José', 'Silva', 'Almirante Noronha', 236, 'Jardim São Paulo', 1589000, 69875287),
(12346,	'Ana', 'Maria Bastos',	'Anhaia', 1568,	'Barra Funda', 3569000,	25698526),
(12347,	'Mario', 'Santos',	'XV de Novembro', 1841, 'Centro', 1020030, Null),
(12348, 'Marcia', 'Neves', 'Voluntários da Patria', 225, 'Santana',	2785090, 78964152)

Insert Into Curso Values 
(1, 'Informatica', 2800, 'Tarde'),
(2, 'Informatica', 2800, 'Noite'),
(3, 'Logistica', 2650, 'Tarde'),
(4, 'Logistica', 2650, 'Noite'),
(5, 'Plasticos', 2500, 'Tarde'),
(6, 'Plasticos', 2500, 'Noite')

Insert Into Disciplina Values 
(1, 'Informatica', 4, 'Tarde', 1),
(2, 'Informatica', 4, 'Noite', 1),
(3, 'Quimica', 4, 'Tarde', 1),
(4, 'Quimica', 4, 'Noite', 1),
(5, 'Banco de Dados 1', 2, 'Tarde', 3),
(6, 'Banco de Dados 1', 2, 'Noite', 3),
(7, 'Estrutura de Dados', 4, 'Tarde', 4),
(8, 'Estrutura de Dados', 4, 'Noite', 4)


--1
select nome + ' ' + sobrenome as Nome_Completo
from aluno
where ra is not null

--2
select rua+ ' - ' + convert(varchar(5), num) + ' ' + bairro + '-' + convert(varchar(5), cep) as Endereco_Completo
from aluno
where telefone is null

--3
select telefone
from aluno
where ra = 12348
--4
select nome, turno
from curso
where carga = 2800
--5
select semestre
from disciplina
where turno = 'noite' and nome like 'banco%'

drop database aluno
use master