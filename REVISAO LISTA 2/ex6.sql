Create DataBase ex6
Go
Use ex6
Go

Create Table Plano (
codigo			int				not null,
nome			varchar(50) 	not null,	
valor   		decimal(5,2)	not null
Primary Key (codigo)
)
Go

Create Table Servico (
codigo			int				not null,
nome			varchar(50) 	not null,	
valor   		decimal(5,2)	not null
Primary Key (codigo)
)
Go

Create Table Cliente (
codigo			int				not null,
nome			varchar(50) 	not null,	
dataI  			date			not null
Primary Key (codigo)
)
Go

Create Table Contato (
codigo_cliente			int									not null,
codigo_plano			int									not null,
codigo_servico			int									not null,
status					char(1) Check(len(status) = 1)		not null,
data					date								not null
Foreign Key (codigo_cliente)
	References Cliente (codigo),
Foreign Key (codigo_plano)
	References Plano (codigo),
Foreign Key (codigo_servico)
	References Servico (codigo)
)
Go

Insert Into Plano Values 
(1,	'100 Minutos',	80),
(2,	'150 Minutos',	130),
(3,	'200 Minutos',	160),
(4,	'250 Minutos',	220),
(5,	'300 Minutos',	260),
(6,	'600 Minutos',	350)
Go

Insert Into Servico Values 
(1,	'100 SMS',	10),
(2,	'SMS Ilimitado',	30),
(3,	'Internet 500 MB',	40),
(4,	'Internet 1 GB',    60),
(5,	'Internet 2 GB',	70)
Go

Insert Into Cliente Values 
(1234,	'Cliente A',	'2012-10-15'),
(2468,	'Cliente B',    '2012-11-20'),
(3702,	'Cliente C',	'2012-11-25'),
(4936,	'Cliente D',	'2012-12-01'),
(6170,	'Cliente E',	'2012-12-18'),
(7404,	'Cliente F',	'2013-01-20'),
(8638,	'Cliente G',	'2013-01-25')
Go

Insert Into Contato Values 
(1234,	3,	1,	'E',	'2012-10-15'),
(1234,	3,	3,	'E',	'2012-10-15'),
(1234,	3,	3,	'A',	'2012-10-16'),
(1234,	3,	1,	'A',	'2012-10-16'),
(2468,	4,	4,	'E',	'2012-11-20'),
(2468,	4,	4,	'A',	'2012-11-21'),
(6170,	6,	2,	'E',	'2012-12-18'),
(6170,	6,	5,	'E',	'2012-12-19'),
(6170,	6,	2,	'A',	'2012-12-20'),
(6170,	6,	5,	'A',	'2012-12-21'),
(1234,	3,	1,	'D',	'2013-01-10'),
(1234,	3,	3,	'D',	'2013-01-10'),
(1234,	2,	1,	'E',	'2013-01-10'),
(1234,	2,	1,	'A',	'2013-01-11'),
(2468,	4,	4,	'D',	'2013-01-25'),
(7404,	2,	1,	'E',	'2013-01-20'),
(7404,	2,	5,	'E',	'2013-01-20'),
(7404,	2,	5,	'A',	'2013-01-21'),
(7404,	2,	1,	'A',	'2013-01-22'),
(8638,	6,	5,	'E',	'2013-01-25'),
(8638,	6,	5,	'A',	'2013-01-26'),
(7404,	2,	5,	'D',	'2013-02-03')
Go

--Consultar o nome do cliente, o nome do plano, a quantidade de estados de contrato (sem repetições) por contrato, dos planos cancelados, ordenados pelo nome do cliente
Select Distinct Cliente.nome, Plano.nome, Count(status) As qtd
From Cliente Right Join Contato
On Cliente.codigo = Contato.codigo_cliente
Right Join Plano 
On Plano.codigo = Contato.codigo_plano
Where Contato.codigo_plano Is Null
Group By Cliente.nome, Plano.nome, Contato.status


--Consultar o nome do cliente, o nome do plano, a quantidade de estados de contrato (sem repetições) por contrato, dos planos não cancelados, ordenados pelo nome do cliente	
Select Distinct Cliente.nome, Plano.nome, Count(status) As qtd
From Cliente Right Join Contato
On Cliente.codigo = Contato.codigo_cliente
Right Join Plano 
On Plano.codigo = Contato.codigo_plano
Where Contato.codigo_plano Is Not Null
Group By Cliente.nome, Plano.nome, Contato.status
Order By Cliente.nome
								
--Consultar o nome do cliente, o nome do plano, e o valor da conta de cada contrato que está ou esteve ativo, sob as seguintes condições:										
	--A conta é o valor do plano, somado à soma dos valores de todos os serviços									
	--Caso a conta tenha valor superior a R$400.00, deverá ser incluído um desconto de 8%									
	--Caso a conta tenha valor entre R$300,00 a R$400.00, deverá ser incluído um desconto de 5%									
	--Caso a conta tenha valor entre R$200,00 a R$300.00, deverá ser incluído um desconto de 3%									
	--Contas com valor inferiores a R$200,00 não tem desconto	
	
Select Cliente.nome, Plano.nome, Case When (SUM(Plano.valor + Servico.valor)) >400 
								 Then SUM((Plano.valor + Servico.valor)*0.92)
								 When (SUM(Plano.valor + Servico.valor)) Between 300 and 400 
								 Then SUM((Plano.valor + Servico.valor)*0.95)
								 When (SUM(Plano.valor + Servico.valor)) Between 200 and 300
								 Then SUM((Plano.valor + Servico.valor)*0.97)
								 Else SUM(Plano.valor + Servico.valor)
								 End As conta
From Cliente Inner Join Contato 
On Cliente.codigo = Contato.codigo_cliente
Inner Join Plano 
On Plano.codigo = Contato.codigo_plano
Inner Join Servico
On Servico.codigo = Contato.codigo_servico
Group By Cliente.nome, Plano.nome, Plano.valor, Servico.valor
						
--Consultar o nome do cliente, o nome do serviço, e a duração, em meses (até a data de hoje) do serviço, dos cliente que nunca cancelaram nenhum plano	
Select Distinct Cliente.nome, Servico.nome, DateDiff(day, dataI, getdate()) As duracao 
From Cliente Right Join Contato 
On Cliente.codigo = Contato.codigo_plano
Right Join Servico
On Servico.codigo = Contato.codigo_servico
Where Contato.codigo_plano Is Not Null		