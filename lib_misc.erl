-module(lib_misc).
-export([sum/1, sum/2, for/3, qsort/1, pythag/1, perms/1, odds_and_evens/1, odds_and_evens_acc/1, sqrt/1,on_exit/2]).

sum(L) -> sum(L, 0).

sum([], N) -> N;
sum([H|T], N) -> sum(T, H+N).

for(Max, Max, F) -> [F(Max)];
for(I, Max, F) -> [F(I)|for(I+1, Max, F)].

qsort([]) -> [];
qsort([Pivot|T]) -> qsort([X || X <- T, X < Pivot])
                    ++ [Pivot] ++
                    qsort([X || X <- T, X >= Pivot]).

pythag(N) ->
  [ {A, B, C} ||
    A <- lists:seq(1, N),
    B <- lists:seq(1, N),
    C <- lists:seq(1, N),
    A+B+C =< N,
    A*A+B*B =:= C*C
  ].

perms([]) -> [[]];
perms(L) -> [[H|T] || H <- L, T <- perms(L--[H])].

odds_and_evens(L) ->
  Odds = [X || X <- L, (X rem 2) =:= 1],
  Evens = [X || X <- L, (X rem 2) =:= 0],
  {Odds, Evens}.

odds_and_evens_acc(L) ->
  odds_and_evens_acc(L, [], []).

odds_and_evens_acc([H|T], Odds, Evens) ->
  case (H rem 2) of
    1 -> odds_and_evens_acc(T, [H|Odds], Evens);
    0 -> odds_and_evens_acc(T, Odds, [H|Evens])
  end;
odds_and_evens_acc([], Odds, Evens) ->
  {Odds, Evens}.

sqrt(X) when X < 0 ->
  erlang:error({squareRootNegativeArgument, X});
sqrt(X) ->
  sqrt(X).

on_exit(Pid, Fun) ->
  spawn(fun() ->
  process_flag(trap_exit, true),
  link(Pid),
  receive
    {'EXIT',Pid,Why} ->
      Fun(Why)
  end
  end).
