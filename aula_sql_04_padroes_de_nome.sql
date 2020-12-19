/*
Padrões de nomenclatura
Adotar padrões conforme o projeto. Hoje em dia, devemos ser um profissional versátil.
	(1) se estamos na empresa, respeitar os padrões/regras da empresa;
	(2) se estamos fazem um "bico" de algum projeto, respeitar os padrões/regras do projeto;
	(3) se estamos na institução/faculdade/universidade, respeitar os padrões/regras do professor;
	(4) se está fazendo TCC, respeitar os padrões/regras do orientador;
	(5) se é um projeto seu, adote/defina um padrão;
obs: 
→ Importante é estar disposto e sujeito a respeitar os padrões do ambiente;
→ Podemos questionar para entender e sugerir alterações do padrão, mas até confirmar a mudança respeite o padrão;
→ Hoje é muito comum ver os códigos do git na estrevista técnica de emprego
    - Código indentado e PADRONIZADO tem outro valor!!! Demostra organização, dedicação e estudo.
    - Saber explicar o motivo de adotar ou deixar de adotar um padrão é melhor ainda.
→ Não existe uma solução mágica para tudo!!!

Minhas sugestões: respeitar padrões/regras do ambiente... caso não exista:
	(1) comandos em letras maiúsculas
	(2) nome de elementos que definimos em letras minúsculas
	(3) nome composto → tudo em minúscula separados por "_"
	(4) nome colunas sem o nome de tabela
	(5) definir constraints nomeadas de PK, FK e regras específicas do projeto 
	(6) valores de inserções em letras maiúsculas
    (7) não colocar o nome da tabela em atributos... (específica minha)
*/

DROP DATABASE IF EXISTS aula_banco; -- eliminado aula_banco 
CREATE DATABASE aula_banco; 		-- criando aula_banco
USE aula_banco; 					-- selecionando aula_banco 

SELECT @@version, @@version_compile_os, @@lower_case_table_names; 
/**
@@version → versão do banco de dados
@@version_compile_os → versão do sistema operacional
@@lower_case_table_names → configuração para definição do nome de tabela com letras minúsculas

no windows → lower_case_table_names é 1 (verdadeiro)
no linux → lower_case_table_names é 0 (falso)
**/

/*
com lower_case_table_names 1, independente de você colocar maiúscula ou minúscula, será criado a tabela com o nome com letras minúsculas
com lower_case_table_names 0, será criado a tabela conforme definido no script
*/

CREATE TABLE EsTaDo( -- criando a tabela sem padronizar 
/*
no windows esta tabela ficará "estado"
no linux esta tabela ficará "EsTaDo"
*/
id INT NOT NULL AUTO_INCREMENT
,nome VARCHAR(200) NOT NULL UNIQUE  
,sigla CHAR(2) NOT NULL UNIQUE
,ativo ENUM('S','N') NOT NULL DEFAULT 'S'
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,CONSTRAINT pk_estado PRIMARY KEY (id)  
);
  
INSERT INTO estado (nome,sigla) VALUES ('SÃO PAULO','SP'); -- windows → funciona   linux → dá erro

SELECT * FROM estado; -- windows → funciona   linux → dá erro
SELECT * FROM ESTADO; -- windows → funciona   linux → dá erro
SELECT * FROM Estado; -- windows → funciona   linux → dá erro
SELECT * FROM EsTaDo; -- windows → funciona   linux → funciona

DROP TABLE EsTaDo; -- eliminando a tabela para criar com padrão

CREATE TABLE estado( -- criando a tabela sem padronizar 
/*
no windows esta tabela ficará "estado"
no linux esta tabela ficará "estado"
*/
id INT NOT NULL AUTO_INCREMENT
,nome VARCHAR(200) NOT NULL UNIQUE  
,sigla CHAR(2) NOT NULL UNIQUE
,ativo ENUM('S','N') NOT NULL DEFAULT 'S'
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,CONSTRAINT pk_estado PRIMARY KEY (id)  
);

-- adotando o padrão de usar minúscula irá funcionar independente do SO ou configuração
INSERT INTO estado (nome,sigla) VALUES ('SÃO PAULO','SP'); -- windows → funciona   linux → funciona
SELECT * FROM estado; -- windows → funciona   linux → funciona


/**
Em nomes compostos é importante adotar alguma forma de destacar cada nome 
em programação é comum utilziar o padrão Camel Case 
Exemplo: categoriaProduto 
Só que no banco de dados, com lower_case_table_names 1, independente de utilizar letras maiúculas ou minúsculas 
a tabela será criada com letras minúsculas, ficando "categoriaproduto"

É por isto que adotamos o "-" para separar os nomes → "categoria_produto"
**/
CREATE TABLE categoria_produto( 
id INT AUTO_INCREMENT 
,nome VARCHAR(255) NOT NULL UNIQUE
,descricao VARCHAR(255) NOT NULL 
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,ativo ENUM('S','N') NOT NULL DEFAULT 'S' 
,CONSTRAINT pk_catagoria_produto PRIMARY KEY (id)
);



DROP TABLE estado; -- eliminando a tabela 

-- muitas pessoas gostam de colocar o nome da tabela nas colunas
CREATE TABLE estado( 
id_estado INT NOT NULL AUTO_INCREMENT
,nome_estado VARCHAR(200) NOT NULL UNIQUE  
,sigla_estado CHAR(2) NOT NULL UNIQUE
,ativo_estado ENUM('S','N') NOT NULL DEFAULT 'S'
,data_cadastro_estado DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,CONSTRAINT pk_estado PRIMARY KEY (id)  
);
-- colocando nome da tabela na coluna, quando realizamos uma consulta, a descrição da coluna fica bem clara!!!

SELECT nome_estado FROM estado; -- olhem o nome da coluna.. só de olhar sabemos que é da tabela estado...
-- SELECT nome FROM estado; → esta consulta seria sem colocar o nome da tabela na coluna, desta forma não dá pra saber direito de qual tabela a coluna é
-- porém, pelo menos para mim, é redundante... tudo que está dentro do estado são colunas do estado.. não é preciso colocar para saber disto
-- assim, a minha sugestão é que não coloque

DROP TABLE estado; -- eliminando a tabela 

CREATE TABLE estado( 
id INT NOT NULL AUTO_INCREMENT
,nome VARCHAR(200) NOT NULL UNIQUE  
,sigla CHAR(2) NOT NULL UNIQUE
,ativo ENUM('S','N') NOT NULL DEFAULT 'S'
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,CONSTRAINT pk_estado PRIMARY KEY (id)  
);

-- e pra deixar a coluna clara podemos inserir o nome da tabela na consulta
SELECT estado.nome FROM estado; -- fica claro da mesma forma, sem ser redundante


INSERT INTO estado (nome,sigla) VALUES ('PARANÁ','PR'); -- defina um padrão para os dados na inserção
SELECT * FROM estado WHERE nome = 'PARANÁ'; -- assim na consulta, saberá como escrever o filtro