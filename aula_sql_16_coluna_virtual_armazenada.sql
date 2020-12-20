/*
Aula 16 - Coluna gerada - virtual/armazenada
Link videoaula → https://www.youtube.com/watch?v=1CGgmZ_OuIs
*/

DROP DATABASE IF EXISTS aula_banco; -- se existir elimine aula_banco
CREATE DATABASE aula_banco; 		-- criar aula_banco
USE aula_banco;						-- selecionar aula_banco

-- criando tabela produto
CREATE TABLE produto(
id INT NOT NULL auto_increment
,nome VARCHAR(100) NOT NULL 
,descricao VARCHAR(1000) NOT NULL 
,preco_compra DECIMAL(10,2) NOT NULL
,CONSTRAINT pk_produto PRIMARY KEY (id)
);
-- realizando inserções 
INSERT INTO produto (nome,descricao,preco_compra) VALUES ('SUCO DE UVA', 'PRODUTO INTEGRAL', 7.80);
INSERT INTO produto (nome,descricao,preco_compra) VALUES ('SUCO DE LARANJA', 'PRODUTO PASTEURIZADO', 9.80);
INSERT INTO produto (nome,descricao,preco_compra) VALUES ('SUCO DE LIMÃO', 'PRODUTO NATUAL CONCENTRADO', 7.80);
INSERT INTO produto (nome,descricao,preco_compra) VALUES ('SUCO DE MANGA', 'PRODUTO ORGÂNICO', 7.80);

-- imagine que a empresa SEMPRE precise do nome completo do produto (nome e descricao)
SELECT CONCAT(nome, ' - ', descricao) FROM produto;

-- se sempre precisa do nome completo, que tal criar a coluna nome completo?
DROP TABLE produto; -- eliminando a tabela 

-- cirando tabela produto com nome completo
CREATE TABLE produto(
id INT NOT NULL auto_increment
,nome VARCHAR(100) NOT NULL 
,descricao VARCHAR(1000) NOT NULL 
,nome_completo VARCHAR(1100) NOT NULL 
,preco_compra DECIMAL(10,2) NOT NULL
,CONSTRAINT pk_produto PRIMARY KEY (id)
);

-- realizando inserções 
INSERT INTO produto (nome,descricao,nome_completo,preco_compra) VALUES ('SUCO DE UVA', 'PRODUTO INTEGRAL', 'SUCO DE UVA - PODUTO INTEGRAL', 7.80); -- reparem que tem erro de digitação PODUTO, ao invés de PRODUTO
INSERT INTO produto (nome,descricao,nome_completo,preco_compra) VALUES ('SUCO DE LARANJA', 'PRODUTO PASTEURIZADO', 'SUCO DE LARANJA - PRODUTO PASTEURIZADO', 9.80);
INSERT INTO produto (nome,descricao,nome_completo,preco_compra) VALUES ('SUCO DE LIMÃO', 'PRODUTO NATUAL CONCENTRADO','SUCO DE LIMÃO - PRODUTO NATUAL CONCENTRADO', 7.80);
INSERT INTO produto (nome,descricao,nome_completo,preco_compra) VALUES ('SUCO DE MANGA', 'PRODUTO ORGÂNICO','SUCO DE MANGA - PRODUTO ORGÂNICO', 7.80);

-- consulta 
SELECT * FROM produto; -- agora ficou mais fácil para consultar, temos o nome_completo

/*
apesar de ficar mais fácil para consultar, agora temos a repetição de dados...
Qual proble de repetir dados? → com a repetição, abre-se uma brecha de erros de digitação (repearem o primeiro registro) e esquecimento (olhem o próximo comando)
*/

UPDATE produto SET nome='SUCO DE MARACUJÁ' WHERE id = 2; -- usuário altera o nome do suco, porém o esquece de alterar o nome completo. Assim, o nome e nome_completo ficam errados


SELECT nome,nome_completo FROM produto;
/*
Na consulta reparem dois erros:
	(1) - 1º registro tem um erro de digitação 
    (2) - 2º registro tem 2 nomes... SUCO DE MARCUJÁ em nome e SUCO DE LARANJA em nome completo
    
Quando criamos uma coluna que depende/resultad de outras colunas, desnormalizamos a tabela (especificamente a 3º Forma Normal) 
→ Vanteagem de desnormalizar - temos um resultado pronto. Assim, podemos fazer uma consulta simples. O desempenho na consulta é melhor, visto que, não precisa calcular o resultado.
→ Desvantagem de desnormalizar - começa a repetir dados. Abre brecha para erros de digitação, ortográfico e esquecimentos. Pode gerar dados inconsistentes. 

Então qual escolher? → AS DUAS!!! Utilizando a coluna gerada virtual ou armazenada

Uma coluna em que delegamos para o SGBD "cuidar"... gerando o resultado e recalculando quando há alterações.
*/

DROP TABLE produto; -- eliminando a tabela 

-- crinado tabela com coluna virtual para nome_completo
CREATE TABLE produto(
id INT NOT NULL auto_increment
,nome VARCHAR(100) NOT NULL 
,descricao VARCHAR(1000) NOT NULL 
,nome_completo VARCHAR(1100) AS (CONCAT(nome,' - ',descricao)) -- coluna gerada virtual
,preco_compra DECIMAL(10,2) NOT NULL
,CONSTRAINT pk_produto PRIMARY KEY (id)
);

