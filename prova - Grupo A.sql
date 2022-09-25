create database seguradora;

create table estados(
			 cod_estado char(2) primary key not null,
			 nome_estado varchar(100) not null);
			 
create table cidades(
			 cod_cidade serial primary key not null ,
			 nome_cidade varchar(100) not null,
			 cod_estado char(2) not null, constraint fk_estado_cidade foreign key (cod_estado)
			 references estados(cod_estado));
			 
create table pessoasfisicas (
			 cpf varchar(20) primary key not null,
	   		 rg varchar(50) not null,
			 nome_completo varchar(100) not null,
	    	 cod_cidade int not null, constraint fk_cidade_pessoa foreign key (cod_cidade)
			 references cidades(cod_cidade),
			 data_nascimento date not null);
			 
create table marcas(
			 cod_marca serial primary key not null,
			 nome_marca varchar(100) not null);
			 
create table modelos(
			 cod_modelo serial primary key not null ,
			 nome_modelo varchar(100) not null,
			 tipo_modelo varchar(100) not null,
			 cor_modelo varchar(50) not null,
			 cod_cidade int not null, constraint fk_cidade_modelo foreign key (cod_cidade)
			 references cidades(cod_cidade),
			 cod_marca int not null, constraint fk_marca_modelo foreign key (cod_marca)
			 references marcas(cod_marca));
			 
create table veiculos(
			 cod_veiculo serial primary key not null ,
			 cod_modelo int not null, constraint fk_modelos_veiculos foreign key (cod_modelo)
			 references modelos(cod_modelo),
		 	 ano_modelo int not null,
			 ano_fabricacao int not null,
			 proprietario varchar(20) not null, constraint fk_pessoas_veiculos foreign key
			(proprietario) references pessoasfisicas(cpf));
			
create table sinistros(
			 cod_sinistro serial not null primary key ,
			 cod_veiculo int not null, constraint fk_veiculos_sinistros foreign key
			 (cod_veiculo) references veiculos(cod_veiculo),
			 motorista varchar(20) not null, constraint fk_pessoasfisicas_sinistro foreign key
			 (motorista) references pessoasfisicas(cpf),
			 data_sinistro timestamp not null,
			 valor_sinistro float not null);
			 
insert into estados (cod_estado, nome_estado) 
			values ('PR', 'Paraná'), ('SC', 'Santa Catarina'), 
			('RS', 'Rio Grande do Sul'), ('SP', 'São Paulo'), ('RJ', 'Rio de Janeiro');

insert into cidades (nome_cidade, cod_estado) 
			values ('Pato Branco', 'PR'), ('Guarapuava', 'PR'), 
				   ('Bauru', 'SP'), ('Curitiba', 'PR'), ('Florianópolis', 'SC');

insert into pessoasfisicas (cpf, rg, nome_completo, cod_cidade, data_nascimento)
			values ('11111111111', '11111111111', 'Pessoa 1', 1, '1970-01-01'),
			('22222222222', '22222222', 'Pessoa 2', 2, '1970-01-01'),
			('33333333333', '333333333', 'Pessoa 3', 2, '1980-01-01'),
			('44444444444', '333333333', 'Pessoa 4', 3, '1990-01-01'),
			('55555555555', '555555555', 'Pessoa 5', 5, '1960-01-01');

insert into marcas (nome_marca) values ('VW'), ('GM'), ('Fiat'), ('Ford'), ('Renault');

insert into modelos (nome_modelo, tipo_modelo, cor_modelo, cod_cidade, cod_marca)
			values ('Astra', 'GS', 'Vermelha', 2, 2),
			('Blazer', 'LTE', 'Prata', 2, 2),
			('Doblô', 'EX', 'Preta', 1, 3),
			('Up', 'TSI', 'Branca', 4, 1),
			('Logan', 'Exp', 'Cinza', 3, 5);

insert into veiculos (cod_modelo, ano_modelo, ano_fabricacao, proprietario)
			values (3, '1995', '1994', '11111111111'),
			(5, '2011', '2011', '33333333333'),
			(1, '2020', '2019', '55555555555'),
			(1, '2019', '2019', '44444444444'),
			(2, '2014', '2013', '22222222222');

insert into sinistros (cod_veiculo, motorista, data_sinistro, valor_sinistro)
			values (1, '11111111111', '2017-11-10', 55000),
			(3, '33333333333', '2019-02-20', 9250),
			(3, '55555555555', '2017-08-13', 12500),
			(4, '44444444444', '2020-01-14', 17750),
			(4, '22222222222', '2021-02-08', 19999),
			(5, '22222222222', '2021-03-09', 28000),
			(1, '22222222222', '2020-06-14', 73000);
			
select p.nome_completo, p.rg from pessoasfisicas p 
inner join cidades c on c.cod_cidade  = p.cod_cidade
where (c.cod_estado = 'SC') or (c.cod_estado = 'PR')
order by p.data_nascimento, p.nome_completo;

select v.cod_veiculo, m.nome_modelo from veiculos v
inner join modelos m on m.cod_modelo = v.cod_modelo
where v.cod_veiculo not in (select s.cod_veiculo from sinistros s);

select v.cod_veiculo, m.nome_modelo from veiculos v
inner join modelos m on m.cod_modelo = v.cod_modelo
inner join marcas ma on ma.cod_marca = m.cod_marca
where (v.cod_veiculo not in (select s.cod_veiculo from sinistros s))
and (ma.nome_marca = 'Fiat');

select s.cod_sinistro, m.nome_modelo from sinistros s
inner join veiculos v on v.cod_veiculo = s.cod_veiculo
inner join modelos m on m.cod_modelo = v.cod_modelo
inner join marcas ma on ma.cod_marca = m.cod_marca
where (s.valor_sinistro > 18000)
and (ma.nome_marca = 'VW')
order by s.data_sinistro;

alter table sinistros add column PercaTotal bool;

update sinistros set Percatotal =
case 
	when valor_sinistro < 30000 then false 
else 
	true 
end;

create table seguradoras(
			 cod_seguradora serial constraint pk_cod_seguradora primary key not null,
			 nome varchar (50) constraint nnnome not null,
			 endereco varchar (100) constraint nnendereco not null,
			 cep varchar (10) constraint nncep not null,
			 cod_cidade int constraint nncod_cidade not null,
			 constraint fk_cidades_seguradoras foreign key
			 (cod_cidade) references cidades(cod_cidade),
			 fone varchar(20) constraint nnfone not null,
			 email varchar(50) constraint nnemail not null);
			
alter table veiculos add column cod_seguradora int;

alter table veiculos add constraint fk_seguradoras_veiculos
foreign key (cod_seguradora) references seguradoras(cod_seguradora); 

insert into seguradoras (nome, endereco, cep, cod_cidade, fone, email) values ('HDI Seguros', 'rua verde numero 5', '85509-370', 1, '4002-8922', 'hdiseguros@gmail.com' );

update veiculos set cod_seguradora = 1;


-- Autoavalição: todos colaboraram.


