%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Programacao em logica estendida

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% PROLOG: definicoes iniciais

:- dynamic '-'/1.
:- dynamic mamifero/1.
:- dynamic morcego/1.



%--------------------------------- - - - - - - - - - -  -  -  -  -   -

voa( X ) :- ave( X ),nao( excecao( voa( X ) ) ).

-voa( tweety ).

-voa( X ) :- mamifero( X ).

-voa( X ) :- excecao( voa( X ) ).

voa( X ) :- excecao( -voa(  X ) ). 

excecao( voa( X ) ) :- avestruz( X ).
excecao( voa( X ) ) :- pinguin( X ).
excecao( -voa( X ) ) :- morcego( X ).

ave( pitigui ).
ave( X ) :- avestruz( X ).
ave( X ) :- canario( X ).
ave( X ) :- periquito( X ).
ave( X ) :- pinguim( X ).

avestruz( trux ).

pinguin( pingu ).

canario( piupiu ).

mamifero( silvestre ).
mamifero( X ) :- cao( X ).
mamifero( X ) :- gato( X ).
mamifero( X ) :- morcego( X ).

morcego( bateméne ).

cao( boby ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}

nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado si: Questao,Resposta -> {V,F}
%                            Resposta = { verdadeiro,falso,desconhecido }

si( Questao,verdadeiro ) :- Questao.
si( Questao,falso ) :- -Questao.
si( Questao,desconhecido ) :- nao( Questao ),nao(-Questao).