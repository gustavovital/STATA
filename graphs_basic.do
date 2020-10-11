/* 
Descrição: Script primário para o entendimento de gráficos no ambiente STATA. Com arquivos base ~

Autor: gustavo de Oliveira Vital
Data: 11 de Outubro de 2020
*/

// Base de dados

infile str14 country setting effort change using https://data.princeton.edu/wws509/datasets/effort.raw, clear

/* O comando infile serve para selecionar as variaveis que se deseja ler. Como a variável "country" é caractere, é necessário especificar isso para o STATA - feito a partir do comando str14*/

// Um simples scatterplot:

graph twoway scatter change setting // simples scatterplot, sem titulo ou etc

// Reta de regressão e legendas nos eixos

graph twoway (scatter setting effort) (lfit setting effort) // simples scatterplot, sem titulo ou etc, entretanto, com uma linha de tendencia. 

graph twoway (scatter setting effort) (lfit setting effort), ytitle("Fertility Decline") legend(off) // Remove as legendas e da o titulo ao eixo y "Fertility Decline". legend(off) remove as legedas (não recomendo).

/* O proximo passo é nomear cada variavel de acordo com o seu nome correspondente (country). Isso é feito a partir do comando mlabel*/

graph twoway (lfitci change setting) (scatter change setting, mlabel(country)) // lfitci da a reta de regressão com intervalo de confiança de 95%

/* One slight problem with the labels is the overlap of Costa Rica and Trinidad Tobago (and to a lesser extent Panama and Nicaragua). We can solve this problem by specifying the position of the label relative to the marker using a 12-hour clock (so 12 is above, 3 is to the right, 6 is below and 9 is to the left of the marker) and the mlabv() option. We create a variable to hold the position set by default to 3 o’clock and then move Costa Rica to 9 o’clock and Trinidad Tobago to just a bit above that at 11 o’clock (we can also move Nicaragua and Panama up a bit, say to 2 o’clock):*/

gen pos=3
replace pos = 11 if country == "TrinidadTobago"
replace pos = 9 if country == "CostaRica"
replace pos = 2 if country == "Panama" | country == "Nicaragua"

// Então temos o gráfico:

graph twoway (lfitci change setting) (scatter change setting, mlabel(country) mlabv(pos)), legend(off) 

