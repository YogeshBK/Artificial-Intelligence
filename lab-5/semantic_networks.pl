% ------------------------------------
% Semantic Network in Prolog (Graph-based)
% ------------------------------------

:- dynamic entity/1.
:- dynamic rel/3.    % rel(From, Relation, To)
:- dynamic prop/3.   % prop(Entity, Attribute, Value)

% -------------------------
% Knowledge Base (KB)
% -------------------------

% Taxonomy (isa relationships)
rel(dog, isa, mammal).
rel(mammal, isa, animal).
rel(bird, isa, animal).
rel(penguin, isa, bird).

% Properties
prop(animal, has_cells, yes).
prop(mammal, blood, warm).
prop(bird, can_fly, yes).
prop(dog, sound, bark).
prop(penguin, can_fly, no).   % overrides bird

% -------------------------
% Utility: add entities/relations/properties dynamically
% -------------------------
add_entity(E) :- (entity(E) -> true ; assertz(entity(E))).

add_rel(X, R, Y) :-
    add_entity(X), add_entity(Y),
    assertz(rel(X, R, Y)).

add_prop(E, A, V) :-
    add_entity(E),
    assertz(prop(E, A, V)).

% -------------------------
% Inheritance reasoning
% -------------------------
isa(X, Y) :- rel(X, isa, Y).

ancestor(X, Y) :- isa(X, Y).
ancestor(X, Y) :- isa(X, Z), ancestor(Z, Y).

% -------------------------
% Property inheritance
% -------------------------
own_prop(E, A, V) :- prop(E, A, V).

inherited_prop(E, A, V) :- own_prop(E, A, V).
inherited_prop(E, A, V) :-
    ancestor(E, Anc),
    prop(Anc, A, V),
    \+ own_prop(E, A, _).

has_prop(E, A, V) :- inherited_prop(E, A, V).

% -------------------------
% Graph traversal (path search)
% -------------------------
path(X, Y, Path) :- dfs(X, Y, [X], Rev), reverse(Rev, Path).

dfs(Y, Y, Vis, Vis).
dfs(X, Y, Vis, Path) :-
    rel(X, _, N),
    \+ member(N, Vis),
    dfs(N, Y, [N|Vis], Path).

% Labeled path (shows edge names too)
labeled_path(X, Y, Path) :- lp_dfs(X, Y, [X], [], Path).

lp_dfs(Y, Y, _, Acc, Path) :- reverse(Acc, Path).
lp_dfs(X, Y, Vis, Acc, Path) :-
    rel(X, R, N),
    \+ member(N, Vis),
    lp_dfs(N, Y, [N|Vis], [edge(X,R,N)|Acc], Path).

% -------------------------
% Ancestors / Descendants
% -------------------------
ancestors(E, As) :- setof(A, ancestor(E, A), As) ; As = [].
descendants(E, Ds) :- setof(D, ancestor(D, E), Ds) ; Ds = [].
