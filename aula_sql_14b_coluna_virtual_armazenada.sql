/*
Conceito
01) O que é desnormalização?
02) O que é e qual o objetivo da 3º forma normal?
03) Caso a 3º forma normal não seja respeitada, o que ocorre?
04) Quais são as formas de tratar a 3º forma normal? Qual é a mais eficiente?
05) O que é coluna virtual? Para que serve?
06) Em MySQL quais são as formas de implementar uma coluna virtual? Qual é a mais vantajosa?

Prática 
Considere as relações abaixo: 

	ITEM_VENDA(ID, VENDA_ID, PRODUTO_ID, PRECO_UNIDADE, DESCOTO, TOTAL);
	VENDA(ID, DATA, TOTAL);
	PRODUTO(ID, NOME, DESCRICAO, CODIGO_BARRA, PRECO_PAGO, PRECO_CUSTO, PRECO_MINIMO_VENDA, PRECO_VENDA, ESTOQUE); 
		→ PRECO_PAGO → preço pago na compra do produto 
		→ PRECO_CUSTO → estimativa do preço de custo do produto (130% do preço pago) 
		→ PRECO_MINIMO_VENDA → o valor mínimo que o vendedor pode vendar (110% do preço de custo)
		→ PRECO_VENDA → preço de venda do produto (140% do preço de custo)
	PARCELA_PAGAR(ID, NUMERO, VALOR, DESCOTO, JUROS, TOTAL);
	PARCELA_RECEBER(ID, NUMERO, VALOR, DESCOTO, JUROS, TOTAL);
	ESTADO(ID, NOME, SIGLA, NOME_COMPLETO);

De acordo com as tabelas acima, responda:
01) Quais entidades não respeitam a 3ºFN? Justifique. 
02) Dentre as entidades que não respeitam a 3º FN, em quais podemos tratar utilizando a coluna gerada? Justique.
03) Escolha 3 tabelas e trate a 3ºFN utilizando colunas geradas virtuais.
04) Escolha 3 tabelas e trate a 3ºFN utilizando colunas geradas armazenadas. 
05) Quais as diferenças entre as colunas geradas virtuais e as colunas geradas armazenadas?
06) Em que caso devemos utilizar as colunas geradas virtuais? Justifique.
07) Em que caso devemos utilizar as colunas geradas armazenadas? Justifique.
08) Entre a coluna gerada virtual e a armazenada, qual possui o melhor desempenho? Justifique.
*/

