/*
Link do script para criação das tabelas: https://raw.githubusercontent.com/heliokamakawa/curso_bd/master/00-estudo%20de%20caso%20%20loja%20-script.sql
Link imagem do DER: https://github.com/heliokamakawa/curso_bd/blob/master/00-estudo%20de%20caso%20loja%20-%20DER.png

Lista de Exercícios II – Colunas Virtuais e Funções Definidas pelo Usuário
1.	Considerando um cenário em que a tabela PARCELA_PAGAR possui poucas incidências de inserções de novos registros e muitas requisições de consulta. Diante do exposto, interprete a melhor solução para implementar uma coluna gerada VIRTUAL ou ARMAZENADA que indique se a parcela está quitada ou não. Justifique a solução.
2.	Em relação à coluna TOTAL da tabela COMPRA, a coluna respeita todas as regras da normalização? Caso não, identifique qual normalização não é respeitada, explique os possível problemas que podem ser gerados e implemente uma possível solução para minimizar estes problemas. Justifique a solução.
3.	Escreva uma função que retorne a diferença prevista entre pagamentos e recebimentos à vista do dia. Em seguida, escreva o comando para testar a função.
4.	Elabore uma função que receba como parâmetro o código de uma venda, verifique e retorne a quantidade parcelas a receber geradas. Escreva o comando para testar a função e explique se a função criada é de validação, verificação, segurança, simplificação ou de geração de dados/informação.
5.	A coluna CONTATO da tabela CLIENTE foi criada especificamente para registros de empresas – pessoa jurídica. Neste sentido, escreva uma única função que verifique se somente registros de empresas possuem contato. Em seguida, escreva o comando para testar a função.
*/