-- realizando inserções >>>>AGORA NÃO PRECISAMOS INFORMAR NOME COMPLETO - é por isso que dá certo, o usuário não REPETE dados!
INSERT INTO produto (nome,descricao,preco_compra) VALUES ('SUCO DE UVA', 'PRODUTO INTEGRAL', 7.80);
INSERT INTO produto (nome,descricao,preco_compra) VALUES ('SUCO DE LARANJA', 'PRODUTO PASTEURIZADO', 9.80);
INSERT INTO produto (nome,descricao,preco_compra) VALUES ('SUCO DE LIMÃO', 'PRODUTO NATUAL CONCENTRADO',7.80);
INSERT INTO produto (nome,descricao,preco_compra) VALUES ('SUCO DE MANGA', 'PRODUTO ORGÂNICO',7.80);

-- consulta 
SELECT * FROM produto; -- agora ficou mais fácil para consultar, temos o nome_completo e o usuário não repete dados... o SGDB calcula o resultado neste momento para apresentá-lo!!

UPDATE produto SET nome='SUCO DE MARACUJÁ' WHERE id = 2; -- não tem problema de esquecimento, se o usuário altera o nome, na consulta, o SGBD calcula o nome completo para apresentar

SELECT nome,nome_completo FROM produto; -- resultado fica certinho!!! 

/*
A coluna virtual não ocupa espeço de armazenamento permanente... 
A cada consulta o SGBD, calcula o resultado e o apresenta. 

Isso pode afetar o desempenho? → SIM!!!! Pode influenciar no desempenho de comandos de consulta conforme o cálculo, a complexidade da consulta e o volume de registros.

Tem outra forma de fazer? → SIM!!!! Coluna gerada armazenada.
Basta colocar STORED no final da definição da coluna gerada
A coluna gerada armazenada ocupa espaço de armazenamento permanente. Na inserção de dados, o SGBD calcula o resultado e realiza o armazenamento do resultado. 
Quando há alteração, o SGBD recalcula e armazena novamente. 
Como o resultado está armazenado, o SGBD não precisa fazer cálculo para mostrar a coluna.

Poderíamos tornar a coluna nome_completo uma coluna armazenada, mas vamos criar uma outra coluna... preço de venda mínima.. assim vocês terão as duas sintaxes para estudar
preço de venda mínima será 20% acima do preço de compra. Como calculamos? → basta pegar o preço de compra e multiplicar por 1.2
*/

DROP TABLE produto; -- eliminando a tabela 

-- crinado tabela com coluna gerada armazenada para preco_venda_minima
CREATE TABLE produto(
id INT NOT NULL auto_increment
,nome VARCHAR(100) NOT NULL 
,descricao VARCHAR(1000) NOT NULL 
,nome_completo VARCHAR(1100) AS (CONCAT(nome,' - ',descricao)) -- coluna gerada virtual
,preco_compra DECIMAL(10,2) NOT NULL
,preco_venda_minimo DECIMAL(10,2) AS (preco_compra * 1.2) STORED
,CONSTRAINT pk_produto PRIMARY KEY (id)
);

-- realizando inserções >>>>NÃO PRECISAMOS INFORMAR NOME COMPLETO E ENM PREÇO DE VENDA MÍNIMO - é por isso que dá certo, o usuário não REPETE dados!
INSERT INTO produto (nome,descricao,preco_compra) VALUES ('SUCO DE UVA', 'PRODUTO INTEGRAL', 7.80);
INSERT INTO produto (nome,descricao,preco_compra) VALUES ('SUCO DE LARANJA', 'PRODUTO PASTEURIZADO', 9.80);
INSERT INTO produto (nome,descricao,preco_compra) VALUES ('SUCO DE LIMÃO', 'PRODUTO NATUAL CONCENTRADO',7.80);
INSERT INTO produto (nome,descricao,preco_compra) VALUES ('SUCO DE MANGA', 'PRODUTO ORGÂNICO',7.80);

-- consulta 
SELECT * FROM produto; -- agora ficou mais fácil para consultar, temos o nome_completo e preço de venda mínima e o usuário não repete dados... 

UPDATE produto SET preco_compra=10 WHERE id = 1; -- se o usuário altera o preço de custo, o SGBD automaticamente calcula e altera o preco_venda_minimo. MARAVILHA!!!

SELECT nome,nome_completo FROM produto; -- resultado fica certinho!!! 

/*
Coluna gerada virtual ou armazenada? Qual é o melhor?
Vai depender do contexto
→ coluna gerada virtual gera processamento em comandos de consulta, assim é melhor no contexto que a tabela tenha muiiiiiiiiiiiiiiitas inserções (mas difícil de acontecer)
→ coluna gerada armazenada gera processamento em comandos de inserção, assim é melhor no contexto que a tabela tenha mais consultas (mas fácil de acontecer)

Por hoje é só pessoal!!! Até a próxima aula!!!

*/
