%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Programacao em logica 
% Resolução de problemas de pesquisa (Ficha 10)


%---------------------------------  dados do problema ---------

% estado inicial
inicial(jarros(0, 0)).

% estados finais
final(jarros(4, _)).
final(jarros(_, 4)).

% transições possíveis transicao: EixOpXEf

transicao(jarros(V1, V2), encher(1), jarros(8, V2)):- V1 < 8.

transicao(jarros(V1, V2), encher(2), jarros(V1, 5)):- V2 < 5.

transicao(jarros(V1, V2), vazio(1), jarros(0, V2)):- V1 > 0.

transicao(jarros(V1, V2), vazio(2), jarros(V1, 0)):- V2 > 0.

transicao(jarros(V1, V2), encher(1, 2), jarros(NV1, NV2)):- 
	V1 > 0,
	NV1 is max(V1 - 5 + V2, 0), 
	NV1 < V1, 
	NV2 is V2 + V1 - NV1.

transicao(jarros(V1, V2), encher(2, 1), jarros(NV1, NV2)):- 
	V2 > 0,
	NV2 is max(V2 - 8 + V1, 0), 
	NV2 < V2, 
	NV1 is V1 + V2 - NV2.

% Numa procura em profundidade constuma-se utilizar uma stack (quando a stack ficar vazia é porque percorremos o grafo todo), enquanto que numa pesquisa em largura, costuma-se usar uma queue
% Com a procura em largura, criamos uma spanning tree, que é uma arvore que representa o grafo sem ciclos -> utilizado por exemplo em switchs de redes

resolvedf(Solucao) :-
    inicial(InicialEstado),
    resolvedf(InicialEstado, [InicialEstado], Solucao). % a lista vai anular o efeito dos ciclos

resolvedf(Estado, _, []) :-
    final(Estado), !.

resolvedf(EstadoInicial, Historico, [Transicao | Solucao]) :- 
    transicao(EstadoInicial, Transicao, EstadoFinal),
    nao(membro(EstadoFinal, Historico)),
    resolvedf(EstadoFinal, [EstadoFinal | Historico], Solucao).

todos(L) :- findall((S,C), (resolvedf(S), length(S,C)), L).

melhor(S, Custo) :- findall((S,C), (resolvedf(S), length(S,C), L), minimo(L,(S,Custo)). 

minimo([(P,X)], (P,X)).
minimo([(P,X)|L], (Py,Y)) :- minimo(L, (Py,Y)), Y < X.
minimo([(P,X)|L], (Px,X)) :- minimo(L, (Px,X)), Y >= X.

% ------------------------------------------------------------------------------------

resolvebf(Solucao) :-
    inicial(EstadoInicial),
    resolvebf([(InicialEstado, []) | Xs]-Xs, [], Solucao).

resolvebf([(Estado, Vs) | _]-_,_,Rs) :-
    final(Estado), !, inverso(Vs, Rs).

resolvebf([(Estado, Vs) | Xs]-Ys, Historico, Solucao) :-
    membro(Estado, Historico), !,
    resolvebf(Xs-Ys, Historico, Solucao).

resolvebf([(Estado, Vs) | Xs]-Ys, Historico, Solucao) :-
    setof((Move, Estado1), transicao(Estado, Move, Estado1), Ls),
    actualizar(Ls, Vs, [Estado| Historico], Ys-Zs),
    resolvebf(Xs-Zs, [Estado|Historico], Solucao).

actualizar([], _, _, X-X).
actualizar([(_, Estado)|Ls], Vs, Historico, Xs-Ys) :-
    membro(Estado, Historico), !,
    actualizar(Ls, Vs, Historico, Xs-Ys).
actualizar([(Move, Estado)|Ls], Vs, Historico, [(Estado, [Move|Vs])]-Ys) :-
    actualizar(Ls, Vs, Historico, Xs-Ys).

% ------------------------------------------------------------------------------------

/*
resolve_bfs(NodeS, NodeD, Sol) :- 
    breadthfirst([[NodeS]], NodeD, Sol).

breadthfirst([Path,Paths], NodeD, Sol) :-
    extend(Path, NewPaths),
    concat(Paths,NewPaths, Paths1),
    breadthfirst()
*/


% ------------------------------------------------------------------------------------

nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).

membro(X, [X|_]).
membro(X, [_|Xs]):-
	membro(X, Xs).

escrever([]).
escrever([X|L]) :- write(X), nl, escrever(L).