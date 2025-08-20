% ---------- Facts ----------
% Gender
male(john).
male(tom).
male(mike).
male(alex).

female(susan).
female(mary).
female(alice).
female(lisa).

% Parent-child relationships
parent(john, mary).
parent(susan, mary).
parent(john, tom).
parent(susan, tom).
parent(mary, alice).
parent(mike, alice).
parent(tom, alex).
parent(lisa, alex).

% ---------- Rules ----------
% X is a father of Y if X is male and parent of Y
father(X, Y) :-
    male(X),
    parent(X, Y).

% X is a mother of Y if X is female and parent of Y
mother(X, Y) :-
    female(X),
    parent(X, Y).

% X is a child of Y if Y is a parent of X
child(X, Y) :-
    parent(Y, X).

% X and Y are siblings if they share a parent and are not the same person
sibling(X, Y) :-
    parent(Z, X),
    parent(Z, Y),
    X \= Y.

% X is a brother of Y if X is male and they are siblings
brother(X, Y) :-
    male(X),
    sibling(X, Y).

% X is a sister of Y if X is female and they are siblings
sister(X, Y) :-
    female(X),
    sibling(X, Y).