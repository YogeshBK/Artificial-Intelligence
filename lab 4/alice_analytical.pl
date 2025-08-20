% ---------- Rules from the FOPL ----------
% All engineers are problem solvers
problem_solver(X) :- engineer(X).

% All software developers are engineers
engineer(X) :- software_developer(X).

% All problem solvers are analytical thinkers
analytical_thinker(X) :- problem_solver(X).

% Everyone who drinks coffee is good at something
good_at_something(X) :- drinks_coffee(X).

% ---------- Facts ----------
software_developer(alice).
drinks_coffee(alice).