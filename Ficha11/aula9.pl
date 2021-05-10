%-------------------------------------------------------------------------

/*
    O problema em questão é do tipo "problema do estado único", já que o 
ambiente é determinístico e totalmente observável.
*/

%-------------------------------------------------------------------------

aresta(a, b, 2).
aresta(b, c, 2).
aresta(c, d, 3).
aresta(d, t, 3).
aresta(t, g, 2).
aresta(g, f, 2).
aresta(f, e, 5).
aresta(e, s, 2).
aresta(s, a, 2).

estima(a, 5).
estima(b, 4).
estima(c, 4).
estima(d, 3).
estima(e, 7).
estima(f, 4).
estima(g, 2).
estima(s, 10).

adjacente(X, Y, C) :- aresta(X, Y, C).
adjacente(X, Y, C) :- aresta(Y, X, C).

%-------------------------------------------------------------------------

resolvedf(Inicio, Destino, Solucao, Custo) :-
    resolvedf(Inicio, Destino, [Inicio], Solucao, Custo).

resolvedf(Inicio, Destino, _, [Destino], 0) :-
    Inicio == Destino, !.

resolvedf(Inicio, Destino, Historico, [Inicio | Solucao], Custo) :- 
    adjacente(Inicio, Next, C), 
    nao(membro(Next, Historico)),
    resolvedf(Next, Destino, [Next | Historico], Solucao, NovoCusto),
    Custo is NovoCusto + C.

%-------------------------------------------------------------------------

melhorCaminho(Inicio, Destino, Solucao, Custo) :-
    findall((Solucao, Custo), resolvedf(Inicio, Destino, Solucao, Custo), List),
    menor(List, (Solucao, Custo)).

%-------------------------------------------------------------------------

menor([(P,X)], (P,X)).
menor([(_,X)|L], (Py,Y)) :- menor(L, (Py,Y)), Y < X.
menor([(P,X)|L], (P,X)) :- menor(L, (_,Y)), Y >= X.

nao( Questao ) :-
    Questao, !, fail.
nao( _ ).

membro(X, [X|_]).
membro(X, [_|Xs]):-
	membro(X, Xs).

inverso(L,R) :- inverso(L,R,[]).
inverso([],Z,Z).
inverso([H|T],Z,Acc) :- inverso(T,Z,[H|Acc]).

%-------------------------------------------------------------------------

% A pesquisa gulosa vai, em cada instante, gerar todos os caminhos possíveis a partir desse nó, e escolhe o que tiver a menor estimativa (apenas a estimativa).
% O algoritmo A* é uma optimização do anterior, onde tem em conta a estimativa e o custo, escolhendo o que tiver a menor soma dos dois (custo mais estimativa).

%---Utilizando pesquisa gulosa---

goal(t).

resolve_gulosa(Nodo, Caminho/Custo) :-
    estima(Nodo, Estima),
    agulosa([[Nodo]/0/Estima], InvCaminho/Custo/_),
    inverso(InvCaminho, Caminho).

agulosa(Caminhos, Caminho) :-
    obtem_melhor_g(Caminhos, Caminho),
    Caminho = [Nodo|_]/_/_,goal(Nodo).

agulosa(Caminhos, SolucaoCaminho) :- 
    obtem_melhor_g(Caminhos, MelhorCaminho),
    seleciona(MelhorCaminho, Caminhos, OutrosCaminhos),
    expande_gulosa(MelhorCaminho, ExpCaminhos),
    append(OutrosCaminhos, ExpCaminhos, NovoCaminhos),
    agulosa(NovoCaminhos, SolucaoCaminho).

obtem_melhor_g([Caminho], Caminho) :- !.

obtem_melhor_g([Caminho/Custo1/Est1,_/Custo2/Est2|Caminhos],MelhorCaminho) :-
    Est1 =< Est2, !, % Custo1 + Est1 =< Custo2 + Est2, !. -> Para o A*
    obtem_melhor_g([Caminho1/Custo1/Est1|Caminhos], MelhorCaminho).

obtem_melhor_g([_|Caminhos], MelhorCaminho) :-
    obtem_melhor_g(Caminhos, MelhorCaminho).

expande_gulosa(Caminho, ExpCaminhos) :-
    findall(NovoCaminho, adjacente3(Caminho,NovoCaminho), ExpCaminhos).

adjacente3([Nodo|Caminho]/Custo/_, [ProxNodo,Nodo|Caminho]/NovoCusto/Est) :-
    aresta(Nodo,ProxNodo,PassoCusto), \+ member(ProxNodo,Caminho),
    NovoCusto is Custo + PassoCusto,
    estima(ProxNodo,Est).

seleciona(E, [E,Xs], Xs).
seleciona(E, [X,Xs], [X,Ys]) :- seleciona(E,Xs,Ys).

%---Utilizando pesquisa A*---