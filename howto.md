# HOWTO - Execução dos Exercícios 21.1 e 21.2

## Requisitos

- SWI-Prolog instalado  
ou  
- SWISH online


## Exercício 21.1

Abra o arquivo:

```text
21_1.pl
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
