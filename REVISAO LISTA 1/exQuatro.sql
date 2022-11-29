create database fornecedor
go
use fornecedor
go

Create Table Cliente (
CPF			char(12)		not null,
nome		varchar(50)		not null,
telefone	varchar(9)      not null
Primary Key (CPF)
)
Go


Create Table Fornecedor (
ID				int			not null,
nome			varchar(30) not null,
logradouro		varchar(50)	not null,
num				int			not null,
complemento		varchar(10)	not null,
cidade			varchar(20)	not null
Primary Key (ID)
)
Go

Create Table Produto (
codigo				int				not null,
descricao			varchar(60)		not null,
id_fornecedor		int				not null,
preco				decimal(7,2)	not null
Primary Key (codigo)
Foreign Key (id_fornecedor)
	References Fornecedor (ID)
)
Go

Create Table Venda (
codigo				int				not null,
codigo_produto		int				not null,
cpf_cliente			char(12)		not null,
quant				int				not null,
valorT				decimal(7,2)	not null,
data				date			not null
Primary Key (codigo)
Foreign Key (codigo_produto)
	References Produto (codigo),
Foreign Key (cpf_cliente)
	References Cliente (CPF)
)


Insert Into Cliente Values 
('345789092-90',	'Julio Cesar',	'8273-6541'),
('251865337-10',	'Maria Antonia',	'8765-2314'),
('876273154-16',	'Luiz Carlos',	'6128-9012'),
('791826398-00',	'Paulo Cesar',	'9076-5273')
Go

Insert Into Fornecedor Values
(1,	'LG',	'Rod. Bandeirantes',	70000,	'Km 70',	'Itapeva'),
(2,	'Asus',	'Av. Nações Unidas',	10206,	'Sala 225',	'São Paulo'),
(3,	'AMD',	'Av. Nações Unidas',	10206,	'Sala 1095',	'São Paulo'),
(4,	'Leadership',	'Av. Nações Unidas',	10206,	'Sala 87',	'São Paulo'),
(5,	'Inno',	'Av. Nações Unidas',	10206,	'Sala 34',	'São Paulo')
Go

Insert Into Produto Values 
(1,	'Monitor 19 pol.',	1,	449.99),
(2,	'Netbook 1GB Ram 4 Gb HD',	2,	699.99),
(3,	'Gravador de DVD - Sata',	1,	99.99),
(4,	'Leitor de CD',	1,	49.99),
(5,	'Processador - Phenom X3 - 2.1GHz',	3,	349.99),
(6,	'Mouse',	4,	19.99),
(7,	'Teclado',	4,	25.99),
(8,	'Placa de Video - Nvidia 9800 GTX - 256MB/256 bits',	5,	599.99)
Go

Insert Into Venda Values 
(1,	1,	'251865337-10',	1,	'449.99',	'03/09/2009'),
(4,	4,	'251865337-10',	1,	'49.99',	'03/09/2009'),
(5,	5,	'251865337-10',	1,	'349.99',	'03/09/2009'),
(6,	6,	'791826398-00',	4,	'79.96',    '06/09/2009'),
(8,	8,	'876273154-16',	1,	'599.99',	'06/09/2009'),
(3,	3,	'876273154-16',	1,	'99.99',	'06/09/2009'),
(7,	7,	'876273154-16',	1,	'25.99',	'06/09/2009'),
(2,	2,	'345789092-90',	2,	'1399.98',	'08/09/2009')
Go

Select Convert(char(10),data,103) As data
From Venda
Where codigo = 4

Alter Table Fornecedor
add telefone		char(9)

Update Fornecedor
Set telefone = '7216-5371'
Where ID = 1

Update Fornecedor
Set telefone = '8715-3738'
Where ID = 2

Update Fornecedor
Set telefone = '3654-6289'
Where ID = 4

Select nome, logradouro + ' num:' + Convert(char(5),num )+ ',' + complemento + ' cidade:' + cidade As endereco_competo, telefone
From Fornecedor 
Order By nome

Select descricao, quant, valorT
From Produto Inner Join Venda
On Produto.codigo = Venda.codigo_produto
Inner Join Cliente
On Cliente.CPF = Venda.cpf_cliente
Where Cliente.nome = 'Julio Cesar'

Select Convert(char(10),data,103) As data, valorT
From Venda Inner Join Cliente
On Venda.cpf_cliente = Cliente.CPF
Where nome = 'Paulo Cesar'

Select descricao, preco
From Produto
Order By preco, descricao Desc






Select *From Cliente
Select *From Venda
Select *From Fornecedor
Select *From Produto