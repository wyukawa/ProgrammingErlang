-module(lib_misc).
-export([sum/1, sum/2]).

sum(L) -> sum(L, 0).

sum([], N) -> N;
sum([H|T], N) -> sum(T, H+N).
