%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Operacoes aritmeticas e conjuntos (listas).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado soma: X,Y,Soma -> {V,F}

soma( X,Y,Soma ) :-
    Soma is X+Y.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado soma: X,Y,Z,Soma -> {V,F}

soma( X,Y,Z,Soma ) :-
	Soma is X+Y+Z.


soma( [],0 ).
soma( [X|L],Soma ) :- 
	soma( L,S ),
	Soma is X + S.

operacao( adicao,X,Y,Res ) :- Res is X+Y.
operacao( subtracao,X,Y,Res ) :- Res is X-Y.
operacao( multiplicacao,X,Y,Res ) :- Res is X*Y.
operacao( divisao,X,Y,Res ) :- Res is X/Y.

operacao( adicao,[],0 ).
operacao( adicao,[H|T],Res ) :- operacao( adicao,T,X ), Res is H+X.
operacao( multiplicacao,[],0 ).
operacao( multiplicacao,[H|T],Res ) :- operacao( multiplicacao,T,X ), Res is H*X.

maior( X,Y,X ) :- X >= Y.
maior( X,Y,Y ) :- X < Y. 

maior( X,Y,Z,X ) :- X >= Y, X >= Z.
maior( X,Y,Z,Y ) :- Y > X, Y > Z.
maior( X,Y,Z,Z ) :- Z > X, Z > Y.

accMax( [H|T],A,Max ) :- H >= A, accMax( T,H,Max ).
accMax( [H|T],A,Max ) :- H < A, accMax( T,A,Max ).
accMax( [],A,A ).
maior( [H|T],Max ) :- accMax( T,H,Max ).

menor( X,Y,X ) :- X < Y.
menor( X,Y,Y ) :- X >= Y. 

menor( X,Y,Z,X ) :- Y >= Y, Z >= X.
menor( X,Y,Z,Y ) :- Y < X, Y < Z.
menor( X,Y,Z,Z ) :- Z < X, Z < Y.

accMin( [H|T],A,Min ) :- A >= H, accMin( T,H,Min ).
accMin( [H|T],A,Min ) :- H > A, accMin( T,A,Min ).
accMin( [],A,A ).
menor( [H|T],Min ) :- accMin( T,H,Min ).

tamanho( [],0 ).
tamanho( [_|T],Res ) :- tamanho( T,X ), Res is 1+X.

media( Lista,Res ) :- 
	soma( Lista,Soma ),
    tamanho( Lista, Tamanho ),
    Tamanho > 0, 
    Res is Soma / Tamanho.

adiciona( X,[],[X] ).
adiciona( X,[H|T],[X,H|T] ).

menores( _,[],[] ).
menores( X,[H|T],Res ) :-
	H < X, 
	menores( X,T,Y ),
	adiciona( H,Y,Res ).
menores( X,[H|T],Res ) :-
	H >= X, 
	menores( X,T,Res ).

maiores( _,[],[] ).
maiores( X,[H|T],Res ) :-
	H >= X, 
	maiores( X,T,Y ),
	adiciona( H,Y,Res ).
maiores( X,[H|T],Res ) :-
	H < X, 
	maiores( X,T,Res ).

ordenaCrescente( [],[] ).
ordenaCrescente( [H|T],Res ) :-
	menores( H,T,Menores ),
	ordenaCrescente( Menores,X ),
	adiciona( H,[],List ),
	append( X,List,Aux ),
	maiores( H,T,Maiores ),
	ordenaCrescente( Maiores,Y ),
	append( Aux,Y,Res ).

ordenaDecrescente( [],[] ).
ordenaDecrescente( [H|T],Res ) :-
	maiores( H,T,Maiores ),
	ordenaDecrescente( Maiores,Y ),
	adiciona( H,[],List ),
	append( Y,List,Aux ),
	menores( H,T,Menores ),
	ordenaDecrescente( Menores,X ),
	append( Aux,X,Res ).

vaizos( [],0 ).
vazios( [[]|T],Res ) :- vazios( T,X), Res is X + 1.
vazios( [_|T],Res ) :- vazios( T,Res ). 

nao( Questao ) :- Questao, !, fail.
nao( Questao ).
