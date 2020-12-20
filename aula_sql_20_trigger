DROP DATABASE IF EXISTS aula_banco; /** eliminando a base de dados */
CREATE DATABASE aula_banco;			/** criando a base de dados */
USE aula_banco;						/** selecionando a base de dados*/

/** criando tabelas */
CREATE TABLE cliente(
id INT NOT NULL AUTO_INCREMENT
,nome VARCHAR(255) NOT NULL  
,cpf CHAR(14) NOT NULL UNIQUE 
,ativo CHAR(1) NOT NULL DEFAULT 'A'
,CONSTRAINT pk_cliente PRIMARY KEY (id)
);

CREATE TABLE conta_receber(
id INT NOT NULL AUTO_INCREMENT
,valor DECIMAL(10,2) NOT NULL
,cliente_id INT NOT NULL 
,CONSTRAINT pk_conta_receber PRIMARY KEY (id)
);

/**  inserindo registros */
INSERT INTO cliente (nome,cpf) VALUES ('RAUL','111.111.111-11');
INSERT INTO cliente (nome,cpf) VALUES ('MARTA','222.222.222-22');
INSERT INTO cliente (nome,cpf) VALUES ('ANA','333.333.333-33');
INSERT INTO cliente (nome,cpf) VALUES ('JOCA','444.444.444-44');
INSERT INTO cliente (nome,cpf) VALUES ('PEDRO','555.555.555-55');
INSERT INTO cliente (nome,cpf) VALUES ('ANTÔNIO','666.666.666-66');
INSERT INTO cliente (nome,cpf) VALUES ('CACA','777.777.777-77');

INSERT INTO conta_receber (valor, cliente_id) VALUES (100, 1);
INSERT INTO conta_receber (valor, cliente_id) VALUES (150, 2);
INSERT INTO conta_receber (valor, cliente_id) VALUES (50, 3);
INSERT INTO conta_receber (valor, cliente_id) VALUES (200, 4);
/**  
da forma como está, qualquer usuário pode inativar ou excluir o cliente, 
mesmo que a empresa tenha conta à receber do cliente. 
→ então vamos criar uma trigger que impeça inativar/excluir um cliente em que tenham dívidas
**/
SELECT * FROM cliente;
SELECT * FROM conta_receber;
UPDATE cliente SET ativo = 'N' WHERE CPF = '111.111.111-11';
/**
VALOR ANTIGO → S   OLD.ativo
VALOR NOVO → N     NEW.ativo

UPDATE cliente SET nome = 'RAUL SILVA' WHERE ID = 1; 
OLD.nome (RAUL) NEW.nome (RAUL SILVA) 

UPDATE cliente SET nome = 'MARTA FERNANDA' WHERE ID = 1; 
OLD.nome (MARTA) NEW.nome (MARTA FERNANDA) 

INSERT INTO cliente (nome,cpf) VALUES ('JOCA','888.888.888-88');
OLD.nome ???  NEW.nome ??

DELETE FROM cliente WHERE id = 1;
OLD.nome ???  NEW.nome ??
*/
DROP TRIGGER validar_alteracao_cliente_inativo;
DELIMITER //
CREATE TRIGGER validar_alteracao_cliente_inativo 
BEFORE UPDATE ON cliente 
FOR EACH ROW 
BEGIN
	IF NEW.ativo <> OLD.ativo AND
		EXISTS(SELECT * FROM conta_receber WHERE CLIENTE_ID = NEW.id)
    THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'BLOQUEADO';
	END IF;
END
//
DELIMITER ;

/**CONSULTA PARA DESCOBRIR SE O CLIENTE TEM DÍVIDA
SELECT * FROM conta_receber WHERE CLIENTE_ID = ???;
**/

UPDATE cliente SET ativo = 'N' WHERE id = 2;


DROP TRIGGER validar_exclusao_cliente_inativo;
DELIMITER //
CREATE TRIGGER validar_exclusao_cliente_inativo 
BEFORE DELETE ON cliente 
FOR EACH ROW 
BEGIN
	IF EXISTS(SELECT * FROM conta_receber WHERE CLIENTE_ID = OLD.id) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EXCLUSÃO INVÁLIDA - CLIENTE POSSUI DÍVIDA.';
	END IF;
END
//
DELIMITER ;

SELECT * FROM cliente;
SELECT * FROM conta_receber;

 /** TESTE - ALTERANDO CLIENTE SEM DÍVIDAS - A ALTERAÇÃO É REALIZADA - NOSSA TRIGGER DEU CERTO*/
UPDATE cliente SET ativo = 'n' WHERE id =6;
/** TESTE - ALTERANDO CLIENTE COM DÍVIDAS - A ALTERAÇÃO NÃO É REALIZADA - NOSSA TRIGGER DEU CERTO*/
UPDATE cliente SET nome = 'MARTA SILVA' WHERE id = 2;
 /** TESTE - EXCLUIND CLIENTE COM DÍVIDAS - A EXCLUSÃO NÃO É REALIZADA - NOSSA TRIGGER ESTÁ FUNCIONANDO*/
DELETE FROM cliente WHERE id = 4;
 /** TESTE - EXCLUIND CLIENTE SEM DÍVIDAS - A EXCLUSÃO É REALIZADA - NOSSA TRIGGER ESTÁ FUNCIONANDO*/
DELETE FROM cliente WHERE id = 7;































