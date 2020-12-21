/*
Aula 6 - Date Manipulation Language (DML) - Linuguagem de Manipulação de Dados
Link videoaula → 
*/

DROP DATABASE IF EXISTS aula_banco; -- se existir elimine aula_banco
CREATE DATABASE aula_banco; 		-- criar aula_banco
USE aula_banco;						-- selecionar aula_banco

CREATE TABLE estado( 				-- criando a tabela estado
id INT NOT NULL AUTO_INCREMENT
,nome VARCHAR(200) NOT NULL UNIQUE  
,sigla CHAR(2) NOT NULL UNIQUE
,ativo ENUM('S','N') NOT NULL DEFAULT 'S'
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,CONSTRAINT pk_estado PRIMARY KEY (id)  
);

CREATE TABLE cidade (				-- criando a tabela cidade
id INT NOT NULL AUTO_INCREMENT
,nome VARCHAR(200)  NOT NULL
,ativo ENUM('S','N') NOT NULL DEFAULT 'S'
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,estado_id INT NOT NULL 
,CONSTRAINT pk_cidade PRIMARY KEY (id)
,CONSTRAINT fk_cidade_estado FOREIGN KEY (estado_id) REFERENCES estado (id)
,CONSTRAINT cidade_unica UNIQUE(nome, estado_id)
);

-- inserindo estados
INSERT INTO estado (nome,sigla) VALUES ('PARANÁ','PR');
INSERT INTO estado (nome,sigla) VALUES ('SÃO PAULO','SP');
INSERT INTO estado (nome,sigla) VALUES ('MATO GROSSO','MT');
INSERT INTO estado (nome,sigla) VALUES ('SANTA CATARINA','SC');
INSERT INTO estado (nome,sigla) VALUES ('RIO GRANDE DO SUL','RS');

-- inserindo cidades
INSERT INTO cidade (nome, estado_id) VALUES ('BAURU',2);
INSERT INTO cidade (nome, estado_id) VALUES ('MARINGÁ',1);
INSERT INTO cidade (nome, estado_id) VALUES ('GUARULHOS',2);
INSERT INTO cidade (nome, estado_id) VALUES ('CAMPINAS',2);
INSERT INTO cidade (nome, estado_id) VALUES ('FLORIANÓPOLIS',4);
INSERT INTO cidade (nome, estado_id) VALUES ('PARANAVAÍ',1);
INSERT INTO cidade (nome, estado_id) VALUES ('CUIABA',3);
INSERT INTO cidade (nome, estado_id) VALUES ('BALNEÁRIO CAMBORIÚ',4);
INSERT INTO cidade (nome, estado_id) VALUES ('LONDRINA',1);
INSERT INTO cidade (nome, estado_id) VALUES ('CASCAVEL',1);
INSERT INTO cidade (nome, estado_id) VALUES ('JOINVILLE',4);
INSERT INTO cidade (nome, estado_id) VALUES ('PORTO ALEGRE',5);
INSERT INTO cidade (nome, estado_id) VALUES ('BLUMENAL',4);
INSERT INTO cidade (nome, estado_id) VALUES ('BARRA DOS GARÇAS',3);
INSERT INTO cidade (nome, estado_id) VALUES ('CHAPECÓ',4);
INSERT INTO cidade (nome, estado_id) VALUES ('ITAJAÍ',4);

-- ALTERNANDO UMA COLUNA DE UM ÚNICO REGISTRO
UPDATE estado SET nome = 'PARANA' WHERE id = 1;

-- ALTERNANDO DUAS COLUNAS DE UM ÚNICO REGISTRO
UPDATE estado SET nome = 'PARANÁ', ativo = 'N' WHERE id = 1;


-- ALTERNANDO TRÊS COLUNAS DE UM ÚNICO REGISTRO
UPDATE estado SET nome = 'Paraná', ativo = 'S', data_cadastro = '2020-10-15' WHERE id = 1;

-- ALTERNANDO COM DATA E HORA DO SISTEMA - CURRENT_TIMESTAMP é uma variável do MySQL que pega a data e hora no momento da alteração
UPDATE estado SET data_cadastro = CURRENT_TIMESTAMP WHERE id = 1;

-- ALTERNANDO COM DEFAULT - DEFAULT pega o valor padrão da coluna definida na tabela
UPDATE estado SET nome = 'PARANÁ', data_cadastro = DEFAULT WHERE id = 1;

-- CUIDADO!!! Para alterar um único registro utilize PK ou campos com a restrição UNIQUE
UPDATE estado SET nome = 'PARANA' WHERE id = 1; 			-- PK
UPDATE estado SET nome = 'PARANA' WHERE nome = 'PARANÁ';	-- usa o nome que é UNIQUE
UPDATE estado SET nome = 'PARANA' WHERE sigla = 'PR';		-- usa a sigla que é UNIQUE

-- ALTERA TODOS OS REGISTROS DA TABELA - NÃO TEM WHERE - TOME CUIDADO
UPDATE estado SET ativo = 'N';

-- ALTERA UM GRUPO ESPECÍFICO - TODAS AS CIDADE DO PARANÁ
UPDATE cidade SET ativo = 'N' WHERE estado_id = 1;




-- COMANDO DELETE 

-- EXCLUINDO UM ÚNICO REGISTRO - UTILIZE PK OU CAMPO QUE TENHA ÚNIQUE
DELETE FROM cidade WHERE id = 1;

-- EXCLUINDO UM CONJUNTO DE REGISTROS - TODAS AS CIDADES DO PARANÁ
DELETE FROM cidade WHERE estado_id = 1;

-- CASO QUEIRA EXCLUIR UMA ÚNICA CIDADE O COMANDO ABAIXO ESTÁ ERRADO - NOME DE CIDADE NÃO É UNIQUE
-- DELETE FROM cidade WHERE nome = 'xxx'; -- PDOERÁ EXCLUIR MAIS QUE UMA CIDADE

/*
 EM CONFIGURAÇÃO PADRÃO, SE TENTAR EXCLUIR O COMANDO ABAIX DARÁ ERRO
 POIS HÁ VÁRIAS CIDADES ASSOCIADAS AO REGISTRO
DELETE FROM estado WHERE id = 2; 

CASO QUEIRA, SERÁ NECESSÁRIO PRIMEIRO, EXCLUIR AS CIDADES ASSOCIADAS
DELETE FROM cidade WHERE estado_id = 2;

AÍ SIM, PODERÁ EXCLUIR
DELETE FROM estado WHERE id = 2; 
*/

-- EXCLUÍNDO TODAS AS CIDADES
DELETE FROM cidade;



SELECT * FROM estado;
SELECT * FROM cidade;























