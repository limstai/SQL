CREATE DATABASE ExercicioRevisao2_1
GO
USE ExercicioRevisao2_1
GO
CREATE TABLE motorista (
codigo int not null,
nome varchar(40) not null,
data_nascimento date not null,
naturalidade varchar (40)
PRIMARY KEY (codigo)
)
GO
CREATE TABLE onibus (
Placa varchar (7) not null,
marca varchar (20) not null,
ano int not null,
descricao varchar (30) not null
PRIMARY KEY (placa)
)
GO
CREATE TABLE viagem (
codigo int not null,
onibus varchar(7),
motorista int not null,
hora_saida time not null,
hora_chegada time not null,
destino varchar (20) not null
PRIMARY KEY (codigo)
FOREIGN KEY (motorista)
REFERENCES  motorista (codigo),
FOREIGN KEY (onibus)
REFERENCES onibus (placa)
)
GO
INSERT INTO motorista VALUES
( 12341,'    Julio Cesar',    '1978-04-18',    'São Paulo' ),
(12342,'    Mario Carmo',    '2002-07-29',    'Americana'),
(12343,    'Lucio Castro',    '1969-12-01',    'Campinas'),
(12344,'    André Figueiredo',    '1999-05-14','    São Paulo'),
(12345,    'Luiz Carlos ',    '2001-01-09',    'São Paulo')
GO
INSERT INTO onibus VALUES
('adf0965'   ,    'Mercedes'    ,            1999    ,'Leito ' ) ,            
('bhg7654 ' ,     'Mercedes  ' ,             2002    ,'Sem Banheiro '),       
('dtr2093' ,      'Mercedes'  ,              2001    ,'Ar Condicionado'),     
('gui7625',       'Volvo  '  ,               2001    ,'Ar Condicionado ')    
GO
INSERT INTO viagem VALUES
(101,    'adf0965 '  ,    12343,    '10:00',    '12:00'    ,'Campinas'),
(102,    'gui7625'   ,    12341,    '7:00',    '12:00'    ,'Araraquara'),
(103,    'bhg7654 '  ,    12345,    '14:00',    '22:00',    'Rio de Janeiro'),
(104,    'dtr2093'  ,     12344,    '18:00',    '21:00'    ,'Sorocaba')


Select Convert(char(5),hora_chegada,108) As hora_chegada, Convert(char(5),hora_saida,108) As hora_saida, destino
From viagem

Select nome
From motorista Inner Join viagem
On motorista.codigo = viagem.motorista
Where destino = 'Sorocaba'

Select descricao
From onibus Inner Join viagem
On onibus.Placa = viagem.onibus
Where destino = 'Rio de Janeiro'

Select descricao, marca, ano 
From onibus Inner Join viagem
On onibus.Placa = viagem.onibus
Inner Join motorista
On motorista.codigo = viagem.motorista
Where nome = 'Luiz Carlos'

Select nome, DateDiff(Day, data_nascimento, GetDate())/365 As idade, naturalidade 
From motorista 
Where  DateDiff(Day, data_nascimento, GetDate())/365 > 30