%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Programacao em logica 
% Grafos (Ficha 9)

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Diferentes representacaoes de grafos (1- representar as arestas (não permite representar arestar isoladas), 2- lista de adjacencia, 3-clausula aresta)
%
%lista de adjacencias: [n(b,[c,g,h]), n(c,[b,d,f,h]), n(d,[c,f]), ...] %O primeiro argumento é o vertice de origem, e a lista corresponde a todos os vértices destino
%
%termo-grafo: grafo([b,c,d,f,g,h,k],[e(b,c),e(b,g),e(b,h), ...]) or
%            digrafo([r,s,t,u],[a(r,s),a(r,t),a(s,t), ...]) % para o caso de um grafo direcionado
%
%clausula-aresta: aresta(a,b)


%---------------------------------

g1( grafo([madrid, cordoba, braga, guimaraes, vilareal, viseu, lamego, coimbra, guarda],
  [aresta(madrid, corboda, a4, 400),
   aresta(braga, guimaraes,a11, 25),
   aresta(braga, vilareal, a11, 107),
   aresta(guimaraes, viseu, a24, 174),
   aresta(vilareal, lamego, a24, 37),
   aresta(viseu, lamego,a24, 61),
   aresta(viseu, coimbra, a25, 119),
   aresta(viseu,guarda, a25, 75)]
 )).

%--------------------------------- 
%alinea 1)

adjacente(X,Y,K,E, grafo(_,Es)) :- member(aresta(X,Y,K,E),Es).
adjacente(X,Y,K,E, grafo(_,Es)) :- member(aresta(Y,X,K,E),Es).

%--------------------------------- 
%alinea 2)

caminho(G,A,B,P) :- caminhoAux(G,A,[B],P).
caminhoAux(_,A,[A|P1],[A|P1]).
caminhoAux(G,A,[Y|P1],P) :- 
    adjacente(X,Y,_,_,G),
    nao(membro(X,[Y|P1])),
    caminhoAux(G,A,[X,Y|P1],P).

%caminho(G,A,B,[A,B]) :- adjacente(A,B,_,_,G).
%caminho(G,A,B,[A,R]) :- adjacente(A,C,_,_,G), caminho(G,C,B,R), nao(member(A,R)).

%--------------------------------- 
% alinea 3)

ciclo(G,A,P) :- 
    adjacente(B,A,_,_,G),
    caminho(G,A,B,P1),
    length(P1,L), L > 2,
    append(P1,[A],P). 

%--------------------------------- 
%alinea 4)

caminhoK(G,A,B,P,Km,Es) :- caminhoKAux(G,A,[B],P,Km,Es).
caminhoKAux(_,A,[A|P1],[A|P1],0,[]).
caminhoKAux(G,A,[Y|P1],P,Km,[E|ER]) :- 
    adjacente(X,Y,E,K,G),
    nao(membro(X,[Y|P1])),
    caminhoKAux(G,A,[X,Y|P1],P,KR,ER),
    Km is KR + K.

%--------------------------------- 
%alinea 5)

cicloK(G,A,P,K,[E|Ep1]) :- 
  adjacente(B,A,E,Km,G),
  caminhoK(G,A,B,P1,Kp1,Ep1),
  length(P1,L), L > 2,
  append(P1,[A],P),
  K is Km + Kp1. 

%--------------------------------- 
%alinea 6) encontrar todos os caminhos

encontraTodos(A,B,G,L) :- findall(P,caminho(G,A,B,P),L). 

%--------------------------------- 
%alinea 7) encontrar o menor caminho

menorK(A,B,G,P,Custo,Es) :- findall((P1,K,E),caminhoK(G,A,B,P1,K,E),L), minimo(L,(P,Custo,Es)).
minimo([(P,X,Es)|L],(P,X,Es)).
minimo([(Px,X,Es1)|L],(Py,Y,Es2)) :- minimo(L,(Py,Y,Es2)), X > Y. 
minimo([(Px,X,Es1)|L],(Px,X,Es2)) :- minimo(L,(PX,X,Es2)), X =< Y. 

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}

nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).

membro(X, [X|_]).
membro(X, [_|Xs]):-
	membro(X, Xs).