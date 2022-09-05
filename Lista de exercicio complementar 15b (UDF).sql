/*
Link do script para criação das tabelas: https://raw.githubusercontent.com/heliokamakawa/curso_bd/master/00-estudo%20de%20caso%20%20loja%20-script.sql
Link imagem do DER: https://github.com/heliokamakawa/curso_bd/blob/master/00-estudo%20de%20caso%20loja%20-%20DER.png
Link aula funções: https://www.youtube.com/watch?v=t9y6aSbo0pE&list=PLg5-aZqPjMmAWcUgpc7qP0Vk8N7aMrbY9&index=16
Lista de Exercícios de Funções – Básica para treinar sintaxe
1.	Escreva uma função que:
    1.1.Retorne o seu nome. Faça a chamada da função.
    1.2.Retorne o seu nome utilizando uma variável. Faça a chamada da função.
2.	Escreva uma função que receba o ano de nascimento e retorne a idade. Faça a chamada da função.
3.	Escreva uma função que receba o ano de nascimento e retorne se a pessoa é ou não maior que 18 anos. Faça a chamada da função.
4.	Escreva uma função que receba a altura e o peso, calcule o IMC e retorne se está acima do peso. Faça a chamada da função.
5.	Escreva uma função que receba como parâmetro, o código de cliente, busque o ano de nascimento e retorne se o ciente é ou não maior que 18 anos. Faça a chamada da função.
6.	Escreva uma função que receba como parâmetro, o código do funcionário, busque a altura e o peso, calcule o IMC e retorne se o funcionário está acima do peso. Faça a chamada da função.

Link videoaula estrutura de repetição: https://www.youtube.com/watch?v=GiXTRQXuqT0&list=PLg5-aZqPjMmAWcUgpc7qP0Vk8N7aMrbY9&index=17
7.	Replique todas as estruturas de repetição apresentadas na aula.
8.	Refaça o exercício anterior (com todas as estruturas de repetição) utilizando somente números pares e positivos.
9.	Refaça o exercício 7 (com todas as estruturas de repetição) de forma que, a função receba como parâmetro o número inicial e o limite dos números a percorrer pela estrutura de repetição. 

Link cursor: 
https://pt.wikipedia.org/wiki/Cursor_(banco_de_dados)
https://docs.microsoft.com/pt-br/sql/ado/guide/data/what-is-a-cursor?view=sql-server-ver16
https://www.devmedia.com.br/cursores-no-sqlserver/5590
Link cursor: https://github.com/heliokamakawa/curso_bd/blob/master/15d-funcoes%20uteis.sql
Link cursor: https://dev.mysql.com/doc/refman/8.0/en/cursors.html
10.	O que é um cursor? Para que serve? Como funciona? Em que cenário são úteis? São semelhantes a qual recurso em linguagens de programação?

Link aula revisão cursor: https://drive.google.com/file/d/19obsduXrcv-UbOsZFozoRVkZoJXjaIck/view
11.	Escreva a estrutura básica de uma função utilizando um cursor (pode ser o exemplo do slide – só não copie e cole, senão não irá praticar). Após a escrita:
    11.1.Enumere a sequência correta para a definição e o uso de um cursor na função. 
    11.2.Comente cada sequência, descrevendo “o papel” de cada comando.
12.	Após a prática do exercício anterior responda:
    12.1.Para usar o cursor precisamos utilizar uma estrutura de repetição? Justifique.
    12.2.Na declaração, é necessário que vinculemos o cursor a qual recurso? Explique.
    12.3.Para percorrer um cursor utilizamos ponteiros. Qual comando move o ponteiro para o próximo registro? O que ocorre quando os registros acabam? O que é necessário para que a estrutura de repetição não entre em loop?
13.	Faça as funções abaixo: (O objetivo é entender gradativamente o cursor)
    13.1.Escreva a estrutura básica de uma função com a declaração de 3 variáveis (resultado, acabou, qtde_cliente); Teste a função.
    13.2.Reescreva a função anterior declarando um cursor de consulta de todos os clientes ativos; 
    13.3.Reescreva a função anterior abrindo e fechando o cursor;
    13.4.Reescreva a função anterior implementando a estrutura de repetição que percorra o loop;
    13.5.Reescreva a função anterior, de modo que, colete e retorne a quantidade de clientes do loop;
    13.6.Reescreva a função anterior, de modo que, colete e retorne a quantidade de clientes (pessoa física) do loop; 
    13.7.Reescreva a função anterior, de modo que, calcule e retorne a média de idade dos clientes (pessoa física);
14.	Tente implementar um cursor com base no estudo de caso.
*/