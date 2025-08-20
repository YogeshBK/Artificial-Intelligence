
% Water Jug Problem Solver
% Using a 4-gallon jug and 3-gallon jug, measure exactly 2 gallons

% Possible actions:
% 1. Fill a jug to its capacity
% 2. Empty a jug completely
% 3. Pour from one jug to another until either the first is empty or the second is full

% State representation: state(Jug4, Jug3)
% where Jug4 is the amount in the 4-gallon jug
% and Jug3 is the amount in the 3-gallon jug

% Solve the puzzle
solve :-
    solve_jugs([state(0,0)], Path),
    reverse(Path, OrderedPath),
    display_path(OrderedPath).

% Base case: solution found when either jug has exactly 2 gallons
solve_jugs([state(2,_)|Path], [state(2,_)|Path]).
solve_jugs([state(_,2)|Path], [state(_,2)|Path]).

% Recursive case: try all possible moves
solve_jugs([State|Path], Solution) :-
    findall(NextState, move(State, NextState), NextStates),
    member(NextState, NextStates),
    \+ member(NextState, [State|Path]), % Prevent cycles
    solve_jugs([NextState,State|Path], Solution).

% Possible moves from a given state
move(state(J4, J3), state(4, J3)) :- J4 < 4. % Fill 4-gallon jug
move(state(J4, J3), state(J4, 3)) :- J3 < 3. % Fill 3-gallon jug
move(state(J4, J3), state(0, J3)) :- J4 > 0. % Empty 4-gallon jug
move(state(J4, J3), state(J4, 0)) :- J3 > 0. % Empty 3-gallon jug

% Pour from 4-gallon to 3-gallon jug
move(state(J4, J3), state(NewJ4, NewJ3)) :-
    J4 > 0,
    J3 < 3,
    PourAmount is min(J4, 3 - J3),
    NewJ4 is J4 - PourAmount,
    NewJ3 is J3 + PourAmount.

% Pour from 3-gallon to 4-gallon jug
move(state(J4, J3), state(NewJ4, NewJ3)) :-
    J3 > 0,
    J4 < 4,
    PourAmount is min(J3, 4 - J4),
    NewJ4 is J4 + PourAmount,
    NewJ3 is J3 - PourAmount.

% Display the solution path
display_path([]).
display_path([state(J4,J3)|Rest]) :-
    format('4-gallon jug: ~w, 3-gallon jug: ~w~n', [J4,J3]),
    display_path(Rest).
