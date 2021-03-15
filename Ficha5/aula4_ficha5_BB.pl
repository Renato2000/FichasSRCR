%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Invariantes

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

:-consult('../Ficha1/sem02.prolog.BB.pl').


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% PROLOG: definicoes iniciais

:- op( 900,xfy,'::' ).
:- dynamic filho/2.
:- dynamic pai/2.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado filho: Filho,Pai -> {V,F,D}

filho( joao,jose ).
filho( jose,manuel ).
filho( carlos,jose ).

% Invariante Estrutural:  nao permitir a insercao de conhecimento
%                         repetido

+filho( F,P ) :: (solucoes( (F,P),(filho( F,P )),S ),
                  comprimento( S,N ), 
				  N == 1
                  ).

+pai( P,F ) :: (solucoes( (P,F),(filho( F,P )),S ),
                  comprimento( S,N ), 
                  N == 1
                  ).

+neto( N,A ) :: (solucoes( (N,A),(neto( N,A )),S ),
                  comprimento( S,T ), 
                  T == 1
                  ).

+avo( A,N ) :: (solucoes( (A,N),(avo( A,N )),S ),
                  comprimento( S,T ), 
                  T == 1
                  ).

+descendente( D,A ) :: (solucoes( (D,A),(descendente( D,A )),S ),
                  comprimento( S,N ), 
                  N == 1
                  ).

% Invariante Referencial: nao admitir mais do que 2 progenitores
%                         para um mesmo individuo

+filho( F,P ) :: ( findall( Ps,filho( F,Ps ),S ),
                  length( S,N ),
                  N =< 2
                  ).

% Invariante Referencial: nao admitir mais do que 4 individuos identificados como avó
%                         para um mesmo individuo

+avo( A,N ) :: ( findall( As,avo( As,N ),S ),
                  length( S,N ),
                  N =< 4
                  ).

+neto( N,A ) :: ( findall( As,nato( N,As ),S ),
                length( S,N ),
                N =< 4
                ).

% Invariante Referencial: A identificação do grau de descendência na relação descendente/3 
%                          deverá pertencer ao conjunto dos números naturais

+descendente( D,A ) :: (descendente( D,A,N ),
                N mod 2 =:= 0
                ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que permite a evolucao do conhecimento

evolucao( Termo ) :-
    findall( Invariante,+Termo::Invariante,Lista ),
    insercao( Termo ),
    teste( Lista ).

insercao(Termo) :- assert(Term).
insercao(Termo) :- retract(Term),!,fail.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que permite a involucao do conhecimento

involucao( Termo ) :-
    findall( Invariante,+Termo::Invariante,Lista ),
    remocao( Termo ),
    teste( Lista ).

remocao(Termo) :- retract(Term).
remocao(Termo) :- assert(Term),!,fail.
