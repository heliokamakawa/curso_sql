/**
Primeira aula de SQL
link da videoaula: https://www.youtube.com/watch?v=yS6wtk55ZDs
**/


/**
eliminando base de dados 
só executa se existir (IF EXISTS)
*/
DROP DATABASE IF EXISTS aula_banco; 

CREATE DATABASE aula_banco; -- criando a base de dados

/**
selecionando a base de dados
→ defindo qual banco estaremos manipulando
*/
USE aula_banco; 


/**
eliminando tabela
só executa se existir (IF EXISTS)
→ podemos remover este comando para o script final
*/
DROP TABLE IF EXISTS estado;


/**
criando tabela estado - verão 1
definindo colunas e seus respectivos tipos
INT - números inteiros
VARCHAR e CHAR - conjunto de caracteres - o dado inserido não pode ser maior do que o tamanho definido
VARCHAR - tamanho dinâmico (ocupa o tamanho do dado inserido)
CHAR - tamanho definido (independente do dado inserido, ocupa o tamanho definido)
DATETIME - pode armazenar data e hora
*/

CREATE TABLE estado(
id INT PRIMARY KEY,
nome VARCHAR(200),
sigla CHAR(2),
ativo CHAR(1), 
data_cadastro DATETIME
);
/**
No início do desenvolvimento, principalmente para quem está aprendendo é comum precisar recriar a tabela
inserindo ou excluíndo registros... 
da forma como criamos, é mais trabalhoso eliminar/inserir colunas ... 
experimente apagar a linha da última coluna.. o comando fica errado 
pois é necessário excluir a vírgula da linha anterior
**/


DROP TABLE IF EXISTS estado; -- eliminando a tabela para criar em uma sintaxe mais fácil de dar manutenção
/**
criando tabela estado - verão 2
uma sintaxe mais fácil de dar manutenção 
neste estilo podemos apagar ou comentar qualquer linha - o comando permanece com a sintaxe certa
*/
CREATE TABLE estado(
id INT PRIMARY KEY
,nome VARCHAR(200) 
,sigla CHAR(2) 
,ativo CHAR(1) 
,data_cadastro DATETIME 
);


INSERT INTO estado (id,nome,sigla,ativo,data_cadastro) VALUES (1,'PARANÁ','PR','S','2020-12-15');	-- inserindo registro na tabela estado
SELECT id, nome, sigla, ativo, data_cadastro FROM estado;											-- consultado a tabela estado
INSERT INTO estado (id,nome,sigla,ativo,data_cadastro) VALUES (2,'PARANÁ','PR','S','2020-12-15');	-- da forma que criamos ele aceita estados com nomes e siglas iguais
INSERT INTO estado (id,nome,sigla,ativo,data_cadastro) VALUES (3,NULL,NULL,'S','2020-12-15'); 		-- da forma que criamos ele aceita dados nulos
INSERT INTO estado (id,nome,sigla,ativo,data_cadastro) VALUES (4,'SÃO PAULO','SP',8,'2020-12-15');	-- da forma que criamos ele aceita valores sem sentido para a coluna "ativo"



DROP TABLE IF EXISTS estado; -- eliminando tabela para corrigir as falhas
/**
criando tabela estado - verão 3
definindo regras - CONSTRAINTS
NULL - campos não obrigatórios, aceita dados nulos
NOT NULL - campo obrigatório, não aceita dados nulos
UNIQUE - registro único na tabela
CHECK - checa um valor, podemos verificar e/ou restringir um conjunto de valores 
PRIMARY KEY - define que uma coluna seja a chave primária
*/
CREATE TABLE estado(
id INT NOT NULL PRIMARY KEY
,nome VARCHAR(200) NOT NULL UNIQUE  
,sigla CHAR(2) NOT NULL UNIQUE
,ativo CHAR(1) NOT NULL 
,data_cadastro DATETIME NOT NULL
,CHECK (ativo IN ('S', 'N') )  
);

/**
CONSTRAINT INLINE - Regras definidas na mesma linha
nome VARCHAR(200) NOT NULL UNIQUE  

CONSTRAINT OUT OF LINE - Regras definidas fora linha da definição de coluna
ativo CHAR(1) NOT NULL  		→ definindo a coluna
CHECK (ativo IN ('S', 'N') )  	→ fora da linha da definição da coluna definindo a regra/constraint
**/

