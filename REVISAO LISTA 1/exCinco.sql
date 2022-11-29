create database exCinco
go
use exCinco
go
Create Table Fornecedor (
codigo			int			not null,
nome			varchar(40)	not null,
atividade		varchar(40)	not null,
telefone		char(8)		not null
Primary Key (codigo)
)
Go

Create Table Cliente (
codigo			int				not null,
nome			varchar(50)		not null,
logradouro		varchar(80)		not null,
num				int				not null,
telefone		char(8)			not null,
data_nasc		date			not null
Primary Key (codigo)
)
Go

Create Table Produto (
codigo				int				not null,
nome				varchar(50)		not null,
valorU				decimal(7,2)	not null,
quant				int				not null,
descricao			varchar(50)		not null,
codigo_fornecedor	int				not null
Primary Key (codigo)
Foreign key (codigo_fornecedor)
	References Fornecedor (codigo)
)
Go

Create Table Pedido (
codigo					int				not null,
codigo_cliente			int				not null,
codigo_produto			int				not null,
quant					int				not null,
previsao_entrega		date			not null
Primary Key (codigo)
Foreign Key (codigo_cliente)
	References Cliente (codigo),
Foreign Key (codigo_produto)
	References Produto (codigo)
)
Go

Insert Into Fornecedor Values 
(1001,	'Estrela',	'Brinquedo',	'41525898'),
(1002,	'Lacta',	'Chocolate',	'42698596'),
(1003,	'Asus',	'Informática',	'52014596'),
(1004,	'Tramontina',	'Utensílios Domésticos',	'50563985'),
(1005,	'Grow',	'Brinquedos',	'47896325'),
(1006,	'Mattel',	'Bonecos',	'59865898')
Go

Insert Into Cliente Values 
(33601,	'Maria Clara',	'R. 1° de Abril',	870,	'96325874',	'2000-08-15'),
(33602,	'Alberto Souza',	'R. XV de Novembro',	987,	'95873625'	,	'1985-02-02'),
(33603,	'Sonia Silva',	'R. Voluntários da Pátria',	1151,	'75418596'	,	'1957-08-23'),
(33604,	'José Sobrinho',	'Av. Paulista',	250,	'85236547',	'1986-12-09'),
(33605,	'Carlos Camargo',	'Av. Tiquatira',	9652,	'75896325',	'1971-03-25')
Go

Insert Into Produto Values 
(1,	'Banco Imobiliário',	65.00,	15,	'Versão Super Luxo',	1001),
(2,	'Puzzle 5000 peças',	50.00,	5,	'Mapas Mundo',	1005),
(3,	'Faqueiro',	350.00,	0,	'120 peças',	1004),
(4,	'Jogo para churrasco',	75.00,	3,	'7 peças',	1004),
(5,	'Tablet',	750.00,	29,	'Tablet',	1003),
(6,	'Detetive',	49.00,	0,	'Nova Versão do Jogo',	1001),
(7,	'Chocolate com Paçoquinha',	6.00,	0,	'Barra',	1002),
(8,	'Galak',	5.00,	65,	'Barra',	1002)
Go

Insert Into Pedido Values
(99001,	33601,	1,	1,	'2012-06-07'),
(99002,	33601,	2,	1,	'2012-06-07'),
(99003,	33601,	8,	3,	'2012-06-07'),
(99004,	33602,	2,	1,	'2012-06-09'),
(99005,	33602,	4,	3,	'2012-06-09'),
(99006,	33605,	5,	1,	'2012-06-15')
Go
--1
select pro.quant, SUM(pro.valorU*pro.quant) as valor_total, SUM((convert(decimal(7,2), pro.valorU *pro.quant))*0.25) as Valor_Total_com_Desconto
from cliente cl, Produto pro, Pedido pd
where cl.codigo = pd.codigo_cliente
	and pro.codigo = pd.codigo_produto
	and cl.nome = 'Maria Clara'
	group by pro.quant

--2
select pro.nome
from Fornecedor fo, produto pro
where fo.codigo = pro.codigo_fornecedor
and atividade = 'brinquedo'
--3
update produto
set valorU = valorU - 0.10
where descricao = 'barra'

select*from Produto

--4
Update Produto
Set quant = 10
Where nome = 'Faqueiro'

Select Count (DateDiff(Day, data_nasc, GetDate())/365) As quant_clientes_mais_de_40anos
From Cliente
Where DateDiff(Day, data_nasc, GetDate())/365 > 40

Select nome, telefone 
From Fornecedor
Where atividade = 'Brinquedo' or atividade= 'Chocolate'

Select nome, Convert(decimal(7,2),ValorU * 0.75) As Valor_com_desconto
From Produto
Where valorU < 50.00

Select nome,  Convert(decimal(7,2),ValorU * 1.10) As Valor_com_aumento
From Produto
Where valorU > 100

Select Sum(Convert(decimal(7,2),(Pedido.quant * valorU) * 0.75)) As ValorTotal_Com_desconto
From Produto inner Join Pedido
On Produto.codigo = Pedido.codigo_produto
Where Pedido.codigo = 99001

Select codigo, nome, DateDiff(day, data_nasc, GetDate())/365 As idade
From Cliente