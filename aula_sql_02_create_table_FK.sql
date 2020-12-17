/**
Aula create tabel com FOREIGN KEY
Link da aula: https://www.youtube.com/watch?v=ytYPwaU-vRM
**/

DROP DATABASE IF EXISTS aula_banco; -- eliminado aula_banco
CREATE DATABASE aula_banco; 		-- criando aula_banco
USE aula_banco; 					-- selecionando aula_banco 

-- criando tabela estado
CREATE TABLE estado(
id INT NOT NULL AUTO_INCREMENT
,nome VARCHAR(200) NOT NULL UNIQUE  
,sigla CHAR(2) NOT NULL UNIQUE
,ativo CHAR(1) NOT NULL DEFAULT 'S'
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,CONSTRAINT pk_estado PRIMARY KEY (id)  -- deinimos um nome para a constraint PK
,CONSTRAINT estado_ativo_deve_ser_S_ou_N CHECK (ativo IN ('S', 'N') )  -- deinimos um nome para a constraint CHECK (ativo IN ('S', 'N') )
);

-- inserindo registros do estado
INSERT INTO estado (nome,sigla) VALUES ('PARANÁ','PR');
INSERT INTO estado (nome,sigla) VALUES ('SÃO PAULO','SP');

-- consultando a tabela estado
SELECT * FROM estado;
/**
O que é PK? 
Primary Key, em português, Chave Primária
Seria o identificador do registro 
Quando realizamos a inscrição de um evento ou show, no ato da inscrição é definido o CÓDIGO IDENTIFICADOR da inscrição para te identificar
Quando matriculamos em um curso, no ato da matrícula, é definido o  CÓDIGO IDENTIFICADOR da matrícula para te identificar 
Mesmo que você tenha nome ou um documento identificador como o CPF, ainda assim, é definido um  CÓDIGO IDENTIFICADOR para facilicar o processo 
Porque não se utiliza o nome? → Porquê pode ter 2 nomes iguais.
Porque não se utiliza o CPF? → Porquê não temos controle nele, é um documento gerenciado pela Secretaria da Receita Federal do Brasil.
A PK seria justamente o  CÓDIGO IDENTIFICADOR para identificar o registro.
Em um banco de dados relacional, toda tabela tem que ter a PK, o CÓDIGO IDENTIFICADOR do registro.
Como é o identificado, ela é NOT NULL e UNIQUE.

O que é FK? 
Foreign Key, em português, Chave Estrangeira
Para evitar a repetição de dados, realizamos a normalização do BD, defindo especificamente o que cada tabela irá armazenar.
Porém, com a separação, quebra-se o víncule de algumas informações. Por exemplo: Cidade e Estado.
A serpação evita a repetição de ddos do Estado na Cidade, porém, a Cidade fica sem referência de qual Estado ela pertence.
A FK seria uma coluna de "vinculação", indicando a referência de um registro de outra tabela.
No exemplo da Cidade e Estado, a tabela Cidade teria a FK, a coluna de referência da tabela Estado, de modo que possa-se saber de qual Estado a Cidade pertence.
Um FK pode ser definida como NULL ou NOT NULL e sempre referencia uma PK. 

COMO DEFINIR PK
>>>>>>>>>>DEFININDO PK sem definir o nome da regra
id INT PRIMARY KEY

>>>>>>>>>>DEFININDO PK e definindo o nome da regra
CONSTRAINT nome_regra PRIMARY KEY (coluna_pk) 



COMO DEFINIR FK
>>>>>>>>>>DEFININDO FK sem definir o nome da regra
FOREIGN KEY (estado_id) REFERENCES estado (id) 

>>>>>>>>>>DEFININDO FK e definindo o nome da regra
CONSTRAINT nome_regra FOREIGN KEY (coluna_fk) REFERENCES tabela_referencia (pk_tabela_referencia)
**/

/**
-- sintaxe para criar tabela com FK sem definir o nome da regra
CREATE TABLE cidade (
id INT NOT NULL AUTO_INCREMENT
,nome VARCHAR(200)  NOT NULL
,ativo CHAR(1) NOT NULL DEFAULT 'S' 
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,estado_id INT NOT NULL 
,CONSTRAINT pk_cidade PRIMARY KEY (id)
,FOREIGN KEY (estado_id) REFERENCES estado (id) -- >>>>>>>>>>DEFININDO FK sem definir o nome da regra
,CONSTRAINT cidade_ativo_deve_ser_S_ou_N CHECK (ativo IN ('S','N'))
,CONSTRAINT cidade_unica UNIQUE(nome, estado_id)
);
**/

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



-- criando um registro estado
INSERT INTO cidade (nome,estado_id) VALUES ('CURITIBA', 1);

-- consulta tabela cidade
SELECT * FROM CIDADE;

/**
Entendendo estes comandos já é possível fazer o script inteiro do nosso estudo de caso!
Se puderam, façam! A prática é a alma da aprendizagem.
                                                
Até a próxima aula!!!
**/