-- inserindo registro na tabela estado
INSERT INTO estado (id,nome,sigla,ativo,data_cadastro) VALUES (1,'PARANÁ','PR','S','2020-12-15');
/** teste de erro - para testar, é só tirar do comentário
INSERT INTO estado (id,nome,sigla,ativo,data_cadastro) VALUES (2,'PARANÁ','PR','S','2020-12-15'); 	-- testando estamos com nomes iguais → agora gera erro, pois estado e sigla é UNIQUE 
INSERT INTO estado (id,nome,sigla,ativo,data_cadastro) VALUES (3,NULL,NULL,'S','2020-12-15');		-- testando a inserção de dado nulos → agora gera erro, pois definimos que os campos são obrigatórios (NOT NULL)
INSERT INTO estado (id,nome,sigla,ativo,data_cadastro) VALUES (4,'SÃO PAULO','SP',8,'2020-12-15');	-- testando inserção de valores errados na coluna ativo - agora gera erro, ativo deve ser 'S' ou 'N"
**/

-- eliminando tabela para definir regras/CONSTRAINTS nomeadas
DROP TABLE IF EXISTS estado;

/**
criando tabela estado - verão 4
definindo regras nomeadas
CONSTRAINT nome_da_regras REGRAS parametros_da_regras
Porque definir nomes para regras?
(1) Quando gera o erro, mosta o nome definido
(1) Facilita na administração de BD

obs: não exagere, não coloque nomes de regras em tudo, pois consome recurso
*/
CREATE TABLE estado(
id INT NOT NULL 
,nome VARCHAR(200) NOT NULL UNIQUE  
,sigla CHAR(2) NOT NULL UNIQUE
,ativo CHAR(1) NOT NULL 
,data_cadastro DATETIME NOT NULL
,CONSTRAINT pk_estado PRIMARY KEY (id)  -- deinimos um nome para a constraint PK
,CONSTRAINT coluna_ativo_deve_ser_S_ou_N CHECK (ativo IN ('S', 'N') )  -- deinimos um nome para a constraint CHECK (ativo IN ('S', 'N') )
);

/** teste de erro - para testar, é só tirar do comentário
INSERT INTO estado (id,nome,sigla,ativo,data_cadastro) VALUES (4,'SÃO PAULO','SP',8,'2020-12-15');	-- agora, o log mostra o nome da regra
**/


DROP TABLE IF EXISTS estado; -- eliminando tabela para facilitar inserções de dados
/**
criando tabela estado - verão 4
definindo auto incremento e valores padrões 
AUTO_INCREMENT → MySQL gera automaticamente um valor numérico sequencial 
DEFAULT → podemos definir um valor padrão
*/
CREATE TABLE estado(
id INT NOT NULL AUTO_INCREMENT
,nome VARCHAR(200) NOT NULL UNIQUE  
,sigla CHAR(2) NOT NULL UNIQUE
,ativo CHAR(1) NOT NULL DEFAULT 'S'
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,CONSTRAINT pk_estado PRIMARY KEY (id)  -- deinimos um nome para a constraint PK
,CONSTRAINT coluna_ativo_deve_ser_S_ou_N CHECK (ativo IN ('S', 'N') )  -- deinimos um nome para a constraint CHECK (ativo IN ('S', 'N') )
);

/**
agora id é auto incremento, ativo tem valor padrão 'S', e data_cadastro tem o valor padrão CURRENT_TIMESTAMP (uma varíavel do MySQL que pega a data e hora no momento do cadastro)
não precisamos mais informar id, ativo e data_cadasro 
ficando muito mais fácil e seguro, pois agora a data e hora é fornecido pelo sistema
**/
INSERT INTO estado (nome,sigla) VALUES ('PARANÁ','PR');
INSERT INTO estado (nome,sigla) VALUES ('SÃO PAULO','SP');

INSERT INTO estado (nome,sigla,ativo) VALUES ('MATO GROSSO','MT','N'); -- caso queira inserir um cadastro 'não ativo', basta informar explicitamente

SELECT id,nome,sigla,ativo,data_cadastro FROM estado; -- consultando a tabela

/**
espero que você tenha entendido!!! o segredo é praticar!!! 
Bom estudo!!! Até a próxima aula
link da videoaula: https://www.youtube.com/watch?v=yS6wtk55ZDs
**/
