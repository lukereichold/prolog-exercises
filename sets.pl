% Set Operation Predicates
% Luke Reichold, 04/2014

% Member (holds iff the element X occurs in set)
member(X, [X | _]) :- !.	% can stop looking since this is a set, each element is unique
member(X, [_ | T]) :- member(X, T).

% Subset (holds iff [X|T] is a subset of K). Note 2nd rule: empty set is subset of every set
subset([X|T], K) :- member(X, K), subset(T, K).
subset([], _).

% Disjoint (holds iff L & K are disjoint - no elements in common)
disjoint([X|T], K) :- not(member(X, K)), disjoint(T, K).
disjoint([], _).

% Union of 2 sets (holds iff [K|T] is the union of L and K)
union([], [], []).
union([], M, M).
union(M, [], M).
union([X|T1], [Y|T2], [X|T3]) :- X < Y, union(T1, [Y|T2], T3).
union([X|T1], [Y|T2], [Y|T3]) :- X > Y, union([X|T1], T2, T3).
union([X|T1], [Y|T2], [X|T3]) :- X=:=Y, union(T1, T2, T3).

% Intersection (holds iff M is the intersection of L and K)
intersection([X|T], K, [X|M]) :- member(X, K), intersection(T, K, M).
intersection([X|T], K, M) :- \+ member(X, K), intersection(T, K, M).
intersection([], _, []).

% Difference (holds iff M is the difference of L and K); i.e. A-B
difference([X|T], K, M) :- member(X, K), difference(T, K, M).
difference([X|T], K, [X|M]) :- \+ member(X, K), difference(T, K, M).
difference([], _, []).
