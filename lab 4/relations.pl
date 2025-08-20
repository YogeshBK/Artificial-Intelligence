% Facts
parent(john, mary).
parent(john, tom).
parent(susan, mary).
parent(susan, tom).
parent(mary, alice).
parent(mike, alice).

% Rules
child(X, Y) :- parent(Y, X).

sibling(X, Y) :-
    parent(Z, X),
    parent(Z, Y),
    X \= Y.

grandparent(X, Y) :-
    parent(X, Z),
    parent(Z, Y).