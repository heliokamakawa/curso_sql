/** script do curso de banco de dados MySQL utilizando workbench**/

DROP DATABASE IF EXISTS AULA_BANCO;	/** caso exista, eliminando a base de dados AULA_BANCO **/
CREATE DATABASE AULA_BANCO; 		/** criando a base de dados **/
USE AULA_BANCO;				/** selecionando a base de dados **/


/** criando tabelas **/
CREATE TABLE ESTADO(
ID INT AUTO_INCREMENT
,NOME VARCHAR(255) NOT NULL UNIQUE 
,SIGLA CHAR(2) NOT NULL UNIQUE 
,STATUS CHAR(1) NOT NULL DEFAULT 'A' 
,DATA_CADASTRO DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,CONSTRAINT PK_ESTADO PRIMARY KEY (ID) 
);

CREATE TABLE CIDADE(
ID INT AUTO_INCREMENT 
,NOME VARCHAR(255) NOT NULL 
,STATUS CHAR(1) NOT NULL DEFAULT 'A' 
,ESTADO_ID INT NOT NULL
,DATA_CADASTRO DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,CONSTRAINT PK_CIDADE PRIMARY KEY (ID) 
,CONSTRAINT FK_CID_EST FOREIGN KEY (ESTADO_ID) REFERENCES ESTADO (ID)
,CONSTRAINT FK_CID_UNIQUE UNIQUE(NOME,ESTADO_ID)
);

/** inserindo registros **/
INSERT INTO ESTADO (NOME,SIGLA) VALUES ('PARANÁ','PR');
INSERT INTO ESTADO (NOME,SIGLA) VALUES ('SÃO PAULO','SP');
INSERT INTO ESTADO (NOME,SIGLA) VALUES ('MATO GROSSO','MT');
INSERT INTO ESTADO (NOME,SIGLA) VALUES ('SANTA CATARINA','SC');
INSERT INTO ESTADO (NOME,SIGLA) VALUES ('RIO GRANDE DO SUL','RS');

INSERT INTO CIDADE (NOME, ESTADO_ID) VALUES ('BAURU',2);
INSERT INTO CIDADE (NOME, ESTADO_ID) VALUES ('MARINGÁ',1);
INSERT INTO CIDADE (NOME, ESTADO_ID) VALUES ('GUARULHOS',2);
INSERT INTO CIDADE (NOME, ESTADO_ID) VALUES ('CAMPINAS',2);
INSERT INTO CIDADE (NOME, ESTADO_ID) VALUES ('FLORIANÓPOLIS',4);
INSERT INTO CIDADE (NOME, ESTADO_ID) VALUES ('PARANAVAÍ',1);
INSERT INTO CIDADE (NOME, ESTADO_ID) VALUES ('CUIABA',3);
INSERT INTO CIDADE (NOME, ESTADO_ID) VALUES ('BALNEÁRIO CAMBORIÚ',4);
INSERT INTO CIDADE (NOME, ESTADO_ID) VALUES ('LONDRINA',1);
INSERT INTO CIDADE (NOME, ESTADO_ID) VALUES ('CASCAVEL',1);
INSERT INTO CIDADE (NOME, ESTADO_ID) VALUES ('JOINVILLE',4);
INSERT INTO CIDADE (NOME, ESTADO_ID) VALUES ('PORTO ALEGRE',5);
INSERT INTO CIDADE (NOME, ESTADO_ID) VALUES ('BLUMENAL',4);
INSERT INTO CIDADE (NOME, ESTADO_ID) VALUES ('BARRA DOS GARÇAS',3);
INSERT INTO CIDADE (NOME, ESTADO_ID) VALUES ('CHAPECÓ',4);
INSERT INTO CIDADE (NOME, ESTADO_ID) VALUES ('ITAJAÍ',4);

/** consutla estado **/
SELECT * FROM ESTADO;

/** consutla cidade **/
SELECT * FROM CIDADE;

/** CRIANDO FUNÇÃO QUE TEM COMO PARÂMETRO, O CÓDIGO DO ESTADO E RETORNA A SIGLA DO ESTADO **/
DELIMITER //
CREATE FUNCTION BUSCAR_SIGLA(ID_ESTADO INT)
RETURNS CHAR(2) DETERMINISTIC 
BEGIN 
	DECLARE S CHAR(2);
    SELECT SIGLA INTO S FROM ESTADO WHERE ID = ID_ESTADO;
	RETURN S;
