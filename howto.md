# HOWTO - Execução dos Exercícios 21.1 e 21.2

## Requisitos

- SWI-Prolog instalado  
ou  
- SWISH online


## Exercício 21.1

Abra o arquivo:

```text
questao_21_1.pl
```

Execute:

```prolog
?- induce(Hyp).
```

Resultado obtido:

```prolog
Hyp = [
    [predecessor(_A,_B), parent(_A,_B)]/[_A,_B],
    [predecessor(_C,_D), parent(_E,_D), predecessor(_C,_E)]/[_D,_C,_E]
].
```


# Exercício 21.2

Abra o arquivo:

```text
questao_21_2.pl
```

Execute:

```prolog
?- questao_21_2(Steps, H).
```

Resultado obtido:

```prolog
H = [
    [predecessor(_A,_B),
     [atom(_A), parent(_A,_C)],
     [atom(_C), predecessor(_C,_B)]]/[_A,_B,_C],

    [predecessor(_D,_E),
     [atom(_D), parent(_D,_E)]]/[_D,_E]
],

Steps = 8.
```

A hipótese aprendida representa:

```prolog
predecessor(A,B) :-
    atom(A),
    parent(A,C),
    atom(C),
    predecessor(C,B).

predecessor(D,E) :-
    atom(D),
    parent(D,E).
```

Portanto, o exercício conclui que são necessários
**8 passos de refinamento**
para obter a hipótese alvo a partir da hipótese inicial.
