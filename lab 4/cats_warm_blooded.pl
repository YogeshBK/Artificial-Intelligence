% ---------- Facts ----------
% All mammals are warm-blooded
warm_blooded(X) :- mammal(X).

% All cats are mammals
mammal(X) :- cat(X).

% Given fact: Tom is a cat
cat(tom).