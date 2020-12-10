CREATE DATABASE IF NOT EXISTS AULA_BANCO;
USE AULA_BANCO;

/**   
>>>>>>>>>>>>>>>>>>> SINTAXE WHILE <<<<<<<<<<<<<<<<<<<<<<<  
criando função com a estrutura de repetição WHILE

WHILE condição_lógica DO
	nosso código...
END WHILE;
*/
DELIMITER //
CREATE FUNCTION somarAte(limite INT)
RETURNS INT DETERMINISTIC
BEGIN
	DECLARE contador INT DEFAULT 0;
	WHILE contador < limite DO
		SET contador = contador + 1;
	END WHILE;
	RETURN contador;
END
//
DELIMITER ;

/** testando **/
SELECT somarAte(30); 

/**   
>>>>>>>>>>>>>>>>>>> SINTAXE LOOP <<<<<<<<<<<<<<<<<<<<<<<  
nome_loop : LOOP
	nosso código...
	IF condição_lógica THEN
		LEAVE nome_loop;
	END IF;
END LOOP nome_loop;
*/
DROP FUNCTION somarAte; /**elimiando função*/
 /** criando a função com LOOP */
DELIMITER //
CREATE FUNCTION somarAte(limite INT)
RETURNS INT DETERMINISTIC
BEGIN
	DECLARE contador INT DEFAULT 0;
	meu_loop : LOOP
		SET contador = contador +1;
		IF contador >= limite THEN
			LEAVE meu_loop;
		END IF;
	END LOOP meu_loop;
	RETURN contador;
END
//
DELIMITER ;

/**   
>>>>>>>>>>>>>>>>>>> SINTAXE REPEAT <<<<<<<<<<<<<<<<<<<<<<<  
REPEAT
	nosso código...
	UNTIL condição_lógica
END REPEAT;
*/
DROP FUNCTION somarAte; /**elimiando função*/

 /** criando a função com REPEAT */
DELIMITER //
CREATE FUNCTION somarAte(limite INT)
RETURNS INT DETERMINISTIC
BEGIN
	DECLARE contador INT DEFAULT 0;
	REPEAT
		SET contador = contador +1;
		UNTIL contador >= limite
	END REPEAT;
	RETURN contador;
END
//
DELIMITER ;

SELECT somarAte(30);

 /** FATORIAL 
Operação comum na análise combinatória, facilitando o cálculo envolvendo contagem. 
Representado pelo símbolo "!" ( n! ) → multiplicação de n por todos os seus antecessores até chegar em 1. 
3! = 3 x 2 x 1.
obs: fatorial de 0 é 1
 */
 
/** versão 1 **/
DELIMITER //
CREATE FUNCTION calcular_fatorial(numero INT)
RETURNS INT DETERMINISTIC
BEGIN
	DECLARE fatorial INT default numero;
	WHILE numero > 1 DO
		SET numero = numero - 1 ;
		SET fatorial = fatorial * numero ;
	END WHILE;
	RETURN fatorial;
END
//
DELIMITER ;

SELECT calcular_fatorial(3); /** testando com 3 - deu certo!! */
SELECT calcular_fatorial(0); /** testando com 0 - deu errado!! */


/** versão 2 - corrigindo o bug do 0 **/
DROP FUNCTION calcular_fatorial;

DELIMITER //
CREATE FUNCTION calcular_fatorial(numero INT)
RETURNS INT DETERMINISTIC
BEGIN
	DECLARE fatorial INT default numero;
	IF numero <= 0 THEN
		RETURN 1;
	END IF;
	WHILE numero > 1 DO
		SET numero = numero - 1 ;
		SET fatorial = fatorial * numero ;
	END WHILE;
	RETURN fatorial;
END
//
DELIMITER ;