END;
//
DELIMITER ;

SELECT C.NOME 'CIDADE', C.ESTADO_ID 'ESTADO' FROM CIDADE C;
SELECT C.NOME 'CIDADE', BUSCAR_SIGLA(C.ESTADO_ID) 'ESTADO' FROM CIDADE C;

/** estrutura de repetição **/
DELIMITER //
CREATE FUNCTION imprimirAte100()
RETURNS VARCHAR(1000) DETERMINISTIC
BEGIN
	DECLARE numero INT;
    DECLARE saida VARCHAR(1000);
    
    SET numero = 0;

	meuLoop: LOOP
		SET saida = CONCAT(saida, numero);
		SET numero = numero + 1;
	END LOOP meuLoop;

RETURN saida;
END
//
DELIMITER ;

SELECT imprimirAte100(5);  						/** testando **/


/** fatorial versão 1 **/
DELIMITER //
CREATE FUNCTION calcularFatorial(numero INT)
RETURNS INT deterministic
BEGIN
	DECLARE fatorial INT;
	SET fatorial = numero ;

	meuLoop: LOOP
		SET numero = numero - 1 ;
		SET fatorial = fatorial * numero ;
	END LOOP meuLoop;

RETURN fatorial;
END
//
delimiter ;

SELECT calcularFatorial(5);  /** testando com 5 - funciona **/
SELECT calcularFatorial(0);  /** testando com 0 - não funciona **/

DROP FUNCTION IF EXISTS calcularFatorial; /** eliminando a função **/

/** fatorial versão 2 - corrigindo o bug do 0 **/
DELIMITER //
CREATE FUNCTION calcularFatorial(numero INT)
RETURNS INT deterministic
BEGIN
	DECLARE fatorial INT;
	SET fatorial = numero ;
    
	IF numero <= 0 THEN
		RETURN 1;
	END IF;

	meuLoop: LOOP
		SET numero = numero - 1 ;
		SET fatorial = fatorial * numero ;
	END LOOP meuLoop;

RETURN fatorial;
END
//
delimiter ;


SELECT calcularFatorial(7);  	/** testando - funciona **/
SELECT calcularFatorial(0);  	/** testando com 0 - funciona **/
SELECT calcularFatorial(1);  	/** testando com 1 - não funciona **/

DROP FUNCTION IF EXISTS FATORIAL;
DELIMITER //
CREATE FUNCTION fatorial(numero INT)
RETURNS INT deterministic
BEGIN
	DECLARE fatorial INT;
	SET fatorial = numero ;

	IF numero <= 0 THEN
		RETURN 1;
	END IF;

	meuLoop: LOOP
		SET numero = numero - 1 ;
		IF numero<1 THEN
			LEAVE meuLoop;
		END IF;
		SET fatorial = fatorial * numero ;
	END LOOP meuLoop;

	RETURN fatorial;
END
//
delimiter ;

SELECT calcularFatorial(10);  	/** testando - funciona **/
SELECT calcularFatorial(0);  	/** testando com 0 - funciona **/
SELECT calcularFatorial(1);  	/** testando com 1 - funciona **/

/**
devemos evitar de criar funções para facilitar a consulta... pois afetará o desempenho ...
caso seja um consulta complexa, dependendo, é muito melhor que se crie a view... 
**/

/**
*********** NÃO DEVEMOS CRIAR FUNÇÕES *********** 
simplificando...
(1) Para Consulta → neste caso, utilize o select mesmo 
(2) Para Consulta Complexa → conforme o contexto, é melhor criar uma view do que fazer uma função.
(3) Definir regras simples → utilize regras existentes: not null, unique e principalmente check - então não reivente a roda 
EXEMPLO: validação do status - tem que ser, somente A ou I → utilize CHECK
(4) Gerar um campo de resultado de outras colunas → utilize colunas virtuais
(5) Definir ações necessárias na inserção e alteração de registros → papel de trigger/gatilhos que vamos estudar ainda...
(6) Definir funções que já existem, como datas, calcular idade, manipulação de caracteres → mais uma vez não reivente a roda
o mysql possui uma vasta gama de funções nativas... assim, antes de criar verifique se já possui 

Então quando devemos criar funções? 
(1) Para fazer uma ação específica do projeto
(2) Para modularizar, centralizar um código, evitando repetição e facilitando a manutenção...
pois, caso precise, basta alterar a função, impactando todos os códigos que utilizam a função...
exemplo: validação de cpf
**/















