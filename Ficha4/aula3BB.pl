%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%--------------------------------- - - - - - - - - - -  -  -  -  -   -



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado par: N -> {V,F}

par( 0 ).
par( X ) :-
    N is X-2,
    N >= 0,
    par( N ).
	
%par(N):- N mod 2 =:= 0.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado impar: N -> {V,F}

impar( 1 ).
impar( X ) :-
    N is X-2,
    N >= 1,
    impar( N ).

%impar(N):- N mod 2 =:= 1.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}

nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).





divisores( N,X ) :- divisores( N,N,X ).

divisores( X,Y,[Y|L] ) :-
    Y > 0,
    X mod Y =:= 0,
    YY is Y-1,
    divisores( X,YY,L ).
divisores( X,Y,L ) :-
    Y > 0,
    X mod Y =\= 0,
    YY is Y-1,
    divisores( X,YY,L ).
divisores( X,1,[1] ).

% Outra versão (mais eficiente)

divisores2( X,L ) :- 
    XX is X//2,
    divisores2( X,XX,[1],L ).

divisores2( X,Y,[H|T],[H,L]) :-
    Y > 1,
    X mod Y =:= 0,
    YY is Y-1,
    divisores2( X,YY,[H|T],L ).
divisores2( X,Y,[H|T],L ) :-
    Y > 1,
    X mod Y =\= 0,
    YY is Y-1,
    divisores2( X,YY,[H|T],L ).

primo( X ) :- divisores2(X,L), length(L, 2).

mdc( X,X,X ).
mdc( X,Y,R ) :-
    X > Y,
    XX is X - Y,
    mdc(XX,Y,R).
mdc( X,Y,R ) :-
    Y > X,
    YY is Y - X,
    mdc(X,YY,R).


fib( 0,0 ).
fib( 1,1 ).
fib( N,F ) :-
    N > 1,
    N1 is N-1,
    fib( N1,F1 ),
    N2 is N-2,
    fib( N2,F2 ),
    F is F1 + F2.
