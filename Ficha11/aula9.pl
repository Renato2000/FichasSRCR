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

/*
estima(a, 5).
estima(b, 4).
estima(c, 4).
estima(d, 3).
estima(e, 7).
estima(f, 4).
estima(g, 2).
estima(s, 10).
*/

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