

**Grupo**

**56**

100137

100163

Carlota Barros

Duarte Morais

100202

João Dias

**MECÂNICA COMPUTACIONAL – Engenharia Mecânica e Aeroespacial**

**Trabalho Computacional – Ano lectivo 2022/2023**

**Enunciado 56**

Este trabalho tem como objectivo avaliar a capacidade de implementar computacionalmente

um programa de elementos finitos em Matlab, para a análise linear de problemas planos

(escalares neste caso). Assim, pretende-se que seja construído um modelo de elementos finitos

para um dado problema e que seja revolvido, quer pelo programa implementado, quer por

software comercial de elementos finitos existente (NX, ANSYS, Abaqus, etc.). A malha base

para esta análise deve ter entre 100 a 200 graus de liberdade.

O programa desenvolvido deve ler toda a informação referente à malha de elementos finitos

através de um ficheiro de dados com uma formatação pré-definida (ver página da disciplina no

fenix), e produzir um ficheiro com resultados que sejam relevantes. O programa desenvolvido

deve permitir a aplicação correta das condições de fronteira deste enunciado. Além disso o

programa deve poder utilizar, no mínimo, malhas de elementos finitos com os elementos

indicados na ficha em anexo (OBRIGATÓRIO).

O código deve ser numérico e não deve usar cálculo simbólico.

Problema a resolver: **Condução de Calor**

Pretende analisar-se o problema de condução de calor num corpo plano como representado na

figura.

O corpo é constituído por um ou mais materiais isotrópicos de condutividade térmica k

conhecida. Admita que não há perda de calor nas direcções perpendiculares ao plano do corpo

e que a espessura do corpo é unitária. Pretende determinar-se a distribuição de temperaturas no

sólido em regime estacionário, bem como o fluxo de calor para a situação representada.

Respeite as condições de fronteira especificadas no enunciado.

Considere os seguintes aspectos no seu relatório:

• Apresente a equação diferencial que rege o fenómeno físico que quer estudar e indique

claramente as condições de fronteira empregues e todas as aproximações que fizer.

• Teste e valide o programa desenvolvido para um problema do mesmo tipo com uma geometria

simples para o qual exista solução analítica. Neste caso simples, estude os resultados para a

temperatura, o fluxo de calor e teste os diferentes tipos de condição de fronteira a usar no

trabalho. Apresente a solução analítica e calcule os erros absolutos para a temperatura e para o

fluxo de calor.

• Estabeleça a malha de elementos finitos base, resolva-a com o programa desenvolvido e com

o software comercial. Compare as soluções de uma forma detalhada e crítica de modo a validar

o código em Matlab face ao software comercial.

• Faça uma análise de convergência da solução, refinando uniformemente a malha inicial 4/5

vezes utilizando apenas o software comercial. Cada elemento deve ser subdividido em 4 para

se passar para o nível de refinamento seguinte. Selecione um conjunto de pontos de interesse





(5 a 10) que devem estar presentes em todas as malhas e investigue se há ou não há

convergênciapara a temperatura e para o fluxo de calor.

• Para a última malha obtida (refinada), analise detalhadamente os resultados obtidos. Compare

o comportamento dos elementos testados.

• Represente graficamente a distribuição de temperatura e do fluxo de calor, identificando os

aspectos que considerar relevantes.

• Calcule a potencia calorífica total que atravessa a fronteira discriminando os troços relevantes.

Elabore um relatório **ORIGINAL** a descrever o programa, o modelo construído, bem como

uma análise dos resultados, para as diferentes opções de matriz rigidez escolhida. Apresente o

relatório de acordo com as normas disponibilizadas na página do fenix. Relatórios que não

sigam as normas estipuladas não serão avaliados.

**IMAGEM E DIMENSÕES**

**Enunciado 56**

Condução de Calor

4

k1

2

hint

k2

4

hext

k1

2

3

1,5

Análise com elementos finitos quadrangulares de 4 e 8 nós (Q4 e Q8)

Altura, L1 = 0,1 m





Comprimento total, L2 = 0,11 m

Temperatura na parede do entalhe superior: 175 ºC

Temperatura na parede do entalhe inferior: 425 ºC

Condutividade térmica do material isolante, k1 = 0,06 W/m K

Condutividade térmica do material estrutural, k2 = 2,1 W/m K

Coeficiente de convecção interna hint= 120 W/m2K

Coeficiente de convecção externa hext= 30 W/m2K

Temperatura do vapor interior, Tint= 250 ºC

Temperatura do ar exterior, Text= 25 ºC

Restantes medidas em cm na figura






Instituto Superior Te´cnico

LeMec

Mecaˆnica Computacional

2022/2023

TRABALHO

COMPUTACIONAL

Professor Alexandre Correia

Grupo 56:

Carlota Barros nº 100137

Duarte Morais nº 100163

Joa˜o Dias nº 100202





Projeto de Mecaˆnica Computacional

´

Indice

