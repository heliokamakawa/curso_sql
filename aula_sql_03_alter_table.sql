/*
CURSO DE BANCO DE DADOS MySQL COM WORKBENCH - AULA 03 - Modificando tabelas
Link videoaula: https://www.youtube.com/watch?v=fyQKM1--Kpc

*/

DROP DATABASE IF EXISTS aula_banco; -- eliminado aula_banco
CREATE DATABASE aula_banco; 		-- criando aula_banco
USE aula_banco; 					-- selecionando aula_banco 

CREATE TABLE estado( 				-- criando tabela estado
id INT NOT NULL AUTO_INCREMENT
,nome VARCHAR(200) NOT NULL UNIQUE  
,sigla CHAR(2) NOT NULL UNIQUE
,ativo CHAR(1) NOT NULL DEFAULT 'S'
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,CONSTRAINT pk_estado PRIMARY KEY (id)  
,CONSTRAINT estado_ativo_deve_ser_S_ou_N CHECK (ativo IN ('S', 'N') )  
);

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

-- inserindo registros do estado
INSERT INTO estado (nome,sigla) VALUES ('PARANÁ','PR');
INSERT INTO estado (nome,sigla) VALUES ('SÃO PAULO','SP');

-- inserindo registros do cidade
INSERT INTO cidade (nome,estado_id) VALUES ('CURITIBA', 1);
INSERT INTO cidade (nome,estado_id) VALUES ('BAURU', 2);

SELECT * FROM CIDADE; -- consulta tabela cidade

/**
>>> ALTERAÇÕES EM TABELAS <<<
Caso ainda não estiver na produção, faça as alterações direto na tabela. 
→ Fica mais claro e legível. 

Se a base de dados já está na produção, não tem jeito, precisa utilizar o ALTER - COM MUITO CUIDADO
**/

-- Adicionando a coluna "regiao" na tabela estado 
-- >>> ALTER TABEL com ADD COLUMN <<<
ALTER TABLE estado ADD COLUMN regiao INT; -- colocando propositalmente o tipo errado

-- Verificando as colunas da tabela
SELECT * FROM estado; 	-- desta forma, ela traz, desnecessariamente todos os registros da tabela estado, consumindo recursos 
DESCRIBE estado; 		-- DESCRIBE "descreve" a estrutura da tabela
DESC estado;			-- DESC é apelido para DESCRIBE

/**       >>PROCESSO C1<< - se estiver utilizando Workbench
CONFIRA-1 {C1}: veja a nova coluna em SCHEMAS
(1) na aba de navegador atualize (refresh) a apresentação
(2) extenda (seta) a visão das tabelas (Tables) de aula_banco 
(3) extenda (seta) a visão de estado
(4) extenda (seta) a visão das colunas (Columns) → assim verá a nova coluna na tabela
(5) clique na coluna → na aba de informações (Information) → será apresentado informações sobre a coluna
*/

-- Modificando a coluna "regiao" para o tipo VARCHAR
-- >>> ALTER TABLE com MODIFY <<<
ALTER TABLE estado MODIFY COLUMN regiao VARCHAR(10); -- colocando propositalmente o tamanho unsuficiente
DESC estado; -- Verificando as colunas da tabela			

ALTER TABLE estado MODIFY COLUMN regiao VARCHAR(100); -- definindo o tamanho suficiente
DESC estado; -- Verificando as colunas da tabela			
-- se estiver utilizando o Workbench faça o >>PROCESSO C1<<

-- Modificando "região" para NOT NULL
ALTER TABLE estado MODIFY COLUMN regiao VARCHAR(100) NOT NULL; -- gera erro, pois a tabela já possui registros.
SELECT * FROM estado; -- reparem que, para a nova coluna, os dados ficam nulos 
-- o adicionar nova coluna com NOT NULL gera conflito, como há registros, é obvio que ficarão nulos, mas estamos definindo que é NOT NULL

-- E se realmente precisarmos definiar a nova coluna NOT NULL?
ALTER TABLE estado DROP COLUMN regiao; 									-- >>> ALTER TABLE com DROP COLUMN → eliminando a coluna
ALTER TABLE estado ADD COLUMN regiao VARCHAR(100) NOT NULL DEFAULT ''; 	-- >>> ALTER TABLE com ADD DEFAULT
SELECT * FROM estado; -- reparem que, para a nova coluna, os dados ficam nulos 

/**   >>>>CUIDADO<<<<
Tome cuidado, pois agora, todos os registros anteriores estarão vazios
Assim, os registros anteriores precisam ser CORRIGIDOS!!!
Documente e informe a equipe.
**/

/*
DEFININDO A ORDEM NA ADIÇÃO DE UMA COLUNA
Em ADD COLUMN, por padrão, adiciona a coluna na última posição 
podemos definir a posição em ADD COLUMN    
*/
ALTER TABLE estado DROP COLUMN regiao; 	-- eliminando a coluna 
ALTER TABLE estado ADD COLUMN regiao VARCHAR(100) NOT NULL DEFAULT '' FIRST; -- ALTER TABLE com ADD COLUMN FIRST → adicionando a coluna na 1º posição

-- ou
ALTER TABLE estado MODIFY COLUMN regiao VARCHAR(100) FIRST; -- ALTER TABLE com MODIFY COLUMN FIRST → MODIFY - modifica a coluna, mantendo os dados

DESC estado; -- verificando a estrutura da tabela

-- ADICIONANDO A COLUNA DEPOIS DO NOME
ALTER TABLE estado DROP COLUMN regiao; 	-- eliminando a coluna 
ALTER TABLE estado ADD COLUMN regiao VARCHAR(100) NOT NULL DEFAULT '' AFTER nome; -- ALTER TABLE com ADD COLUMN AFTER → adicionando a coluna depois do nome

-- ou 
ALTER TABLE estado MODIFY COLUMN regiao VARCHAR(100) AFTER nome; -- ALTER TABLE com MODIFY COLUMN AFTER →  MODIFY - modifica a coluna, mantendo os dados

DESC estado; -- verificando a estrutura da tabela


/* MUDANDO O NOME DA COLUNA */
ALTER TABLE estado CHANGE regiao regiao_estado VARCHAR(100) NOT NULL DEFAULT '' AFTER sigla; -- modificando nome
ALTER TABLE estado CHANGE regiao_estado regiao VARCHAR(100) NOT NULL DEFAULT '' AFTER sigla; -- voltando como estava antes

/* Alterando o tipo da coluna ativo da tabela estado de CHAR para ENUM */
ALTER TABLE estado DROP CONSTRAINT estado_ativo_deve_ser_S_ou_N; 	-- eliminando regras
ALTER TABLE estado MODIFY ativo ENUM('S','N') NOT NULL;				-- alternando o tipo
SELECT * FROM estado;												-- consultado como ficou os registros anteriores
INSERT INTO estado (nome, sigla, ativo) VALUES ('MATO GROSSO','MT','A'); -- testando a inserção de um valor errado na coluna ativo

/**
COMANDOS DDL 
DDL - Date Definition Language - Linguagem de Definição de Dados
Comandos que defininem a estrutura 
→ CREATE/ALTER/DROP TABLE
→ ALTER TABLE ADD/DROP/MODIFY/CHANGE

DML - Date Manipulation Language - Linguagem de Manipulação de Dados 
Comandos que manipulam os dados 
→ INSERT/UPDATE/DELETE/SELECT 
                                                
Bom estudo!!!
Link da videoaula: https://www.youtube.com/watch?v=fyQKM1--Kpc
**/


