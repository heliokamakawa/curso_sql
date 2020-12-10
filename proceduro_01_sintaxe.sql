DROP DATABASE IF EXISTS aula_banco;	/** Caso exista - elimine a base de dados aula_banco */
CREATE DATABASE aula_banco;			/** criando o banco aula_banco */
USE aula_banco;						/** selecionando o banco criado */

/**
CREATE PROCEDURE nome_procedure([parâmetros])
BEGIN
	nosso código...
END
**/

/**
primerio exemplo: Procedure que verifica se o número é par ou ímpar.
**/
DELIMITER //
CREATE PROCEDURE verificar_par_impar(numero INT)
BEGIN 
	DECLARE resultado VARCHAR(100);
    IF MOD(numero, 2) = 0 THEN 
		SET resultado = 'PAR';
	ELSE 
		SET resultado = 'ÍMPAR';
    END IF;
END
//
DELIMITER ;

CALL verificar_par_impar(10);


/** 
>>>>>>>>>>>>>>>>>>>>>> CRIANDO A PROCEDURE COM VARIÁVEL DO USUÁRIO <<<<<<<<<<<<<<<<<<<<<<<<
**/
SET @minha_variavel = 50;
SELECT @minha_variavel;

DROP PROCEDURE verificar_par_impar;
DELIMITER //
CREATE PROCEDURE verificar_par_impar(numero INT)
BEGIN 
    IF MOD(numero, 2) = 0 THEN 
		SET @resultado = 'PAR';
	ELSE 
		SET @resultado = 'ÍMPAR';
    END IF;
END
//
DELIMITER ;

CALL verificar_par_impar(15);
SELECT @resultado;

/** 
>>>>>>>>>>>>>>>>>>>>>> CRIANDO A PROCEDURE COM VARIÁVEL DE SAÍDA <<<<<<<<<<<<<<<<<<<<<<<<
**/

DROP PROCEDURE verificar_par_impar;
DELIMITER //
CREATE PROCEDURE verificar_par_impar(IN numero INT, OUT resultado VARCHAR(100))
BEGIN 
    IF MOD(numero, 2) = 0 THEN 
		SET resultado = 'PAR';
	ELSE 
		SET resultado = 'ÍMPAR';
    END IF;
END
//
DELIMITER ;



CALL verificar_par_impar(16, @meu_resultado);
SELECT @mu_resultado;

SET @nome_completo = CONCAT('Pedro ', 'Silva');
SELECT @nome_completo;

/**SET @par = verificar_par_impar(8, @meu_resultado);




