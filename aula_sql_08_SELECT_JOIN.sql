/*
AULA 08 - JOIN (Junções)
videoaula: https://www.youtube.com/watch?v=wm3e7rICW2I

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
INSERT INTO estado (id,nome, sigla, ativo, data_cadastro) VALUES (1,'SÃO PAULO','SP','S','2015-10-31');
INSERT INTO estado (id,nome, sigla, ativo, data_cadastro) VALUES (2,'PARANÁ','PR','S','2015-2-25');
INSERT INTO estado (id,nome, sigla, ativo, data_cadastro) VALUES (3,'MATO GROSSO','MT','N','2015-12-02');

-- inserindo cidades
INSERT INTO cidade (nome, estado_id) VALUES ('BAURU',1);
INSERT INTO cidade (nome, estado_id) VALUES ('MARINGÁ',2);
INSERT INTO cidade (nome, estado_id) VALUES ('BARRA DOS GARÇAS',3);

SELECT * FROM cidade;

/*
JOIN - combina todos os registros de todas as tabelas envolvidas 
INDEPNEDENTE DA INFORMAÇÃO ESTAR CORRETA
EXECUTE OS COMANDOS ABAIXO PARA VER OS RESULTADOS
*/
-- JOIN Padrão SQL 89
SELECT 	*
FROM estado, cidade; 

-- JOIN Padrão SQL 92
SELECT *
FROM estado
JOIN cidade ON cidade.estado_id = estado.id;

/*
Para apresentar o resultado correto no JOIN 
precisamos definir o condição de junção
que seria comparando a FK com a Pk da tabela correta
no nosso, exemplo, precismoas conidcionar a junção da cidade com estado para registros que tem a referência do estado igual ao identificador do estado 
no caso → cidade.estado_id = estado.id
*/
-- SQL 89 → AGORA AS INFORMAÇÕES ESTÃO CORRETAS
SELECT 	*
FROM estado, cidade
WHERE cidade.estado_id = estado.id;

-- SQL 92 → AGORA AS INFORMAÇÕES ESTÃO CORRETAS
SELECT *
FROM estado
JOIN cidade ON cidade.estado_id = estado.id;


/*
Podemos especificar colunas
*/
-- SQL 89
SELECT 	
	cidade.id 'ID CIDADE'
    ,cidade.nome 'NOME CIDADE'
    ,estado.sigla 'SIGLA ESTADO'
FROM estado, cidade
WHERE cidade.estado_id = estado.id;

-- SQL 92
SELECT 
	cidade.id 'ID CIDADE'
    ,cidade.nome 'NOME CIDADE'
    ,estado.sigla 'SIGLA ESTADO'
FROM estado
JOIN cidade ON cidade.estado_id = estado.id;

/*
Para colunas que possuem nomes iguais em ambas tabelas (id, nome), somos obrigados a especificar a tabela 
SELECT 	
	id  -- esta consulta gera erro, pois o BD não irá saber qual id apresentar (estado? cidade?)
    ,cidade.nome 'NOME CIDADE'
    ,estado.sigla 'SIGLA ESTADO'
FROM estado, cidade
WHERE cidade.estado_id = estado.id;
*/



/*
Podemos adicionar filtros
*/

-- SQL 89
SELECT 	
	cidade.id 'ID CIDADE'
    ,cidade.nome 'NOME CIDADE'
    ,estado.sigla 'SIGLA ESTADO'
FROM estado, cidade
WHERE cidade.estado_id = estado.id
	AND estado.nome = 'PARANÁ';

-- SQL 92
SELECT 
	cidade.id 'ID CIDADE'
    ,cidade.nome 'NOME CIDADE'
    ,estado.sigla 'SIGLA ESTADO'
FROM estado
JOIN cidade ON cidade.estado_id = estado.id 
WHERE estado.nome = 'PARANÁ';


