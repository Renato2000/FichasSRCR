%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Programacao em logica estendida
% Representacao de conhecimento imperfeito

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Definicoes iniciais

:- op( 900,xfy,'::' ).
:- dynamic jogo/3.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado jogo: Jogo,Arbitro,Ajudas -> {V,F,D}

-jogo( Jogo,Arbitro,Ajudas ) :-
    nao( jogo( Jogo,Arbitro,Ajudas ) ),
    nao( excecao( jogo( Jogo,Arbitro,Ajudas ) ) ).

jogo( 1,aa,500 ).

% exemplo de conhecimento incerto
jogo( 2,bb,desconhecido ).
excecao( jogo( Jogo,Arbitro,Ajudas ) ) :-
    jogo( Jogo,Arbitro,desconhecido ).

% exemplo de conhecimento impreciso
excecao( jogo( 3,cc,500 ) ).
excecao( jogo( 3,cc,2500 ) ).

excecao( jogo( 4,dd,Ajudas ) ) :- Ajudas >= 250, Ajudas =< 750.

%exemplo de conhecimento intedito
jogo( 5,ee,xpto765 ).
excecao( jogo( Jogo,Arbitro,Ajudas ) ) :-
    jogo( Jogo,Arbitro,xpto765 ).
nulo(xpto765).
+jogo( Jogo,Arbitro,Ajudas ) :: (solucoes( Ajudas,( jogo( Jogo,Arbitro,Ajudas ), nao( nulo( Jogo,Arbitro,Ajudas ) ) ),S ),
    comprimento( S,N ),
    N==0).

jogo( 6,ff,250 ).
excecao( jogo( 6,ff,Ajudas ) ) :- Ajudas >= 5000.

-jogo( 7,gg,2500 ).
jogo( 7,gg,desconhecido ).
%excecao( jogo( Jogo,Arbitro,Ajudas ) ) :- jogo( Jogo,Arbitro,desconhecido ).

excecao( jogo( 8,hh,Ajudas ) ) :- cerca(1000,Csup,Cinf), Ajudas >= Cinf, Ajudas =< Csup.
cerca( X,Csup,Cinf ) :- Csup is X*1.25, Cinf is X*0.75. 

excecao(jogo(9,ii,Ajudas)) :- mproximo(3000,Csup,Cinf),
    Ajudas >= Cinf, Ajudas=< Csup.
mproximo( X,Sup,Inf ) :- Sup is X*1.1, Inf is X*0.9.

% invariante estrutural: não permitir a inserção de conhecimento repetido
+jogo( J,A,C ) :: (
    solucoes(J,jogo(J,Arbitro,Ajuda),X),
    comprimento(X,N),
    N =< 1
    ).

% invariante estrutural: um arbitro não pode arbitrar mais do que três jogos
+jogo( J,A,C ) :: (
    solucoes(A,jogo(Jogo,A,Ajuda),X),
    comprimento(X,N),
    N =< 1
    ).

% invariante estrutural: um arbitro não pode arbitrar duas partidas consecutivas


%--------------------------------- - - - - - - - - - -  -  -  -  -   -

evolucao( Termo ) :-
    solucoes( Invariante,+Termo::Invariante,Lista ),
    insercao( Termo ),
    teste( Lista ).

insercao( Termo ) :-
    assert( Termo ).
insercao( Termo ) :-
    retract( Termo ),!,fail.

teste( [] ).
teste( [R|LR] ) :-
    R,
    teste( LR ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado que permite a involucao do conhecimento

involucao( Termo ) :-
    solucoes( Invariante,-Termo::Invariante,Lista ),
    remocao( Termo ),
    teste( Lista ).

remocao( Termo ) :-
    retract( Termo ).
remocao( Termo ) :-
    assert( Termo ),!,fail.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado demo: Questao,Resposta -> {V,F}
%                            Resposta = { verdadeiro,falso,desconhecido }

demo( Questao,verdadeiro ) :-
    Questao.
demo( Questao,falso ) :-
    -Questao.
demo( Questao,desconhecido ) :-
    nao( Questao ),
    nao( -Questao ).



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}

nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

solucoes( X,Y,Z ) :-
    findall( X,Y,Z ).

comprimento( S,N ) :-
    length( S,N ).

