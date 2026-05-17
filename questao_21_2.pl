questao_21_2(Steps, HipoteseFinal):-

    % Passo 0: hipótese inicial
    _H0 = [
        [predecessor(A,B)]/[A,B],
        [predecessor(D,E)]/[D,E]
    ],

    % 1: adiciona atom(A), parent(A,C) na primeira cláusula
    _H1 = [
        [predecessor(A,B), [atom(A), parent(A,C)]]/[A,B,A,C],
        [predecessor(D,E)]/[D,E]
    ],

    % 2: remove variável repetida A
    _H2 = [
        [predecessor(A,B), [atom(A), parent(A,C)]]/[A,B,C],
        [predecessor(D,E)]/[D,E]
    ],

    % 3: adiciona atom(C), predecessor(C,B)
    _H3 = [
        [predecessor(A,B), [atom(A), parent(A,C)], [atom(C), predecessor(C,B)]]/[A,B,C,C,B],
        [predecessor(D,E)]/[D,E]
    ],

    % 4: remove variável repetida C
    _H4 = [
        [predecessor(A,B), [atom(A), parent(A,C)], [atom(C), predecessor(C,B)]]/[A,B,C,B],
        [predecessor(D,E)]/[D,E]
    ],

    % 5: remove variável repetida B
    _H5 = [
        [predecessor(A,B), [atom(A), parent(A,C)], [atom(C), predecessor(C,B)]]/[A,B,C],
        [predecessor(D,E)]/[D,E]
    ],

    % 6: adiciona atom(D), parent(D,E) na segunda cláusula
    _H6 = [
        [predecessor(A,B), [atom(A), parent(A,C)], [atom(C), predecessor(C,B)]]/[A,B,C],
        [predecessor(D,E), [atom(D), parent(D,E)]]/[D,E,D,E]
    ],

    % 7: remove variável repetida D
    _H7 = [
        [predecessor(A,B), [atom(A), parent(A,C)], [atom(C), predecessor(C,B)]]/[A,B,C],
        [predecessor(D,E), [atom(D), parent(D,E)]]/[D,E,E]
    ],

    % 8: remove variável repetida E
    H8 = [
        [predecessor(A,B), [atom(A), parent(A,C)], [atom(C), predecessor(C,B)]]/[A,B,C],
        [predecessor(D,E), [atom(D), parent(D,E)]]/[D,E]
    ],

    Steps = 8,
    HipoteseFinal = H8.
