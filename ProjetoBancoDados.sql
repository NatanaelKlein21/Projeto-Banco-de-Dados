-- Nomes: Lucas Navarini Lanferdini, Natanael de Campos Klein, Nicolas Scheffer Bellina e Ryan Santos Kologeski Rosa

create schema ProjetoBancodeDados;
use ProjetoBancodeDados;

-- //////////////////////////////////////////// CRIAÇÃO DAS TABELAS DO BANCO ////////////////////////////////////////////////////

create table Paciente(
codpaciente numeric (3) primary key,
cpf varchar(12) not null unique,
nome varchar(100) not null,
idade numeric(3) not null,
sexo varchar(1) not null,
endereco varchar(100) not null,
telefone varchar(11) not null,
email varchar(70) not null
);

create table Testagem(
codpaciente numeric(3) not null,
tipodetest varchar(10) not null,
resultado varchar(10) not null,
posto varchar(150) not null,
datahora_agendamento datetime,
data_result date,
foreign key (codpaciente) references Paciente(codpaciente)
);

create table Sintomas(
codsintoma numeric (2) primary key,
sintoma varchar(30) not null
);

create table RelacaoSintomas(
codpaciente numeric(3) not null,
codsintoma numeric(2) not null,
numdias_sintoma numeric(2) not null,
foreign key (codpaciente) references Paciente(codpaciente),
foreign key (codsintoma) references Sintomas(codsintoma)
);

create table Comorbidades(
codcomorbidade numeric(2) primary key,
comorbidade varchar(20) not null
);

create table RelacaoComorbidades(
codpaciente numeric(3) not null,
codcomorbidade numeric(2) not null,
descricao varchar(150) not null,
foreign key (codpaciente) references Paciente(codpaciente),
foreign key (codcomorbidade) references Comorbidades(codcomorbidade)
);

-- //////////////////////////////////////////////////// INSERÇÃO DE DADOS ///////////////////////////////////////////////////////

insert into Paciente values (123,'56222701892','Natanael Pacheco Klein',22,'M','Rua fernandes 2407','51999088372','natanael@hotmail.com');
insert into Paciente values (500,'64138569715','Lucas Moreira Moraes',55,'M','Rua dos Perdidos 3408','47993466565','LucasM@gmail.com');
insert into Paciente values (325,'14780493404','Ryan Silva da Silva',32,'M','Av. Alberto dos campos 567','51980846638','RyanSS@hotmail.com');
insert into Paciente values (411,'31344227279','Nicolas Machado de souza',70,'M','Rua das kamelias 343','51971672713','Nicolas1111@yahoo.com');
insert into Paciente values (040,'46797202710','Ana Winck Flores',26,'F','Av Ipiranga 278','51985267103','AnaWinck@gmail.com');

select * from Paciente;

insert into Sintomas values (1,'Tosse');
insert into Sintomas values (2,'Febre');
insert into Sintomas values (3,'Dor de garganta');
insert into Sintomas values (4,'Enjou');
insert into Sintomas values (5,'Dor no corpo');
insert into Sintomas values (6,'Cansaço');
insert into Sintomas values (7,'Perda de paladar');
insert into Sintomas values (8,'Perda do olfato');
insert into Sintomas values (9,'Diarreia');
insert into Sintomas values (10,'Dificuldade para respirar');

select * from Sintomas;

insert into Comorbidades values(1,'Obesidade');
insert into Comorbidades values(2,'Hipertensão');
insert into Comorbidades values(3,'Diabetes');
insert into Comorbidades values(4,'Asma');
insert into Comorbidades values(5,'Miocardite');

select * from Comorbidades;

insert into Testagem values(123,'TR','Positivo','UBS Santa Margarida','2022-06-08 10:34:09','2022-06-08');
insert into Testagem values(500,'RT-qPCR','Positivo','UBS Serraria','2021-11-02 16:20:10','2022-11-06');
insert into Testagem values(325,'TR','Positivo','UBS Serra Gaucha','2022-03-03 9:22:32','2022-03-03');
insert into Testagem values(411,'RT-qPCR','Negativo','UBS Igara','2022-05-16 20:50:54','2022-05-19');
insert into Testagem values(123,'RT-qPCR','Negativo','UBS Santa Margarida','2022-06-10 14:50:45','2022-06-11');

select * from Testagem; 

insert into RelacaoSintomas values(123,1,4);
insert into RelacaoSintomas values(123,2,4);
insert into RelacaoSintomas values(123,6,7);
insert into RelacaoSintomas values(123,3,7);
insert into RelacaoSintomas values(411,1,3);
insert into RelacaoSintomas values(411,3,3);
insert into RelacaoSintomas values(500,1,4);
insert into RelacaoSintomas values(500,2,5);
insert into RelacaoSintomas values(500,3,6);
insert into RelacaoSintomas values(325,1,3);

select * from RelacaoSintomas;

insert into RelacaoComorbidades values(123,'1','IMC muito acima de 30');
insert into RelacaoComorbidades values(500,'3','Diabetes Melitus tipo 1');
insert into RelacaoComorbidades values(500,'4','Asma Hereditaria');

select * from RelacaoComorbidades;

-- //////////////////////////////////////////////////// CONSULTAS ///////////////////////////////////////////////////////

-- CONSULTA 1 // NÃO CONSEGUIMOS FAZER
Select count(RS.codsintoma) as "contagem"
from Paciente P 
left join relacaosintomas RS on P.codpaciente = RS.codpaciente
group by RS.codsintoma
having contagem >= 2;

-- CONSULTA 2
select count(codpaciente), tipodetest
from testagem
where resultado = "Positivo"
group by tipodetest;

-- CONSULTA 3
select p.nome, p.idade, t.tipodetest , t.data_result
from paciente p 
inner join testagem t on p.codpaciente = t.codpaciente
where t.resultado = "Positivo";

-- CONSULTA 4
select count(p.codpaciente)
from paciente p 
inner join testagem t on p.codpaciente = t.codpaciente
where t.resultado = "Negativo";

-- CONSULTA 5
select p.*
from paciente p
inner join testagem t on p.codpaciente = t.codpaciente
where t.resultado = "Positivo"
having min(p.idade);