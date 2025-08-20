% Facts: who likes what
likes(alice, pizza).
likes(alice, reading).
likes(bob, pizza).
likes(bob, football).
likes(charlie, music).
likes(charlie, reading).
likes(diana, music).
likes(diana, travel).

% Rule: two people are friends if they share a common interest
friend(X, Y) :-
    likes(X, Z),
    likes(Y, Z),
    X \= Y.