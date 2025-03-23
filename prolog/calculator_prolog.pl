calculator :-
    write('Enter an arithmetic expression (e.g., 2 + 3 * (4 - 1)):'), nl,
    read(Input),
    (   catch(Result is Input, _, fail)
    ->  format('Result: ~w~n', [Result])
    ;   write('Error: Invalid expression.'), nl
    ).
