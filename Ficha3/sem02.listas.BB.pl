%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Operacoes sobre listas.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado pertence: Elemento,Lista -> {V,F}

pertence( X,[X|L] ).
pertence( X,[Y|L] ) :-
    X \= Y,
    pertence( X,L ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado comprimento: Lista,Comprimento -> {V,F}

comprimento( [],0 ).
comprimento( [X|L],N ) :-
    comprimento( L,N1 ),
    N is N1+1.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado quantos: Lista,Comprimento -> {V,F}

nao( Questao ) :- Questao, !, fail.
nao( Questao ).

quantos( [],0 ).
quantos( [H|T],Res ) :- 
	pertence( X,L ),
	quantos( L,N ).
quantos( [X|L],N1 ) :-
	nao( pertence( X,L ) ),
	quantos( L,N ),
	N1 is N+1.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado apagar: Elemento,Lista,Resultado -> {V,F}

apaga( X,[],Res ).
apaga( X,[H|T],T).
apaga( X,[H|T],[H|L] ) :-
	X \= H,
	apaga( X,T,L ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado apagatudo: Elemento,Lista,Resultado -> {V,F}

apagaTudo( X,[],Res ).
apagaTudo( X,[H|T],T) :- apagaTudo( X,T,T ).
apagaTudo( X,[H|T],[H|L] ) :-
	X \= H,
	apagaTudo( X,T,L ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado adicionar: Elemento,Lista,Resultado -> {V,F}

adicionar( X,[],[X] ).
adicionar( X,List,[X|List] ) :- não( pertence( X,List) ).
adicionar( X,List,List ) :- pertence( X,List).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado concatenar: Lista1,Lista2,Resultado -> {V,F}

concatenar( [],List,List ).
concatenar( [X|XS],List,[X|Res]) :- concatenar( XS,List,Res ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado inverter: Lista,Resultado -> {V,F}

inverter( [],[] ).
inverter( [H|T],Res ) :- 
	inverter( T,List ),
	concatenar( List,[H],Res ).

inverterAcc([],Res,Acc).
inverterAcc([H|T],Res,Acc) :- inverterAcc(T,Res,[H|Acc]).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado sublista: SubLista,Lista -> {V,F}

sufixo( S,L ) :- concatenar( _,S,L ).

prefixo( P,L ) :- concatenar( P,_,L ).

sublist( Sub,List ) :- sufixo( Sufix,List ), prefixo( Sub,Prefix ).



solucoes(X,Y,Z) :- findall(X, Y, Z).

