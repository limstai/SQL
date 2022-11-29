Create DataBase ex4
Go
use ex4
Go

Create Table Medicamento (
codigo			int				not null,
nome			varchar(50)		not null,
apresentacao	varchar(30)		not null,
unidade			varchar(15)		not null,
preco			decimal(5,3)	not null
Primary Key (codigo)
)
Go

Create Table Cliente (
CPF			char(11)		not null,
nome		varchar(50)		not null,
rua			varchar(50)		not null,
num			int				not null,
bairro		varchar(20)		not null,
telefone	char(8)			not null
Primary Key (CPF)
)
Go

Create Table Venda (
nota				int				not null,
cliente_cpf			char(11)		not null,
medicamento_codigo	int				not null,
quant				int				not null,
valorT				decimal(5,2)	not null,
data				date			not null
Primary Key (nota, valorT)
Foreign Key (cliente_cpf)
	references Cliente (CPF),
Foreign Key (medicamento_codigo)
	references Medicamento (codigo)
)
Go

Insert Into Medicamento Values 
(1,	 'Acetato de medroxiprogesterona',  	 '150 mg/ml',  	 'Ampola',  	6.700),
(2,	 'Aciclovir',  	 '200mg/comp.',  	 'Comprimido',  	0.280),
(3,	 '�cido Acetilsalic�lico',  	 '500mg/comp.',  	 'Comprimido',  	0.035),
(4,	 '�cido Acetilsalic�lico',  	 '100mg/comp.',  	 'Comprimido',  	0.030),
(5,	 '�cido F�lico',  	 '5mg/comp.',  	 'Comprimido',  	0.054),
(6,	 'Albendazol',  	 '400mg/comp.mastig�vel',  	 'Comprimido',  	0.560),
(7,	 'Alopurinol',  	 '100mg/comp.', 	 'Comprimido',  	0.080),
(8,	 'Amiodarona',  	 '200mg/comp.',  	 'Comprimido',  	0.200),
(9,	 'Amitriptilina(Cloridrato)',  	 '25mg/comp.',  	 'Comprimido',  	0.220),
(10,	 'Amoxicilina',  	 '500mg/c�ps.',  	 'C�psula',  	0.190)
Go

Insert Into Cliente Values
('34390898700',	'Maria Z�lia',	'Anhaia',	65,	'Barra Funda',	'92103762'),
('21345986290',	'Roseli Silva',	'Xv. De Novembro',	987,	'Centro',	'82198763'),
('86927981825',	'Carlos Campos',	'Volunt�rios da P�tria',	1276,	'Santana',	'98172361'),
('31098120900',	'Jo�o Perdizes',	'Carlos de Campos',	90,	'Pari',	'61982371')
Go

Insert Into Venda Values 
(31501,	'86927981825',	10,	3,	0.57,	'2020-11-01'),
(31501, '86927981825',	2,	10,	2.8,	'2020-11-01'),
(31501,	'86927981825',	5,	30,	1.05,	'2020-11-01'),
(31501,	'86927981825',	8,	30,	6.6,	'2020-11-01'),
(31502,	'34390898700',	8,	15,	3,	   '2020-11-01'),
(31502,	'34390898700',	2,	10,	2.8,	'2020-11-01'),
(31502,	'34390898700',	9,	10,	2.2,	'2020-11-01'),
(31503,	'31098120900',	1,	20,	134,	'2020-11-02')
Go


--Nome, apresenta��o, unidade e valor unit�rio dos rem�dios que ainda n�o foram vendidos. Caso a unidade de cadastro seja comprimido, mostrar Comp.	
Select nome, apresentacao, unidade, preco
From Medicamento Left Join Venda
on medicamento.codigo = Venda.medicamento_codigo
Where Venda.medicamento_codigo Is Null
											
--Nome dos clientes que compraram Amiodarona	
Select Cliente.nome
From Cliente Inner join Venda
on Cliente.CPF = Venda.cliente_cpf
Inner Join Medicamento
On Medicamento.codigo = Venda.medicamento_codigo
Where Medicamento.nome = 'Amiodarona'
									
--CPF do cliente, endere�o concatenado, nome do medicamento (como nome de rem�dio),  apresenta��o do rem�dio, unidade, pre�o proposto, quantidade vendida e valor total dos rem�dios vendidos a Maria Z�lia	
Select CPF, rua + ',' + Convert(char(5), num) + ' ' + bairro As endereco_completo, Medicamento.nome As nome_rem�dio, apresentacao, unidade, preco, quant, valorT
From Cliente Inner Join Venda
on Cliente.CPF = Venda.cliente_cpf
Inner Join Medicamento
on Medicamento.codigo = Venda.medicamento_codigo
Where Cliente.nome = 'Maria Z�lia'
											
--Data de compra, convertida, de Carlos Campos		
Select Distinct Convert(char(10), data, 103) As data
From Venda Inner Join Cliente
On Venda.cliente_cpf = Cliente.CPF
Where nome = 'Carlos Campos'										
												
--Alterar o nome da  Amitriptilina(Cloridrato) para Cloridrato de Amitriptilina		
update Medicamento 	
Set nome = 'Cloridrato de Amitriptilina'
Where nome = 'Amitriptilina(Cloridrato)'									