[1](#br6)[ ](#br6)[Introdu¸c˜ao](#br6)

2

[2](#br6)[ ](#br6)[Considera¸c˜oes](#br6)[ ](#br6)[Te´oricas](#br6)

2

3

4

5

6

6

7

8

8

[2.1](#br7)[ ](#br7)[Condu¸ca˜o](#br7)[ ](#br7)[de](#br7)[ ](#br7)[Calor](#br7)[ ](#br7). . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

[2.2](#br8)[ ](#br8)[Equa¸ca˜o](#br8)[ ](#br8)[Diferencial](#br8)[ ](#br8). . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

[2.3](#br9)[ ](#br9)[Condi¸co˜es](#br9)[ ](#br9)[de](#br9)[ ](#br9)[Fronteira](#br9)[ ](#br9). . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

[2.4](#br10)[ ](#br10)[Formula¸c˜ao](#br10)[ ](#br10)[Forte](#br10)[ ](#br10). . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

[2.4.1](#br10)[ ](#br10)[Formulac¸˜ao](#br10)[ ](#br10)[Fraca](#br10)[ ](#br10). . . . . . . . . . . . . . . . . . . . . . . . . . . . .

[2.5](#br11)[ ](#br11)[Matriz](#br11)[ ](#br11)[de](#br11)[ ](#br11)[Rigidez](#br11)[ ](#br11)[e](#br11)[ ](#br11)[Vetor](#br11)[ ](#br11)[de](#br11)[ ](#br11)[Cargas](#br11)[ ](#br11). . . . . . . . . . . . . . . . . . . . . .

[2.6](#br12)[ ](#br12)[Malhas](#br12)[ ](#br12)[de](#br12)[ ](#br12)[Elementos](#br12)[ ](#br12)[Finitos](#br12)[ ](#br12)[2D](#br12)[ ](#br12). . . . . . . . . . . . . . . . . . . . . . . . .

[2.6.1](#br12)[ ](#br12)[Malhas](#br12)[ ](#br12)[Retangulares](#br12)[ ](#br12). . . . . . . . . . . . . . . . . . . . . . . . . . .

[3](#br15)[ ](#br15)[Implementac¸˜ao](#br15)[ ](#br15)[em](#br15)[ ](#br15)[MATLAB](#br15)

11

11

11

11

12

12

[3.1](#br15)[ ](#br15)[Objetivos](#br15)[ ](#br15). . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

[3.2](#br15)[ ](#br15)[Descri¸ca˜o](#br15)[ ](#br15)[de](#br15)[ ](#br15)[func¸˜oes](#br15)[ ](#br15). . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

[3.2.1](#br15)[ ](#br15)[Fun¸co˜es](#br15)[ ](#br15)[principais](#br15)[ ](#br15). . . . . . . . . . . . . . . . . . . . . . . . . . . .

[3.2.2](#br16)[ ](#br16)[Fun¸co˜es](#br16)[ ](#br16)[secund´arias](#br16)[ ](#br16). . . . . . . . . . . . . . . . . . . . . . . . . . .

[3.3](#br16)[ ](#br16)[Solu¸ca˜o](#br16)[ ](#br16)[anal´ıtica](#br16)[ ](#br16). . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

[4](#br18)[ ](#br18)[Siemens](#br18)[ ](#br18)[NX](#br18)

14

14

17

18

18

[4.1](#br18)[ ](#br18)[Ana´lise](#br18)[ ](#br18)[de](#br18)[ ](#br18)[convergˆencia](#br18)[ ](#br18). . . . . . . . . . . . . . . . . . . . . . . . . . . . .

[4.2](#br21)[ ](#br21)[Reﬁnamento](#br21)[ ](#br21)[da](#br21)[ ](#br21)[malha](#br21)[ ](#br21). . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

[4.2.1](#br22)[ ](#br22)[Malha](#br22)[ ](#br22)[de](#br22)[ ](#br22)[QUAD-4](#br22)[ ](#br22). . . . . . . . . . . . . . . . . . . . . . . . . . . .

[4.2.2](#br22)[ ](#br22)[Malha](#br22)[ ](#br22)[de](#br22)[ ](#br22)[QUAD-8](#br22)[ ](#br22). . . . . . . . . . . . . . . . . . . . . . . . . . . .

[5](#br23)[ ](#br23)[Comparac¸˜ao](#br23)[ ](#br23)[de](#br23)[ ](#br23)[Resultados](#br23)[ ](#br23)[entre](#br23)[ ](#br23)[MATLAB](#br23)[ ](#br23)[e](#br23)[ ](#br23)[NX](#br23)

19

19

20

21

[5.1](#br23)[ ](#br23)[Malha](#br23)[ ](#br23)[de](#br23)[ ](#br23)[QUAD-4](#br23)[ ](#br23). . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

[5.2](#br24)[ ](#br24)[Malha](#br24)[ ](#br24)[de](#br24)[ ](#br24)[QUAD-8](#br24)[ ](#br24). . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

[5.3](#br25)[ ](#br25)[Interpreta¸c˜ao](#br25)[ ](#br25)[dos](#br25)[ ](#br25)[resultados](#br25)[ ](#br25). . . . . . . . . . . . . . . . . . . . . . . . . . .

[6](#br26)[ ](#br26)[Determina¸c˜ao](#br26)[ ](#br26)[da](#br26)[ ](#br26)[Potˆencia](#br26)[ ](#br26)[Calor´ıﬁca](#br26)

[7](#br27)[ ](#br27)[Conclus˜oes](#br27)

22

23

24

29

[8](#br28)[ ](#br28)[Anexo](#br28)

[9](#br33)[ ](#br33)[Referˆencias](#br33)

1





Projeto de Mecaˆnica Computacional

1 Introdu¸c˜ao

Este trabalho computacional visa colocar em pra´tica conhecimentos adquiridos na unidade

curricular de Mecaˆnica Computacional e, particularmente, analisar o problema de condu¸ca˜o

de calor num corpo plano, atrav´es da aplica¸ca˜o do M´etodo dos Elementos Finitos (MEF).

Ana´lises deste tipo tˆem em conta diversas varia´veis, entre elas o material e geometria do

corpo analisado, o que introduz alguma complexidade nestes problemas, impossibilitando-se

a sua compreens˜ao atrav´es de uma simples abordagem anal´ıtica. Surge assim a necessidade

de recorrer a programas computacionais como o Siemens NX e o MATLAB, de forma a que

se possa construir um modelo de elementos ﬁnitos, neste caso para um problema 2D com

inco´gnita escalar, que se possa resolver tanto pelo software comercial de elementos ﬁnitos

utilizado, como pelo programa implementado.

Desta forma, procurando-se a valida¸c˜ao do co´digo desenvolvido, compararam-se as solu¸co˜es

anal´ıticas que resultam da implementa¸ca˜o computacional de um programa de elementos ﬁni-

tos em MATLAB com as va´rias solu¸c˜oes de referˆencia, obtidas nas mu´ltiplas simula¸co˜es no

programa Siemens NX.

2 Considera¸c˜oes Teo´ricas

Para formular um modelo de elementos ﬁnitos ´e necess´ario passar por diferentes fases,

sendo elas:

• A discretiza¸ca˜o por elementos ﬁnitos do dom´ınio, uma fase que nos permite obter

uma malha, composta pelo contorno original, por pontos nodais e, no caso da ﬁgura

apresentada, por elementos ﬁnitos triangulares ;

Figura 1: Discretiza¸ca˜o por elementos ﬁnitos do dom´ınio

• A obten¸ca˜o de fun¸co˜es aproximadas para cada um desses elementos, de acordo com a

dimensa˜o e tipo do problema ;

• Montagem dos elementos, tendo em conta a continuidade da solu¸c˜ao;

Note-se que, ainda que este seja um m´etodo aproximado, a convergˆencia do MEF permite-

nos aﬁrmar que em malhas consistentes, a` medida que o tamanho dos elementos ﬁnitos tende

para zero, a quantidade de n´os tende consequentemente para inﬁnito e a solu¸ca˜o obtida

converge para a solu¸c˜ao exata do problema.

Assim, prova-se que quanto maior for o nu´mero de elementos numa malha, mais rigorosa

sera´ a an´alise obtida, pelo que a precisa˜o do MEF depende na˜o s ´o da quantidade de no´s e

elementos na malha, mas tamb´em do tamanho e tipo desses elementos.

2





Projeto de Mecaˆnica Computacional

2.1 Condu¸c˜ao de Calor

Considere-se um corpo bidimensional num sistema de coordenadas cartesianas. Q(x, y) ´e

a taxa de calor por unidade de volume e tempo e q (x, y) e q (x, y) s˜ao as componentes do

x

vetor ﬂuxo de calor num ponto gen´erico (x,y) de um dom´ınio Ω.

y

Nestas condi¸c˜oes, a equa¸ca˜o que rege o problema de conduc¸˜ao de calor pode ser deduzida

considerando-se um elemento diferencial de lados dx e dy e um ﬂuxo de calor que atravesse

um contorno inﬁnitesimal.

Admitindo-se uma espessura unita´ria para o corpo em ana´lise, a taxa de calor inerente ´e

Qdxdy e, n˜ao havendo perda de calor na dire¸ca˜o dos contornos, tem-se:

∂qx

∂x

∂qy

∂y

Qdxdy + q dy + q dx = (q +

x

dx) dy + (qy +

dy)dx

(1)

x

y

Partindo-se da equa¸c˜ao anterior ´e poss´ıvel obter a solu¸ca˜o do problema para regime esta-

ciona´rio,

∂qx ∂qy

−

−

\+ Q = 0

(2)

∂x

∂y

que tamb´em se pode representar da forma,

−∇T q + Q = 0 em Ω

∇T q = div q

(3)

(4)

onde

A Lei de Fourier diz-nos que, para um ﬂuxo unidimensional, se veriﬁca proporcionalidade

entre o ﬂuxo de calor numa dire¸c˜ao e a taxa de varia¸ca˜o de temperatura u nessa mesma

dire¸ca˜o, pelo que se tem

∂u

qx = −kx

,

(5)

∂x

onde kx ´e a condutividade t´ermica do material na dire¸ca˜o longitudinal.

Generalizando para o caso bidimensional tem-se:

q(x, y) = −k∇u ,

cuja matriz de conectividade ´e dada por

(6)

(7)

ꢀ

ꢁ

k (x, y) k (x, y)

xy

xx

k (x, y) k (x, y)

k = k(x, y) =

xy

yy

e

ꢂ ꢃ

ꢂ ꢃ

∂

∂u

∇u = ∂x u = ∂x = grad u ≡ gradT.

(8)

∂

∂y

∂u

∂y

Desta forma conclui-se que,

3





Projeto de Mecaˆnica Computacional

ꢄ

ꢅ

ꢅ

∂u

∂x

∂u

∂x

∂u

∂y

∂u

∂y

q = − k

\+ kxy

x

xx

(9)

ꢄ

q = − k

\+ kyy

y

xy

Relacionando este resultado com as equa¸c˜oes [(2)](#br7)[ ](#br7)e [(9)](#br8)[ ](#br8)obt´em-se:

ꢄ

ꢅ

ꢄ

ꢅ

∂

∂u

∂x

∂u

∂y

∂

∂u

∂x

∂u

∂y

kxx

\+ kxy

\+

kxy

\+ kyy

\+ Q = 0

(10)

∂x

∂y

Para o caso em que (x, y) coincidem com as dire¸co˜es principais do material, kxy = 0 e

considerando-se um meio isotr´opico, kxx = kyy = k, pelo que a matriz de condutividade

t´ermica ´e dada por:

ꢀ

ꢁ

k(x, y)

0

0

k(x, y)

k = k(x, y) =

= k(x, y) I

(11)

Em meios homog´eneos kxx e kyy sa˜o constantes e, mais especiﬁcamente, num meio isentro´pico

kxy = 0 e kxx = kyy = k = cte. Desta forma o resultado obtido anteriormente pode ser sim-

pliﬁcado, obtendo-se a Equa¸ca˜o de Poisson, uma equa¸c˜ao que nos permite estudar diversos

feno´menos em engenharia:

∂2T

∂x2

∂2T

∂y2

k(

\+

) + Q = 0

(12)

(13)

Na˜o havendo nenhuma fonte de calor interna, Q = 0, tem-se apenas:

∂2T

∂x2

∂2T

∂y2

\+

= 0

Chega-se assim a` Equa¸ca˜o de Laplace.

2.2 Equa¸c˜ao Diferencial

Aplicando o princi´ıpio da conserva¸ca˜o de energia, podemos aﬁrmar que as equa¸co˜es difer-

enciais gerais que descrevem o problema da condu¸ca˜o de calor, estudado num dom´ınio de 2

dimenso˜es, em regime transiente e estaciona´rio, respetivamente, sa˜o:

−∇ . (k∇u) + c.u = f

(14)

(15)

e

∇ . (k∇u) + f = 0

onde k, b e f sa˜o fun¸c˜oes cont´ınuas em (x,y) que representam a condutividade t´ermica, a

convec¸c˜ao e a gerac¸˜ao de calor, respetivamente.

4





Projeto de Mecaˆnica Computacional

Ja´ a rela¸c˜ao entre o vetor ﬂuxo de calor e o gradiente de temperatura ´e dada pela Lei de

Fourier, que nos descreve o comportamento do material da seguinte forma:

q(x, y) = −∇ . (k∇u)

sendo q o vetor ﬂuxo e u a temperatura.

(16)

Considere-se um dom´ınio inﬁnitesimal Ω com fronteira designada ΓΩ, tal como represen-

tado na ﬁgura [(2),](#br9)

Figura 2: Fluxo de calor que atravessa um elemento inﬁnitesimal

Pode-se enta˜o calcular o ﬂuxo total de calor que atravessa a fronteira do dom´ınio da

seguinte forma:

Z

Z

Z

Z

X

\=

qnds =

⃗q . nds =

div⃗q . dxdy =

∇ . ⃗q . dxdy

Ω

(17)

ΓΩ

ΓΩ

Ω

2.3 Condi¸c˜oes de Fronteira

As condi¸c˜oes de fronteira podem ser de v´arios tipos.

• Condi¸c˜oes de fronteira essenciais: Correspondem a ﬂuxos impostos. Desta forma, sendo

o valor da temperatura u especiﬁcado numa por¸c˜ao da fronteira Γ , a condi¸c˜ao de

Ω

1

fronteira ´e do tipo de Dirichlet. Visto que se estudam va´rias malhas neste problema, as

condi¸co˜es de fronteira nos no´s dependem do numero de no´s em cada malha, pelo que

se podem escrever as seguintes relac¸˜oes:

uˆ = u ⇒ uˆ = u , uˆ = u

(18)

x

x

y

y

• Condi¸c˜oes de fronteira naturais: Na outra porc¸˜ao da fronteira, as condi¸co˜es de fronteira

podem assumir ainda outras 2 formas:

\1. Condi¸c˜oes de Neumann (ﬂuxo normal especiﬁcado):

∂u

qn(s) = −k

= qˆ(s) , ∀s ∈ ΓΩ

(19)

(20)

∂n

2

\2. Condi¸c˜oes de Robin, sendo p(s) um coeﬁciente de convec¸c˜ao para o exterior:

∂u

qn(s) = −k

= p(s)[u(s) − uˆ(s)] , ∀s ∈ ΓΩ

∂n

2

5





Projeto de Mecaˆnica Computacional

2.4 Formula¸c˜ao Forte

Tal como j´a foi demonstrado anteriormente, ao substituir-se a equa¸c˜ao constitutiva q(x, y) =

−k.u(x, y) no princ´ıpio da conserva¸ca˜o de energia div q = f, obt´em-se −k.u(x, y) = f.

Desta forma, ´e-nos poss´ıvel obter a formula¸ca˜o forte

−k.u(x, y) = f em Ω

(21)

cujas condi¸co˜es de fronteira (essenciais e naturais) s˜ao respetivamente representadas na

Figura [(3)](#br10)[ ](#br10)por ΓΩ1 e Γ .

Ω

2

Figura 3: Dom´ınio Ω

2.4.1 Formula¸c˜ao Fraca

Pretendendo-se chegar `a formula¸ca˜o fraca do problema da conduc¸˜ao de calor, obt´em-se o

res´ıduo R(x, y) dado por:

R(x, y) = −k.u(x, y) − f = 0

que se multiplica por uma qualquer fun¸c˜ao de teste v e que se integra em todo o dom´ınio,

obtendo-se

(22)

Z

Z

Z

Z

R(x, y).v dxdy = Ω((−k.u(x, y)) − f).v dxdy = − v(k.u(x, y)) dxdy − fv dxdy = 0

Ω

Ω

Ω

(23)

Esta express˜ao pode ser desenvolvida ao longo de uma sucessa˜o de passos at´e que se

obtenha

Z

Z

Z

k.u(x, y).v(x, y) dxdy =

fv dxdy +

qˆv ds

(24)

Ω

Ω

ΓΩ2

onde v ´e um campo de temperaturas virtuais, isto ´e, uma varia¸c˜ao do campo de temper-

aturas real u. Escrevendo de outro modo, temos:

Z

Z

Z

ꢄ

ꢅ

∂u ∂v ∂u ∂v

k

\+

dxdy =

fv dxdy +

qˆv ds

(25)

∂x ∂x ∂y ∂y

Ω

Ω

ΓΩ2

6





Projeto de Mecaˆnica Computacional

ou ainda,

Z

Z

Z

Ω(k∇u.∇v + c.u.v) dΩ +

pv[u − uˆ∞] ds =

fv dΩ

(26)

ΓΩ2

Ω

Para que se obtenha a formulac¸˜ao de um problema de elementos ﬁnitos, ha´ que substituir

o dom´ınio Ω por uma aproximac¸˜ao Ωh, que n˜ao ´e mais do que uma por¸ca˜o de E elementos

ﬁnitos com N no´s, resultantes da discretiza¸ca˜o desse mesmo dom´ınio.

Escolhendo um qualquer elemento ﬁnito arbitra´rio Ωe, podemos deﬁnir v´arias fun¸co˜es

aproximadoras cont´ınuas Φi(i=1,...,N) dentro desse mesmo elemento. Pelo m´etodo de Galerkin

tem-se:

XN

vh(x, y) =

uh(x, y) =

v Ψ (x, y)

i i

i=1

(27)

XN

Aplicando v e u na formula¸ca˜o fraca obtida anteriormente, chega-se `as equac¸˜oes deﬁnidas

u Ψ (x, y)

i

i

i=1

h

h

por:

XN

K T = F para (i = 1, ..., N)

ij

(28)

j

i

j=1

onde Kij representa os coeﬁcientes da matriz de rigidez, para o problema de condu¸ca˜o de

calor.

2.5 Matriz de Rigidez e Vetor de Cargas

Partindo do sistema de equa¸co˜es alg´ebricas lineares apresentado na secc¸˜ao anterior, tem-

se que a matriz de rigidez K representa a condutividade t´ermica dos materiais e calcula-se

da seguinte forma:

Z

ꢀ

ꢁ

Z

ꢄ

ꢅ

∂Φi ∂Φj ∂Φi ∂Φj

Kij =

k

\+

\+ c ΦiΦj

\+

p Φ Φ ds

i

(29)

j

∂x ∂x

∂y ∂y

Ωh

ΓΩ2h

Fi sa˜o as componentes do ”vetor de for¸cas”, tamb´em no caso concreto da condu¸ca˜o de

calor, e s˜ao dadas por:

Z

Z

Fi =

fΦi dΩ +

γ Φi ds

(30)

Ωh

ΓΩ2h

com γ ≡ qˆ e ΓΩ = ΓΩqh

Alterando-se o sistema de forma a ter em conta as condi¸co˜es de fronteira essenciais, obt´em-

.

2h

se os valores nodais uj que deﬁnem a solu¸ca˜o aproximada. Para uˆ, aplica-se a aproximac¸˜ao

7





Projeto de Mecaˆnica Computacional

XN

uˆh(s) =

uˆ Φ (x(s), y(s))

j

(31)

j

j=1

para que se tenha apenas de especiﬁcar uˆj nos n´os de ΓΩ1h

.

A temperatura num ponto interior de um elemento pode ser obtida por interpola¸ca˜o

usando-se as func¸˜oes de forma Ψ, onde Ψ designa as fun¸co˜es de forma, tal que:

XN

e

e

h

e

i

u (x, y) =

Ψ (x, y)u

i

(32)

i=1

Ja´ os ﬂuxos nos pontos interiores dos elementos podem ser obtidos derivando essas fun¸co˜es

de forma:

XN

e

e

h

e

h

e

i

q = −k∇u (x, y) = −k

u ∇Ψ (x, y)

(33)

i

i=1

Como os ﬂuxos em elementos adjacentes a um mesmo no´ sa˜o diferentes, existe uma

descontinuidade nos no´s e o erro do ﬂuxo que os atravessa ´e maior. De forma a melhorar

a precis˜ao dos c´alculos num n´o arbitr´ario, o software usado faz uma m´edia ponderada dos

valores dos ﬂuxos de todos os elementos que partilham esse no´.

2.6 Malhas de Elementos Finitos 2D

Uma malha de elementos ﬁnitos pode ter o formato de triaˆngulos, quadril´ateros ou outros.

Para garantir a continuidade da solu¸ca˜o obtida, ´e necessa´rio que dois elementos adjacentes

tenham o mesmo tipo de interpola¸ca˜o sobre o lado que lhes ´e comum, sendo que a qualidade

da malha depende da existˆencia de distor¸co˜es e dos parˆametros dos elementos.

Tamb´em o aumento do grau das fun¸co˜es de forma dos elementos pode inﬂuenciar positi-

vamente o resultado das simula¸c˜oes. Assim, em vez das fun¸co˜es de forma serem apenas de

grau 1, podera˜o ser de grau 2, 3, ou superior, alcan¸cando-se maior precisa˜o nos resultados,

necessitando-se no entanto de um maior poder computacional.

2.6.1 Malhas Retangulares

• QUAD-4: elementos com 4 no´s, lineares

A temperatura no interior de um qualquer elemento, ueh(x, y), ´e dada por:

X4

e

h

e

j

e

1

e

2

e

3

e

u =

Ψ u = Ψ u + Ψ u + Ψ u + Ψ u

4

4

(34)

j

1

2

3

j=1

onde Ψe, Ψe e Ψe sa˜o as fun¸co˜es de forma para um elemento quadrangular linear, que se

1

relacionam com as coordenadas dos seus no´s e com a ´area do elemento.

2

3

8





Projeto de Mecaˆnica Computacional

A matriz de rigidez para elementos deste tipo ´e dada por:





2(a2 + b2)

a2 − 2b2

−(a2 + b2) b2 − 2a2

Z Z

ꢆ

ꢇ

b

a ꢆ ꢇ ꢆ ꢇ



2

2

2

2

2

2

2

2

2 

k

a − 2b

2(a + b ) b − 2a

−(a + b )

t





Ke = k

B

B dxdy =



2

2

2

2

2

2

2 

6ab −(a + b ) b − 2a

2(a + b ) a − 2b

0

0

b2 − 2a2

−(a2 + b2) a2 − 2b2

2(a2 + b2)

(35)

sendo k a condutividade t´ermica do material e a e b as dimenso˜es do elemento retangular.

Ja´ o vetor de cargas ´e dado por:

 

1

 

 

ꢆ

ꢇ

ab

1

Fe = f

(36)

4 1

 

 

1

O c´alculo da matriz de rigidez ´e feito atrav´es do m´etodo de integra¸ca˜o num´erica de Gauss-

Legendre, que implica a mudan¸ca de vari´aveis dada por:

(

P

P

4

i=1

4

e

x = x(ζ, η) =

y = y(ζ, η) =

Ψ (x, y)x

i

i

(37)

Ψ (x, y)y

e

i

i

i=1

como ilustra a ﬁgura seguinte

Figura 4: Transformac¸˜ao de coordenadas para um elemento isoparam´etrico

A maioria dos elementos ﬁnitos de 4 n´os considerados tˆem geometria rectangular com

lados paralelos e ortogonais, no entanto, ´e poss´ıvel considerar elementos quadril´ateros na˜o

rectangulares, ao se aplicar o conceito de elementos ﬁnitos isoparam´etricos atrav´es da mu-

dan¸ca de varia´vel abordada anteriormente. Desta forma, o integral de a´rea

Z

f(x, y) dxdy

(38)

Ωe

´e convertido em

9





Projeto de Mecaˆnica Computacional

Z

Z

1

1

f(ζ, η) J(ζ, η) dζdη

(39)

−1 −1

onde J representa o determinante da matriz Jacobiana.

He e Pe sa˜o coeﬁcientes adicionais que podem ser calculados atrav´es de integrais de

ij

fronteira. Desta forma, sendo componentes relativas `a convec¸c˜ao so´ se podem aplicar a

i

elementos afetados por condi¸co˜es de fronteira desse tipo. Estes coeﬁcientes sa˜o enta˜o dados

por:

























2 1 0 0

1 2 0 0

0 0 0 0

0 0 0 0

0 0 0 0

0 2 1 0

0 1 2 0

0 0 0 0

0 0 0 0

0 0 0 0

0 0 2 1

0 0 1 2

2 0 0 1

0 0 0 0

0 0 0 0

1 0 0 2

(40)

ꢆ

ꢇ

e

e 

e

e 

e

e 

e

e 

β h

β h

β h

β h

12 12 



23 23 



34 34 



41 41 



He =

\+

\+

\+

















6

6

6

6

 

 

 

 

1

0

0

1

ꢆ

ꢇ

β T h

e

12

12 e  

β T h

e

23

23 e  

β T h

e

34

34 e  

β T h

e

41

41 e  

1

1

0

0

Pe =

∞

12  

\+

∞

23  

\+

∞

34  

\+

∞

41  

(41)

 

 

 

 

2

0

2

1

2

1

2

0

0

0

1

1

onde o fator βe representa o coeﬁciente de convec¸c˜ao, que se assume constante.

A matriz H e o vetor P acima descritos dependem do tipo de malha a que sa˜o aplicados

e de paraˆmetros como o coeﬁciente de convecc¸˜ao βe ou at´e o distˆanciamento entre os no´s h

e a temperatura do meio ambiente, T∞.

Estas componentes foram implementadas computacionalmente em MATLAB consoante

as seguintes express˜oes alg´ebricas:



ꢄ

H

ꢅ

R

e

e ∂Ψej

∂Ψi



Ke =

kx

\+ ky

∂y ∂y

dxdy



ij

Ω

∂x ∂x

He = βe

ij

Ψe Ψe ds

i j

Ψe T ds

(42)



c



H Γ



Pe = βe

i

Γ

i

∞

c

10





Projeto de Mecaˆnica Computacional

• QUAD-8: elementos com 8 no´s, quadr´aticas

Para o caso de elementos quadrangulares com 8 no´s, o racioc´ıno ´e ana´logo ao do caso

anterior, com a diferenc¸a de que, neste caso, o polin´omio ´e quadra´tico em x e y e tem um

termo biquadr´atico em xy, sendo dado por:

e

h

2

u (x, y) = a + a x + a y + a xy + a x + a y + a xy + a x y + a x y

2

2

2

2 2

0

1

2

3

4

5

6

7

8

Relativamente a`s matrizes de conven¸ca˜o, na implementa¸ca˜o do co´digo em MATLAB,

optou-se por calcula´-las de uma forma diferente a` mencionada anteriormente. Recorreu-se

a` interpola¸c˜ao quadra´tica dos lados dos elementos da fronteira, seguida de uma integra¸ca˜o

num´erica de Gauss-Legendre 1D a 3 pontos (grau 5), tal como pode ser visto em [(43)](#br15)

(

P

Hiej =

Pie =

3

k=1

β Ψ (ξ )Ψ (ξ ) (ξ )w

k

e

ds

dξ

i

k

j

k

k

P

(43)

3

k=1

e

ds

β T Ψ (ξ ) (ξ )w

k

∞

i

k

k

dξ

onde w representa o peso do ponto de integrac¸˜ao em quest˜ao.

k

3 Implementac¸˜ao em MATLAB

3.1 Objetivos

O desenvolvimento de um programa deste tipo em MATLAB tem como objetivo o de

construir um modelo de elementos ﬁnitos para o problema de condu¸c˜ao de calor que possa,

posteriormente, ser comparado com o software comercial Siemens NX. Este programa l ˆe

toda a informac¸˜ao referente a` malha de elementos ﬁnitos presente num ﬁcheiro de dados de

formata¸c˜ao pr´e-deﬁnida, e produz um ﬁcheiro com resultados relevantes para, pelo menos,

malhas de elementos ﬁnitos retangulares de 4 e 8 n´os, com graus de liberdade entre no´s 100

e 200.

Tanto a estrutura como o funcionamento do programa sa˜o explorados em detalhe na

subsec¸ca˜o que se segue.

3.2 Descri¸c˜ao de fun¸c˜oes

Para visualizar a ´arvore do programa em MATLAB, ver o ﬂuxograma [(40)](#br28)[ ](#br28)presente no

anexo.

3.2.1 Fun¸c˜oes principais

main(): A fun¸ca˜o main() ´e a fun¸ca˜o principal que chama todas as outras fun¸co˜es do

projeto para simular o problema de conduc¸˜ao de calor da placa. Ao correr, na consola,

sera´ perguntado ao utilizador qual malha pretende executar. Dependedo do nu´mero que o

utilizador escreva, o programa ira´ correr a malha correspondente a esse nu´mero (1 - Malha

quandragular de 4 no´s, simples; 2 - Malha quandragular de 8 n´os, simples; 3- Malha quan-

dragular de 4 no´s; 2 - Malha quandragular de 8 no´s).

ler ﬁcheiro(): Lˆe toda a informa¸c˜ao do ﬁcheiro .txt no formato deﬁnido e guarda-a em

varia´veis que ser˜ao utilizadas por outras fun¸c˜oes do programa.

11





Projeto de Mecaˆnica Computacional

escolher data(): Esta fun¸ca˜o executa algumas opera¸c˜oes na informa¸ca˜o lida anterior-

mente para facilitar os ca´lculos que sera˜o feitos com estes dados.

CalculosElementares e Assemblagem(): A partir da informa¸c˜ao lida e trabalhada

anteriormente, esta fun¸ca˜o calcula as matrizes elementares e faz a assemblagem, criando as

matrizes globais (B e P ) do respetivo problema, tendo em conta se existe conven¸ca˜o.

g

g

calculo temperatura ﬂuxo(): Esta fun¸c˜ao utiliza as matrizes B e P para calcular a

g

g

´

temperatura nodal. E tamb´em nesta fun¸ca˜o que s˜ao calculados os v´arios valores do gradiente

da temeperatura e ﬂuxo, tal como o ponto de origem de cada vetor.

representacao graﬁca(): Fun¸c˜ao respons´avel por apresentar uma janela ﬁnal com trˆes

gra´ﬁcos: um representante da malha utilizada e respetivos no´s, um representante da temper-

atura nodal e outro onde s˜ao apresentados os va´rios vetores de ﬂuxo e respetivos pontos de

origem.

resultados(): Apo´s ser tudo calculado, esta fun¸ca˜o apresenta na consola os valores da

temperatura em cada no´ e o m´odulo do gradiente e ﬂuxo, em cada ponto calculado.

3.2.2 Fun¸c˜oes secund´arias

calc Ke 1elementoQ(): Fun¸c˜ao que calcula a matriz de rigidez para um elemento quan-

´

dragular de quatro ou oito n´os. E chamada na fun¸c˜ao principal CalculosElementares e Assemblagem().

calc robin quad(): No caso de existir conven¸ca˜o para um elemento de 8 n´os, esta fun¸ca˜o

calcula a matriz sim´etrica H que ´e utilizada para obter matriz de rigidez elementar e o vetor

e

P que contribui para o vetor de for¸cas global. E chamada na fun¸ca˜o principal CalculosEle-

´

e

mentares e Assemblagem().

3.3 Solu¸c˜ao anal´ıtica

Pode-se encontrar a solu¸ca˜o anal´ıtica para este problema, partindo-se da uma geometria

simples de uma malha quadrangular, como mostra a ﬁgura que se segue.

Figura 5: Malha de quadrila´teros

12





Projeto de Mecaˆnica Computacional

Testar o programa para uma malha deste tipo ´e suﬁciente, pelo que, assumindo valor

unita´rio para a largura dos quadrados e substituindo valores na equa¸c˜ao [(35)](#br13)[ ](#br13)j ´a estudada,

obt´em-se a matriz de rigidez:









4

−1 −2 −1

ꢆ

ꢇ

k −1

4

−1 −2





Ke =





6 −2 −1

4

−1

−1 −2 −1

4

Sabe-se que o vetor de cargas [Fe] ´e nulo, a temperatura do ambiente exterior ´e Tamb

\=

25◦C e a condutividade t´ermica do material extrutural ´e k = 2.1W/mK. Na ausˆencia de

gera¸ca˜o de calor ou convec¸ca˜o em regime estaciona´rio, tem-se tamb´em que −k∇2u = 0.

Sendo que [Ke][Te] = [Qe] e que,

I

e

i

Q =

q Ψ ds

n

(44)

i

Γc

as temperaturas em cada n´o seriam dadas por Ui e,



U = U = U = 0





4

8

12





U = T



9

amb

√

3

U =

10



2





Tamb

U =



11



2

F = F = F = F = 0 , f luxo nulo devido ao isolamento



1

2

3

5

e o balan¸co de energia interna implica F = F = 0. Assim, as inc´ognitas do problema

7

6

sa˜o: F , F , F , F , F e F12 e U , U , U , U , U e U . Sabe-se tamb´em que:

4

8

9

10

11

1

2

3

5

6

7



K = K

1 , K = K1 , K = K1

12 14

12 15



11

11





K = K1 , K = K1 + K2 , K = K2 , K = K1

16

13

1

22

2

22

11

23

12

25

24



K = K + K , K = K2 etc.





26

23

14

27

13



Desta forma, obt´em-se a seguinte equac¸˜ao na forma matricial:

F = Q1 , F = Q1 + Q2 , F = Q2 + Q3 , F = Q3 etc.

1

1

2

2

1

3

2

1

4

2



 







4

−1

0

−1

8

−1

0

−1 −2

0

U 



0

0

0





1















 







−1 −2 −2 −2 U 







  2

















k

8

0

0

8

−2 −2

U

k





3

√

\=

(45)





6 −1 −2

−2

0

U  6 

T

\+

3 Tamb





  5



amb√













 







−2 −2 −2 −2 16 −2 U 

2T

\+

3 Tamb + T

3 Tamb + Tamb





6



am√b

amb



Como pode ser consultado em [1], podem-se calcular as solu¸co˜es anal´ıticas para este caso







0

−2 −2

0

−2 16

U

7

da seguinte forma:

(

U = 0.6128 ∗ T

= 15.32◦C , U = 0.5307 Tamb = 13.27◦C , U = 0.3064 Tamb = 7.66◦C

2 3

∗

∗

1

amb

amb

U = 0.7030 ∗ T

= 17.58 C , U = 0.6088 Tamb = 15.22 C , U = 0.3515 Tamb = 8.79◦C

◦

∗

◦

∗

5

6

7

13





Projeto de Mecaˆnica Computacional

Desta forma, tendo as soluc¸˜oes anal´ıtcas e os dados obtidos no programa, ´e poss´ıvel obter

os erros relativos que se apresentam de seguida. O facto destes valores serem baixos ´e um

forte indicador do bom funcionamento do programa.

Table 1: Ana´lise de resultados

Temperaturas nodais

Nº do N´o

Solu¸co˜es Anal´ıticas 15.32 ºC

1

2

3

5

6

7

13.27 ºC

7.66 ºC 17.58 ºC 15.22 ºC 8.79 ºC

Solu¸ca˜o do Software 12.257 ºC 10.615 ºC 6.128 ºC 14.06 ºC 12.176 ºC 7.03 ºC

Erro (%) 20 20 20 20 20 20

Para o problema de geometria simples resolvido por uma a malha quadr´atica de 8 no´s,

foi feito o mesmo exemplo da malha linear alterando o nu´mero de n´os. Os resultados obtidos

podem ser consultados no anexo nas ﬁguras [(42),](#br28)[ ](#br28)[(44)](#br29)[ ](#br29)e [(46).](#br29)

4 Siemens NX

Para que se possam comparar os resultados da implementa¸ca˜o em MATLAB, foram real-

izadas simulac¸˜oes do problema no software SIEMENS NX. Procedeu-se enta˜o ao reﬁnamento

das malhas, de forma a avaliar a convergˆencia dos resultados, tendo cada reﬁnamento aprox-

imadamente 4 vezes mais elementos que o reﬁnamento anterior. Para isso, escolheram-se 6

pontos em zonas cr´ıticas da placa, que representam n´os comuns a todas as malhas. A partir

desses pontos, realiza-se a ana´lise de convergˆencia por meio de compara¸co˜es entre itera¸co˜es

sucessivas, de forma a analisar o efeito dos constrangimentos aplicados em toda a pec¸a.

Em ambiente de simulac¸˜ao foram geradas no total 22 malhas, sendo que, metade foram

malhas lineares de quadrila´teros e as restantes foram malhas quadr´aticas de quadril´ateros.

Ambos os tipos de malhas sofreram 5 reﬁnamentos. As malhas quadrangulares geradas

tinham um total de 151, 656, 2632, 9510, 39603 e 156412 elementos.

4.1 An´alise de convergˆencia

De forma a que se pudesse interpretar a evolu¸c˜ao dos resultados obtidos, foram seleciona-

dos 6 no´s da placa, dispostos tal como se mostra na ﬁgura [(6)](#br19)[ ](#br19)e tra¸caram-se os gra´ﬁcos da

temperatura em func¸˜ao do nu´mero de n´os, para cada elemento.

• Convergˆencia da temperatura

Apresentam-se ent˜ao os gra´ﬁcos da convergˆencia do valor da temperatura para cada um

desses n´os, onde est˜ao representados simultaneamente os resultados para malhas do tipo

QUAD-4 e QUAD-8.

14





Projeto de Mecaˆnica Computacional

Figura 6: Localizac¸˜ao dos n´os analisados

Figura 7: Convergˆencia do 1º No´

Figura 8: Convergˆencia do 2º N o´

Figura 9: Convergˆencia do 3º No´

Figura 10: Convergˆencia do 4º No´

15





Projeto de Mecaˆnica Computacional

Figura 11: Convergˆencia do 5º No´

Figura 12: Convergˆencia do 6º No´

Em primeiro lugar, a partir da an´alise dos gr´aﬁcos, ´e poss´ıvel concluir que os no´s con-

vergem para ambas as malhas, como ja´ seria de esperar. No entanto, ´e de notar que para o

mesmo nu´mero de elementos, as malhas de quadril´ateros quadr´aticas convergem mais rapida-

mente do que as malhas de quadril´ateros lineares, ja´ que os seus valores no caso quadra´tico ﬂu-

tuam entre intervalos mais pequenos. Por esse motivo, as malhas de quadrila´teros quadra´ticas

sa˜o uma opc¸˜ao mais precisa, mas que em contrapartida requer uma maior carga computa-

cional, na medida em ´e necessa´rio executar um maior nu´mero de opera¸c˜oes computacionais.

Posto isto, foi poss´ıvel compreender que, para obter melhores resultados para o mesmo

nu´mero de elementos, deve-se utilizar a malha quadr´atica, mas em certas circunstaˆncias a

´

malha linear podera´ ser a melhor op¸c˜ao. E portanto necess´ario encontrar sempre um balan¸co

entre o nu´mero e tipo de elementos e a precisa˜o que se pretende dos resultados para cada

caso em concreto, porque nem sempre se optam pelos fatores da mesma forma.

Outro aspeto a analisar ´e a convergˆecia do meshpoint2, dado que demora mais tempo

para convergir do que qualquer outro ponto de entre os escolhidos. Isso deve-se ao facto de se

apresentar numa zona onde ir˜ao existir elevadas variac¸˜oes de temperatura, pois a temperatura

da parede do entalhe inferior ´e bastante elevada, afetando assim a convergˆencia desse ponto.

• Convergˆencia do ﬂuxo

Apresentam-se tamb´em os gra´ﬁcos da convergˆencia do ﬂuxo para cada um dos n´os, onde

esta˜o representados simultaneamente os resultados para malhas do tipo QUAD-4 e QUAD-8.

Figura 13: Convergˆencia do 1º No´

Figura 14: Convergˆencia do 2º No´

16





Projeto de Mecaˆnica Computacional

Figura 15: Convergˆencia do 3º No´

Figura 16: Convergˆencia do 4º No´

Figura 17: Convergˆencia do 5º No´

Figura 18: Convergˆencia do 6º No´

Analisando novamente os gra´ﬁcos obtidos, conclui-se que existe convergˆencia para ambas

as malhas, a n´ıvel de ﬂuxo. Ainda que n˜ao seja t˜ao evidente como no caso da convergˆencia

da temperatura, continua a haver uma convergˆencia mais r´apida das malhas quadra´ticas.

Como os n´os sa˜o pontos de descontinuidade, o c´alculo do ﬂuxo no NX ´e feito atrav´es de

uma m´edia aproximada. Este pode ser o motivo para eventuais erros no c´alculo do ﬂuxo.

Para al´em disso, ´e de notar a ocorrˆencia de uma elevada discrepˆancia de valores entre o

ponto para onde a malha quadra´tica converge e o ponto para onde a malha linear converge.

Uma explica¸ca˜o para este acontecimento pode ser o facto de que para elementos quadra´ticos

ha´ o dobro do nu´mero de no´s por elemento, pelo que o erro que o software comercial faz ao

calcular os ﬂuxos leva a uma diferen¸ca nos resultados obtidos.

4.2 Reﬁnamento da malha

Nesta sec¸c˜ao sa˜o apresentados os gr´aﬁcos obtidos para a distribui¸ca˜o de temperaturas

e ﬂuxo de calor apo´s 5 reﬁnamentos em NX, de onde se obtiveram 156412 elementos, para

malhas lineares e quadra´ticas.

Os gra´ﬁcos relativos ao gradiente de temp[eratura,(47)](#br29)[ ](#br29)e [(48)](#br29)[ ](#br29), podem ser consultados no

anexo.

17





Projeto de Mecaˆnica Computacional

4.2.1 Malha de QUAD-4

Figura 19: Temperatura nodal [ºC] -

QUAD-4

Figura 20: Fluxo de calor [W/m2] -

QUAD-4

4.2.2 Malha de QUAD-8

Figura 21: Temperatura nodal [ºC] -

QUAD-8

Figura 22: Fluxo de calor [W/m2] -

QUAD-8

Por observa¸ca˜o dos gr´aﬁcos relativos aos resultados em NX, tanto para o caso QUAD-4

como para QUAD-8, pode-se concluir que a distribui¸c˜ao de temperatura nodal vai de encontro

ao que se esperava, visto que a temperatura no entalhe inferior ´e muito superior `a da restante

placa, devido ao constrangimento que lhe ´e aplicado. Tamb´em pelos constrangimentos dados,

´e expect´avel que a temperatura na parede interior seja sempre superior a` da exterior, algo

que se veriﬁca.

Pode-se tamb´em concluir que o gradiente de temperatura ´e maior na regia˜o da placa em

que se veriﬁca uma maior varia¸ca˜o de temperaturas (ponto inferior direito), pelo que tamb´em

o ﬂuxo sera´ maior nessa regia˜o.

Este resultado ´e apoiado pelas considera¸co˜es te´oricas apresentadas em secc¸˜oes anteriores

do relat´orio, uma vez que o gradiente e o ﬂuxo se relacionam pela Lei de Fourier dada por:

q(x, y) = −∇ . (k∇u)

(46)

18





Projeto de Mecaˆnica Computacional

Ainda sobre o ﬂuxo, veriﬁca-se tamb´em por observac¸˜ao da ﬁgura [(22),](#br22)[ ](#br22)que ´e maior nas

regio˜es da placa com condutividade t´ermica superior, um resultado mais uma vez conﬁrmado

pela lei enunciada, uma vez que quanto maior for k, maior sera´ o ﬂuxo, q.

Para uma melhor leitura dos valores presentes nos gra´ﬁcos, sugere-se a consulta do anexo

e as ﬁguras [(49),](#br30)[ ](#br30)[(50),](#br30)[ ](#br30)[(51)](#br30)[ ](#br30)e [(52).](#br30)

5 Compara¸c˜ao de Resultados entre MATLAB e NX

Nesta sec¸ca˜o comparam-se os gr´aﬁcos obtidos nas 2 abordagens utilizadas para a resolu¸ca˜o

deste problema, de forma a que se possam tirar conclus˜oes quanto ao grau de precis˜ao do

M´etodo de Elementos Finitos desenvolvido em MATLAB.

5.1 Malha de QUAD-4

Figura 23: Distribuic¸˜ao de temper-

atura em NX

Figura 24: Distribui¸ca˜o de temperatura

em MATLAB

Figura 25: Fluxo de calor em NX

Figura 26: Fluxo de calor em MATLAB

19





Projeto de Mecaˆnica Computacional

Figura 27: Gradiente de temperatura

em NX

Figura 28: Gradiente de temperatura em

MATLAB

5.2 Malha de QUAD-8

Figura 29: Distribuic¸˜ao de temper-

atura em NX

Figura 30: Distribui¸ca˜o de temperatura

em MATLAB

Figura 31: Fluxo de calor em NX

Figura 32: Fluxo de calor em MATLAB

20





Projeto de Mecaˆnica Computacional

Figura 33: Gradiente de temperatura

em NX

Figura 34: Gradiente de temperatura em

MATLAB

5.3 Interpreta¸c˜ao dos resultados

Comparando os gra´ﬁcos obtidos em NX com os de MATLAB, pode-se veriﬁcar que, tanto

para QUAD-4 como para QUAD-8 se obtiveram solu¸c˜oes semelhantes, uma vez que a dis-

triui¸ca˜o de temperaturas ´e idˆentica para ambos os casos, bem como a dire¸ca˜o dos vetores de

ﬂuxo e de gradiente.

Nos gra´ﬁcos que se seguem apresentam-se os desvios relativos entre os resultados obtidos

na simula¸ca˜o em NX e no programa desenvolvido em Matlab, para os valores da temperatura,

ﬂuxo e gradiente de temperatura, que completam esta interpreta¸ca˜o. No anexo ´e poss´ıvel

visualizar melhor os dados dos gra´ﬁcos.

• Malha de QUAD-4

Figura 35: Desvio relativo entre o pro-

grama desenvolvido em MATLAB e a sim-

ula¸ca˜o em NX para valores da temperatura

Figura 36: Desvio relativo entre o pro-

grama desenvolvido em MATLAB e a sim-

ula¸ca˜o em NX para valores de ﬂuxo

Como ´e poss´ıvel observar pelos gra´ﬁcos apresentados, a maioria dos no´s apresenta um

erro relativo do MATLAB em relac¸˜ao ao NX pr´oximo de 0, ainda que haja casos em que

este erro tem valores considera´veis. Isto permite-nos novamente concluir que os resultados

21





Projeto de Mecaˆnica Computacional

obtidos em NX e em MATLAB foram bastante semelhantes, pelo que se valida o programa

desenvolvido.

• Malha de QUAD-8

Figura 37: Desvio relativo entre o pro-

grama desenvolvido em MATLAB e a sim-

ula¸ca˜o em NX para valores da temperatura

Figura 38: Desvio relativo entre o pro-

grama desenvolvido em MATLAB e a sim-

ula¸ca˜o em NX para valores de ﬂuxo

Mais uma vez, veriﬁca-se que o erro relativo do MATLAB em rela¸ca˜o ao NX ´e pr´oximo

de 0 tanto para a temperatura como para o ﬂuxo.

Posto isto, ao comparar os erros relativos obtidos na malha linear e na quadra´tica, ´e

poss´ıvel analisar que os erros relativos s˜ao inferiores para a malha quadr´atica, tanto para a

temperatura como para o ﬂuxo. Estes resultados podem indicar que o programa do MATLAB

para a malha quadr´atica pode ter sido mais eﬁciente do que para a malha linear.

´

E de frisar que para elementros quadr´aticos, o programa em MATLAB calcula o ﬂuxo

em 4 pontos diferentes do elemento, sendo depois feita uma m´edia entre eles para comparar

com os valores do NX.

6 Determina¸c˜ao da Potˆencia Calor´ıﬁca

A potˆencia calor´ıﬁca total que atrevesa a fronteira ´e dada pelo integral do ﬂuxo ao longo

da superf´ıcie de fronteira. Uma vez que a espessura da placa em an´alise neste projeto ´e

unita´ria, basta integrar o ﬂuxo ao longo da linha de fronteira vertical, como ´e dado pela

equa¸ca˜o [47:](#br26)

Z

P = q dy

Γ

(47)

Este integral pode ser aproximado ao somat´orio da potˆencia calor´ıﬁca em cada elemento

que constitui a fronteira. Por sua vez, esta potˆencia ´e obtida ao multiplicar o ﬂuxo no

determinado elemento pela sua altura, como podemos veriﬁcar pela equac¸˜ao [48:](#br26)

Xn

e

e

2

e

1

P =

q |y − y |

(48)

e=1

Os resultados obtidos encontram-se sumarizados na tabela que se segue:

22





Projeto de Mecaˆnica Computacional

Figura 39: Potˆencia calor´ıﬁca em cada elemento da fronteira e total (W)

7 Concluso˜es

A an´alise de convergˆencia permitiu-nos concluir que, para o mesmo tipo de malha, o

nu´mero de elementos inﬂuencia a precis˜ao dos resultados obtidos. Veriﬁcou-se ainda que

elementos de ordem superior convergem mais r´apido do que elementos lineares, sendo a

utiliza¸c˜ao de elementos quadr´aticos mais vantajosa para que a solu¸ca˜o convirja com menos

etapas de reﬁnamento. No entanto, h´a que ter em conta que a utiliza¸ca˜o destes elementos

implica maiores custos computacionais, o que nem sempre ´e deseja´vel.

Relativamente aos resultados obtidos nas simula¸c˜oes em NX e no programa de MATLAB e

tendo em conta os respetivos erros relativos j ´a apresentados anteriormente, podemos concluir

que os resultados obtidos no programa desenvolvido s˜ao uma boa aproxima¸ca˜o dos resultados

extra´ıdos do programa de elementos ﬁnitos, o que era de certa forma expect´avel, uma vez que

no desenvovlvimento do programa em MATLAB se aplicou a teoria que rege os problemas

de condu¸c˜ao de calor.

Apesar de o erro entre estas abordagens ter sido baixo, o erro entre a solu¸ca˜o anal´ıtica

do problema simples e a solu¸c˜ao computacional do MATLAB foi superior ao esperado, o

que pode indicar que houve algumas aproxima¸co˜es a n´ıvel computacional que podem ter

contribu´ıdo para essa discrepaˆncia de valores.

23





Projeto de Mecaˆnica Computacional

8 Anexo

Figura 40: Fluxograma do problema desenvolvido

Figura 41: Malha de elementos QUAD-4

para problema simples

Figura 42: Malha de elementos QUAD-8

para problema simples

24





Projeto de Mecaˆnica Computacional

Figura 43: Gradiente de temperatura para

problema simples [ºC/mm] QUAD-4

Figura 44: Gradiente de temperatura para

problema simples [ºC/mm] QUAD-8

Figura 45: Fluxo de calor para problema

simples [W/m2] QUAD-4

Figura 46: Fluxo de calor para problema

simples [W/m2] QUAD-8

Figura 47: Gradiente de temperatura

[ºC/mm] - QUAD-4 - Siemens NX

Figura 48: Gradiente de temperatura

[ºC/mm] - QUAD-8 - Siemens NX

25





Projeto de Mecaˆnica Computacional

Figura 49: Temperatura nodal [ºC] -

QUAD-4 - Siemens NX

Figura 50: Fluxo de calor [W/m2] -

QUAD-4 - Siemens NX

Figura 51: Temperatura nodal [ºC] -

QUAD-8 - Siemens NX

Figura 52: Fluxo de calor [W/m2] -

QUAD-8 - Siemens NX

26





Projeto de Mecaˆnica Computacional

Figura 53: Desvio relativo entre o programa desenvolvido em MATLAB e a simula¸c˜ao em

NX para valores da temperatura

Figura 54: Desvio relativo entre o programa desenvolvido em MATLAB e a simula¸c˜ao em

NX para valores de ﬂuxo

27





Projeto de Mecaˆnica Computacional

Figura 55: Desvio relativo entre o programa desenvolvido em MATLAB e a simula¸c˜ao em

NX para valores da temperatura

Figura 56: Desvio relativo entre o programa desenvolvido em MATLAB e a simula¸c˜ao em

NX para valores de ﬂuxo

28





Projeto de Mecaˆnica Computacional

9 Referˆencias

[1] J. N. Reddy, An Introduction to the Finite Element Method, 3rd ed., McGraw-Hill

Education (2005)

29

