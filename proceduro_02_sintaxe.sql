/** script do curso de banco de dados MySQL utilizando workbench**/
DROP DATABASE IF EXISTS aula_banco;	/** Caso exista - elimine a base de dados aula_banco */
CREATE DATABASE aula_banco;			/** criando o banco aula_banco */
USE aula_banco;						/** selecionando o banco criado */

/** criando tabelas **/
CREATE TABLE endereco(
id INT AUTO_INCREMENT AUTO_INCREMENT
,rua VARCHAR(255) NOT NULL  
,numero INT NOT NULL 
,CONSTRAINT pk_endereco PRIMARY KEY (id) 
,CONSTRAINT endereco_unico UNIQUE(rua,numero)
);

CREATE TABLE cliente(
id INT AUTO_INCREMENT AUTO_INCREMENT
,nome VARCHAR(255) NOT NULL 
,endereco_id INT NOT NULL
,CONSTRAINT pk_cliente PRIMARY KEY (id) 
,CONSTRAINT fk_cliente_endereco FOREIGN KEY (endereco_id) REFERENCES endereco (id)
);

/** SINTAXE BÁSICA
CREATE PROCEDURE nome_procedure([parâmetros])
BEGIN
	DECLARE ação (CONTINUE/EXIT) HANDLER FOR condição_de_erro declaração;
	→ ação - se a procedure continua ou não após o erro 
	→ condição_de_erro - o erro que será tratado
    → declaração - os comandos que devem ser executados após o erro. Pode ser um bloco de comandos   
END
**/

/**  PROCEDURE PARA REGISTRAR ENDEREÇO COM TRATAMENTO DE ERRO GERAL (SQLEXCEPTION)**/
DROP PROCEDURE IF EXISTS inserir_endereco; /** elimina a procedure*/
DELIMITER //
CREATE PROCEDURE inserir_endereco(IN rua VARCHAR(255), IN numero INT)
BEGIN
	DECLARE exit HANDLER FOR SQLEXCEPTION SELECT 'NÃO FOI POSSÍVEL REALIZAR O CADASTRO!' AS MESSAGE;
	INSERT INTO endereco (rua, numero) VALUES (rua, numero);
END
//

/**  PROCEDURE PARA REGISTRAR ENDEREÇO COM TRATAMENTO DE ESPECÍFICO (DUPLICIDADE)**/
DROP PROCEDURE IF EXISTS inserir_endereco; /** elimina a procedure*/
DELIMITER //
CREATE PROCEDURE inserir_endereco(IN rua VARCHAR(255), IN numero INT)
BEGIN
	DECLARE exit HANDLER FOR 1062 SELECT 'NÃO FOI POSSÍVEL REALIZAR O CADASTRO!' AS MESSAGE;
	INSERT INTO endereco (rua, numero) VALUES (rua, numero);
END
//

/**  PROCEDURE PARA REGISTRAR ENDEREÇO COM TRATAMENTO DE ESPECÍFICO (NOT NULL)**/
DROP PROCEDURE IF EXISTS inserir_endereco; /** elimina a procedure*/
DELIMITER //
CREATE PROCEDURE inserir_endereco(IN rua VARCHAR(255), IN numero INT)
BEGIN
	DECLARE exit HANDLER FOR 1048 SELECT 'NÃO FOI POSSÍVEL REALIZAR O CADASTRO!' AS MESSAGE;
	INSERT INTO endereco (rua, numero) VALUES (rua, numero);
END
//

/**  PROCEDURE PARA REGISTRAR ENDEREÇO COM TRATAMENTO DE ERRO DAS DUAS **/
DROP PROCEDURE IF EXISTS inserir_endereco;
DELIMITER //
CREATE PROCEDURE inserir_endereco(IN rua VARCHAR(255), IN numero INT)
BEGIN
	DECLARE exit HANDLER FOR 1062 SELECT 'ERRO DE DUPLICIDADE' AS MESSAGE;
	DECLARE exit HANDLER FOR 1048 SELECT 'ERRO DE CAMPO OBRIGATÓRIO' AS MESSAGE;
	INSERT INTO endereco (rua, numero) VALUES (rua, numero);
END
//
DELIMITER ;

CALL inserir_endereco('BAHIA',568);

CALL inserir_endereco('SÃO PAULO',155);

CALL inserir_endereco(NULL,155);

SELECT * FROM endereco;

INSERT INTO endereco (rua, numero) VALUES ('BAHIA',568);
INSERT INTO endereco (rua, numero) VALUES (NULL,568);


/**  
PROCEDURE QUE ATENDA UMA REGRA DE NEGÓCIO
O ENDEREÇO SÓ PODE SER CADASTRADO SE TIVER UM CLIENTE

INSERT INTO endereco (rua, numero) VALUES ('SÃO PEDRO',455);
INSERT INTO cliente (nome) VALUES ('PAULA', 1);
**/
DROP PROCEDURE IF EXISTS inserir_cliente;
DELIMITER //
CREATE PROCEDURE inserir_cliente(IN nome_cliente VARCHAR(255), IN nome_rua VARCHAR(255), IN numero_rua INT)
BEGIN
	DECLARE codigo_endereco INT;
    START TRANSACTION;
	INSERT INTO endereco (rua, numero) VALUES (nome_rua,numero_rua);
    SET codigo_endereco = LAST_INSERT_ID();
    INSERT INTO cliente (nome, endereco_id) VALUES (nome_cliente, codigo_endereco);
    COMMIT;
END;
//
DELIMITER ;

CALL inserir_cliente('MARIA','DR. FRANCISCO',78);

SELECT * FROM endereco;
SELECT * FROM cliente;













