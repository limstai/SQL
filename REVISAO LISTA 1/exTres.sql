create database paciente
go
use paciente
go

Create Table Paciente (
CPF			char(11)		not null,
nome		varchar(30)		not null,
rua			varchar(30)		not null,
num			int				not null,
bairro		varchar(20)		not null,
telefone	char(8)			null,
data_nasc	date			not null
Primary Key (CPF)
)
Go

Create Table Medico (
codigo			int			not null,
nome			varchar(30) not null,
especialidade	varchar(20) not null
Primary Key (codigo)
)
Go

Create Table Prontuario (
data				date			not null,
CPF_paciente		char(11)		not null,
codigo_medico	int				not null,
diagnostico			varchar(40)		not null,
medicamneto			varchar(20)		not null
Primary Key (data)
Foreign Key (CPF_paciente)
	References Paciente (CPF),
Foreign Key (codigo_medico)
	References Medico (codigo)
)
Go

Insert Into Paciente Values 
('35454562890',	'José Rubens',	'Campos Salles',	2750,	'Centro',	'21450998',	'1954-10-18'),
('29865439810', 'Ana Claudia',	'Sete de Setembro',	178,	'Centro',	'97382764',	'1960-05-29'),
('82176534800',	'Marcos Aurélio',	'Timóteo Penteado',	236,	'Vila Galvão',	'68172651',	'1980-09-24'),
('12386758770',	'Maria Rita',	'Castello Branco',	7765,	'Vila Rosália',	NULL,	'1975-03-30'),
('92173458910',	'Joana de Souza',	'XV de Novembro',	298,	'Centro',	'21276578',	'1944-04-24')
Go

Insert Into Medico Values 
(1,	'Wilson Cesar',	'Pediatra'),
(2,	'Marcia Matos',	'Geriatra'),
(3,	'Carolina Oliveira',	'Ortopedista'),
(4,	'Vinicius Araujo',	'Clínico Geral')
Go

Insert Into Prontuario Values 
('2020-09-10',	'35454562890',	2,	'Reumatismo',	'Celebra'),
('2020-09-11',	'92173458910',	2,	'Renite Alérgica',	'Allegra'),
('2020-09-12',	'29865439810',	1,	'Inflamação de garganta',	'Nimesulida'),
('2020-09-13',	'35454562890',	2,	'H1N1',	'Tamiflu'),
('2020-09-14',	'82176534800',	4,	'Gripe',	'Resprin'),
('2020-09-15',	'12386758770',	3,	'Braço Quebrado',	'Dorflex + Gesso')
Go
--1
select nome, rua + '-' + convert(varchar(5), num) + ','+bairro AS endereco_completo
from paciente
where dateDiff(day, data_nasc, getdate()) / 365 > 50

--2
select especialidade
from medico
where nome like 'Carolina Oliveira'

--3
select medicamneto
from prontuario
where diagnostico like 'reumatismo%'

--4

select diagnostico, medicamneto
from paciente pc, prontuario pro
where pc.CPF = pro.CPF_paciente
	and pc.nome like 'José Rubens'

--5
select md.nome as Nome_medico, 
case when len(especialidade) > 3
then
substring(especialidade,1,3) + '.'
else especialidade 
end as especialidade
from medico md, prontuario pro, paciente pc
where md.codigo = pro.codigo_medico
and pc.CPF = pro.CPF_paciente
and pc.nome = 'José Rubens'

--6
select substring(CPF, 1,3)+'-'+substring(CPF,4,3)+'-'+substring(CPF,7, 3)+ '-' +substring(CPF, 10,2) as CPF, pc.nome,
	rua + '-' + convert(varchar(5), num) + ','+bairro AS endereco_completo,
	case when telefone is null
	then
	 '-' 
	else
	telefone
	end as Telefone
from paciente pc, prontuario pro, medico md
where pc.CPF = pro.CPF_paciente
	and md.codigo = pro.codigo_medico
	and md.codigo = 4

--6
select datediff(day, data, getdate()) as Quantidade_de_dias_desde_Consulta
from prontuario pro, paciente pc
where pc.CPF = pro.CPF_paciente
and pc.nome = 'Maria Rita'

--7 
update paciente
set telefone = '98345621'
where nome = 'Maria Rita'

select * from Paciente

update Paciente
set rua = 'Voluntários da Pátria', num = 1980, bairro='Jd.Aeroporto'
where nome = 'Joana de Souza'