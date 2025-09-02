-- Comando para criar banco de dados. Ultilizaremos o comando CREAT DATABASE
CREATE DATABASE casaoliveira;
-- O comando USE, seliciona o banco que deseja trabalhar
USE casaoliveira;
 -- Criação da tabela Clientes

CREATE TABLE Clientes(
id_clientes int auto_increment primary key not null,
nome_completo varchar(100) not null,
cpf int unique not null,
endereco varchar(200) not null,
telefone char(20),
data_nacimento date not null,
email varchar(100)
);

CREATE TABLE Funcionarios(
id_funcionarios int auto_increment primary key not null,
nome_completo varchar(100) not null,
cpf int unique not null,
endereco varchar(200) not null,
telefone char(30) not null,
estado_civil enum('Casado(a)','Solteiro(a)','Viúvo(a)','União Estável','Outros'),
dependentes int not null,
data_nacimento date not null,
cargo varchar(30) not null,
turno int not null,
salario decimal(7,2) not null,
email varchar(100) not null
);
 
CREATE TABLE Produtos(
id_produtos int auto_increment primary key not null,
nome_produtos varchar(50) not null,
preco_custo decimal(8,2) not null,
tipo_produto varchar(40) not null,
marca varchar(50) not null,
fornecedor varchar(255) not null,
preco_venda decimal(6,2) not null
);
 
CREATE TABLE Estoques(
id_estoque int auto_increment primary key not null,lotes int not null,
data_entrada date default current_timestamp,
quantidade int not null,
setor varchar(40) not null
);

CREATE TABLE Vendas(
id_vendas int auto_increment primary key not null,
data date default current_timestamp,
hora time default current_timestamp,
clientes int not null,
funcionarios int not null,
total decimal(8,2) not null
);

CREATE TABLE Itens_Vendidos(
id_itens_vendidos int auto_increment primary key not null,
quantidade int default 1 not null,
vendas int not null,
codigo_produto int not null,
desconto decimal(5,2),
subtotal decimal(6,2) not null
);

CREATE TABLE Pagamentos(
id_pagamentos int auto_increment primary key not null,
valor_pago decimal(8,2) not null,
bandeiras varchar(20),
forma_pagamento enum('pix','Dinheiro','Crédito','Débito','Alimentação','Refeição'),
data_hora datetime default current_timestamp,
troco decimal(5,2),
vendas int not null
);

CREATE TABLE Lotes(
id_lotes int auto_increment primary key not null,
produtos int not null,
data_fabricacao date not null,
data_validade date not null
);

/*
Vamos criar os relacionamentos entre as tabelas.
Começamos com a tabela estoque, que faz relação com 
a tabela de lotes. Os dados são trocados entre os
campos lotes(tabela estoques) e id_lotes(tabela lotes).
Alteramos a estrutura da tabela estoque para adicionar
uma chave estrangeira e, também uma restrição com um
nome para identificar os relacionamento.
O comando add constraint indica a adição da restrição
do relacionamento seguindo pelo nome da restrição.
Veja que foi adotado o padrão fk-> para indicar
chave estrangeira e pk-> para indicar uma chave primária
o comando Foreign key diz qual o campo é chave estrangeira
e o comando refences indica qual é tabela e o campo
que são chave primária.
*/
 
ALTER TABLE estoques
ADD CONSTRAINT `fk_estoques_pk_lotes`
FOREIGN KEY estoques(`lotes`)
REFERENCES lotes(`id_lotes`);
 
ALTER TABLE vendas
ADD CONSTRAINT `fk_vendas_pk_clientes`
FOREIGN KEY vendas(`clientes`)
REFERENCES clientes(`id_clientes`);
 
ALTER TABLE vendas
ADD CONSTRAINT `fk_vendas_pk_funcionarios`
FOREIGN KEY vendas(`funcionarios`)
REFERENCES funcionarios(`id_funcionarios`);
 
ALTER TABLE itens_vendidos
ADD CONSTRAINT `fk_itens_vendidos_pk_vendas`
FOREIGN KEY itens_vendidos(`vendas`)
REFERENCES vendas(`id_vendas`);
 
ALTER TABLE itens_vendidos
ADD CONSTRAINT `fk_itens_vendidos_pk_produtos`
FOREIGN KEY itens_vendidos(`codigo_produto`)
REFERENCES produtos(`id_produtos`);
 
ALTER TABLE pagamentos
ADD CONSTRAINT `fk_pagamentos_pk_vendas`
FOREIGN KEY pagamentos(`vendas`)
REFERENCES vendas(`id_vendas`);
 
ALTER TABLE lotes
ADD CONSTRAINT `fk_lotes_pk_produtos`
FOREIGN KEY lotes(`produtos`)
REFERENCES produtos(`id_produtos`);
 
 
 