/**
Aula create tabel com FOREIGN KEY
Link da aula: https://www.youtube.com/watch?v=ytYPwaU-vRM
**/

DROP DATABASE IF EXISTS aula_banco; -- eliminado aula_banco
CREATE DATABASE aula_banco; 		-- criando aula_banco
USE aula_banco; 					-- selecionando aula_banco 

-- criando tabela estado
CREATE TABLE estado(
id INT NOT NULL AUTO_INCREMENT
,nome VARCHAR(200) NOT NULL UNIQUE  
,sigla CHAR(2) NOT NULL UNIQUE
,ativo CHAR(1) NOT NULL DEFAULT 'S'
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,CONSTRAINT pk_estado PRIMARY KEY (id)  -- deinimos um nome para a constraint PK
,CONSTRAINT estado_ativo_deve_ser_S_ou_N CHECK (ativo IN ('S', 'N') )  -- deinimos um nome para a constraint CHECK (ativo IN ('S', 'N') )
);

-- inserindo registros do estado
INSERT INTO estado (nome,sigla) VALUES ('PARANÁ','PR');
INSERT INTO estado (nome,sigla) VALUES ('SÃO PAULO','SP');

-- consultando a tabela estado
SELECT * FROM estado;
/**
COMO DEFINIR FK
>>>>>>>>>>DEFININDO FK sem definir o nome da regra
FOREIGN KEY (estado_id) REFERENCES estado (id) 

>>>>>>>>>>DEFININDO FK e definindo o nome da regra
CONSTRAINT nome_regra FOREIGN KEY (coluna_fk) REFERENCES tabela_referencia (pk_tabela_referencia)
**/

/**
-- sintaxe para criar tabela com FK sem definir o nome da regra
CREATE TABLE cidade (
id INT NOT NULL AUTO_INCREMENT
,nome VARCHAR(200)  NOT NULL
,ativo CHAR(1) NOT NULL DEFAULT 'S' 
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,estado_id INT NOT NULL 
,CONSTRAINT pk_cidade PRIMARY KEY (id)
,FOREIGN KEY (estado_id) REFERENCES estado (id) -- >>>>>>>>>>DEFININDO FK sem definir o nome da regra
,CONSTRAINT cidade_ativo_deve_ser_S_ou_N CHECK (ativo IN ('S','N'))
,CONSTRAINT cidade_unica UNIQUE(nome, estado_id)
);
**/

-- criando tabela cidade
CREATE TABLE cidade (
id INT NOT NULL AUTO_INCREMENT
,nome VARCHAR(200)  NOT NULL
,ativo CHAR(1) NOT NULL DEFAULT 'S' 
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,estado_id INT NOT NULL 
,CONSTRAINT pk_cidade PRIMARY KEY (id)
,CONSTRAINT fk_cidade_estado FOREIGN KEY (estado_id) REFERENCES estado (id)
,CONSTRAINT cidade_ativo_deve_ser_S_ou_N CHECK (ativo IN ('S','N'))
,CONSTRAINT cidade_unica UNIQUE(nome, estado_id)
);



-- criando um registro estado
INSERT INTO cidade (nome,estado_id) VALUES ('CURITIBA', 1);

-- consulta tabela cidade
SELECT * FROM CIDADE;

/**
Entendendo estes comandos já é possível fazer o script inteiro do nosso estudo de caso!
Se puderam, façam! A prática é a alma da aprendizagem.
                                                
Até a próxima aula!!!
**/




