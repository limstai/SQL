Create DataBase ex5
Go
Use ex5
Go

Create Table Plano (
codigo			int				not null,
nome			varchar(100)	not null,	
telefone		char(8)			not null
Primary Key (codigo)
)
Go

Create Table Paciente (
CPF				char(11)		not null,
nome			varchar(100)	not null,
rua				varchar(100)	not null,
num				int				not null,
bairro			varchar(50)		not null,
telefone		char(8)			not null,
codigo_plano	int				not null
Primary Key (CPF)
Foreign Key (codigo_plano)
	References Plano (codigo)
)
Go

Create Table Medico (
codigo				int				not null,
nome				varchar(100)	not null,
especialidade		varchar(50)		not null,
codigo_plano		int				not null
Primary Key (codigo)
Foreign Key (codigo_plano)
	References Plano (codigo)
)
Go

Create Table Consulta (
codigo_medico		int				not null,
CPF_paciente		char(11)		not null,
datahora			datetime		not null,
diagnostico			varchar(50)		not null
Foreign Key (codigo_medico)
	References Medico (codigo),
Foreign Key (CPF_paciente)
	References Paciente (CPF)
)
Go

Insert Into Plano Values 
(1234,	'Amil',	'41599856'),
(2345,	'Sul América',	'45698745'),
(3456,	'Unimed',	'48759836'),
(4567,	'Bradesco Saúde',	'47265897'),
(5678,	'Intermédica',	'41415269')
Go

Insert Into Paciente Values
('85987458920',	'Maria Paula',	'R. Voluntários da Pátria',	589,	'Santana',	'98458741',	2345),
('87452136900',	'Ana Julia',	'R. XV de Novembro',	657, 'Centro',	'69857412',	5678),
('23659874100',	'João Carlos',	'R. Sete de Setembro',	12,	'República',	'74859632',	1234),
('63259874100',	'José Lima',	'R. Anhaia',	768,	'Barra Funda',	'96524156',	2345)
Go

Insert Into Medico Values 
(1,	'Claudio',	'Clínico Geral',	1234),
(2,	'Larissa',	'Ortopedista',	2345),
(3,	'Juliana',	'Otorrinolaringologista',	4567),
(4,	'Sérgio',	'Pediatra',	1234),
(5,	'Julio',    'Clínico Geral',	4567),
(6,	'Samara',	'Cirurgião',	1234)
Go

Insert Into Consulta Values 
(1,	'85987458920',	'2021-02-10 10:30:00',	'Gripe'),
(2,	'23659874100',	'2021-02-10 11:00:00',	'Pé Fraturado'),
(4,	'85987458920',	'2021-02-11 14:00:00',	'Pneumonia'),
(1,	'23659874100',	'2021-02-11 15:00:00',	'Asma'),
(3,	'87452136900',	'2021-02-11 16:00:00',	'Sinusite'),
(5,	'63259874100',	'2021-02-11 17:00:00',	'Rinite'),
(4,	'23659874100',	'2021-02-11 18:00:00',	'Asma'),
(5,	'63259874100',	'2021-02-12 10:00:00',	'Rinoplastia')
Go

--Consultar Nome e especialidade dos médicos da Amil
Select Medico.nome, especialidade
From Medico Inner Join Plano
On Medico.codigo_plano = Plano.codigo
Where Plano.nome = 'Amil'
										
--Consultar Nome, Endereço concatenado, Telefone e Nome do Plano de Saúde de todos os pacientes	
Select Paciente.nome, rua + ',' + Convert(char(5), num) + ' ' + bairro As endereco_completo, Paciente.telefone, Plano.nome
From Paciente Inner Join Plano
On Paciente.codigo_plano = Plano.codigo	
							
--Consultar Telefone do Plano de  Saúde de Ana Júlia
Select Plano.telefone 
From Plano Inner Join Paciente
On Plano.codigo = Paciente.codigo_plano
Where Paciente.nome = 'Ana Julia'
										
--Consultar Plano de Saúde que não tem pacientes cadastrados	
Select Plano.nome
From Plano Left Join Paciente
On Plano.codigo = Paciente.codigo_plano
Where Paciente.codigo_plano IS NULL
 									
--Consultar Planos de Saúde que não tem médicos cadastrados	
Select Plano.nome
From Plano Left Join Medico
On Plano.codigo = Medico.codigo_plano
Where Medico.codigo_plano IS NULL		
							
--Consultar Data da consulta, Hora da consulta, nome do médico, nome do paciente e diagnóstico de todas as consultas	
Select datahora, Medico.nome, Paciente.nome, diagnostico 
From Consulta 	Inner Join Medico
On Consulta.codigo_medico = Medico.codigo
Inner Join Paciente
On Paciente.CPF = Consulta.CPF_paciente
								
--Consultar Nome do médico, data e hora de consulta e diagnóstico de José Lima	
Select Medico.nome, datahora, diagnostico
From Medico Inner Join Consulta
On Medico.codigo = Consulta.codigo_medico
Inner Join Paciente
On Paciente.CPF = Consulta.CPF_paciente
Where Paciente.nome = 'José Lima'
									
--Consultar Diagnóstico e Quantidade de consultas que aquele diagnóstico foi dado (Coluna deve chamar qtd)	
Select diagnostico, Count(diagnostico) As qtd
From Consulta
Group By Consulta.diagnostico
								
--Consultar Quantos Planos de Saúde que não tem médicos cadastrados		
Select Count(Plano.codigo) As qtd
From Plano Left Join Medico 
On Plano.codigo = Medico.codigo_plano
Where Medico.codigo_plano Is Null	
Group By Plano.nome							
										
--Alterar o nome de João Carlos para João Carlos da Silva
Update Paciente
Set nome = 'João Carlos da Silva'
Where nome = 'João Carlos'	
									
--Deletar o plano de Saúde Unimed	
Delete From Plano
Where nome = 'Unimed'
									
--Renomear a coluna Rua da tabela Paciente para Logradouro	
Exec sp_rename 'dbo.Paciente.rua', 'logradouro'
									
--Inserir uma coluna, na tabela Paciente, de nome data_nasc e inserir os valores (1990-04-18,1981-03-25,2004-09-04 e 1986-06-18) respectivamente	
Alter Table Paciente
Add data_nasc date null	

update Paciente 
Set data_nasc = '1990-04-18'
Where CPF = '23659874100'

update Paciente 
Set data_nasc = '1981-03-25'
Where CPF = '63259874100'

update Paciente 
Set data_nasc = '2004-09-04'
Where CPF = '85987458920'

update Paciente 
Set data_nasc = '1986-06-18'
Where CPF = '87452136900'