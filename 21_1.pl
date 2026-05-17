%———————————————————————————————————————————————
% MINIHYPER - Learning predecessor/2
%
%———————————————————————————————————————————————

% prove(Goal, Hypo, Answer)

prove(Goal, Hypo, Answer):-
    max_proof_length(D),
    prove(Goal, Hypo, D, RestD),
    ( RestD >= 0 ->
        Answer = yes
    ;
        Answer = maybe
    ), !.

prove(_, _, no).


%———————————————————————————————————————————————
% prove(Goal, Hypo, MaxDepth, RestDepth)

prove(_, _, D, D):-
    D < 0, !.

prove([], _, D, D):- !.

prove([G1|Gs], Hypo, D0, D):-
    prove(G1, Hypo, D0, D1),
    prove(Gs, Hypo, D1, D).


%———————————————————————————————————————————————
% Conhecimento de fundo executado diretamente

prove(parent(X,Y), _, D, D):-
    parent(X,Y), !.


%———————————————————————————————————————————————
% Uso das hipóteses

prove(G, Hypo, D0, D):-
    ( D0 =< 0 ->
        !,
        D is D0 - 1
    ;
        D1 is D0 - 1,
        member(Clause/_, Hypo),
        copy_term(Clause, [Head|Body]),
        G = Head,
        prove(Body, Hypo, D1, D)
    ).


%———————————————————————————————————————————————
% Processo de indução

induce(Hyp):-
    iter_deep(Hyp, 0).

iter_deep(Hyp, MaxD):-
    write('MaxD = '),
    write(MaxD),
    nl,

    start_hyp(Hyp0),

    complete(Hyp0),

    depth_first(Hyp0, Hyp, MaxD)

    ;

    NewMaxD is MaxD + 1,
    iter_deep(Hyp, NewMaxD).


%———————————————————————————————————————————————
% Busca em profundidade

depth_first(Hyp, Hyp, _):-
    consistent(Hyp).

depth_first(Hyp0, Hyp, MaxD0):-
    MaxD0 > 0,

    MaxD1 is MaxD0 - 1,

    refine_hyp(Hyp0, Hyp1),

    complete(Hyp1),

    depth_first(Hyp1, Hyp, MaxD1).


%———————————————————————————————————————————————
% Completeza

complete(Hyp):-
    \+ (
        ex(E),
        once(prove(E, Hyp, Answer)),
        Answer \== yes
    ).


%———————————————————————————————————————————————
% Consistência

consistent(Hyp):-
    \+ (
        nex(E),
        once(prove(E, Hyp, Answer)),
        Answer \== no
    ).


%———————————————————————————————————————————————
% Refinamento

refine_hyp(Hyp0, Hyp):-

    conc(Clauses1, [Clause0/Vars0 | Clauses2], Hyp0),

    conc(Clauses1, [Clause/Vars | Clauses2], Hyp),

    refine(Clause0, Vars0, Clause, Vars).


% Remove variável repetida

refine(Clause, Args, Clause, NewArgs):-

    conc(Args1, [A | Args2], Args),

    member(A, Args2),

    conc(Args1, Args2, NewArgs).


% Adiciona literal ao corpo

refine(Clause, Args, NewClause, NewArgs):-

    length(Clause, L),

    max_clause_length(MaxL),

    L < MaxL,

    backliteral(Lit, Vars),

    conc(Clause, [Lit], NewClause),

    conc(Args, Vars, NewArgs).


%———————————————————————————————————————————————
% Configurações

max_proof_length(10).

max_clause_length(3).


%———————————————————————————————————————————————
% Concatenação

conc([], L, L).

conc([X|T], L, [X|L1]):-
    conc(T, L, L1).


%———————————————————————————————————————————————
% Exemplos positivos

ex(predecessor(pam,bob)).
ex(predecessor(pam,jim)).
ex(predecessor(tom,ann)).
ex(predecessor(tom,jim)).
ex(predecessor(tom,liz)).


%———————————————————————————————————————————————
% Exemplos negativos

nex(predecessor(liz,bob)).
nex(predecessor(pat,bob)).
nex(predecessor(pam,liz)).
nex(predecessor(liz,jim)).
nex(predecessor(liz,liz)).


%———————————————————————————————————————————————
% Hipótese inicial

start_hyp([

    [predecessor(X1,Y1)]/[X1,Y1],

    [predecessor(X2,Y2)]/[X2,Y2]

]).


%———————————————————————————————————————————————
% Conhecimento de fundo

parent(pam,bob).

parent(tom,bob).

parent(tom,liz).

parent(bob,ann).

parent(bob,pat).

parent(pat,jim).


%———————————————————————————————————————————————
% Literais permitidos no corpo das regras

backliteral(parent(X,Y), [X,Y]).

backliteral(predecessor(X,Y), [X,Y]).
