/*
Link do script para criação das tabelas: https://raw.githubusercontent.com/heliokamakawa/curso_bd/master/00-estudo%20de%20caso%20%20loja%20-script.sql
Link imagem do DER: https://github.com/heliokamakawa/curso_bd/blob/master/00-estudo%20de%20caso%20loja%20-%20DER.png
Lista de Exercícios  I – Colunas Virtuais e Funções Definidas pelo Usuário
1.	Considerando que a coluna STATUS da tabela ESTADO apresenta ‘A’ para estados ativos e ‘I’ para inativos. Crie uma coluna gerada virtual que apresente a informação completa (ATIVO e INATIVO). Após a criação da coluna, escreva a consulta que apresente a coluna virtual.
2.	A coluna DATA_CADASTRO da tabela CIDADE tem a finalidade de armazenar as datas dos registros. Neste contexto, crie uma coluna gerada armazenada que classifique os registros em “novo” (após 2010) e “antigo” (demais registros). Após a criação da coluna, escreva a consulta que apresente a coluna gerada armazenada.
3.	Em relação aos exercícios anteriores, explique a diferença entre as duas elencando as vantagens e desvantagens de cada uma.
4.	Escreva uma função que receba como parâmetro um e-mail, verifique se é válido (possui “@”) e retorne o resultado. Teste a função em uma das tabelas do estudo de caso. 
5.	Escreva uma função que receba como parâmetro o código de um produto, verifique se o preço de venda está pelo menos 30% superior ao preço de compra e retorne o resultado. Em seguida, escreva um único comando que utilize a função criada para verificar os preços de todos os produtos cadastrados.
6.	Considerando em que a coluna TOTAL da tabela COMPRA está desnormalizada, escreva uma única função que verifique a coesão de todos os totais da tabela compra.
*/