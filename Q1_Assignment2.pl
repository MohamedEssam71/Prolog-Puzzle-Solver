:- dynamic(node_color/2).


input(N,M,[H|T],[H2|T2], Sol):-
    \+node_color(H,H2),
    assert(node_color(H,H2)),
    input(N,M,T,T2,Sol),!.

input(N,M,[],[],Sol):-
    search(N,M,1,[],Sol).

search(N, M, CurNode, _, _) :-
    CurNode > N * M,
    write("No cycle exists!"), nl, !.

search(N, M, CurNode, _, Sol):-
    NextNode is CurNode + 1,
    (dfs(N, M, CurNode, [], Sol2) ->
    (  (Sol2 \= []) ->
       (Sol = Sol2)  ;  search(N,M,NextNode,[], Sol))
    ;    search(N, M, NextNode, [], Sol)).


remove(N,M,[H|T],[H2|T2]):-
    node_color(H,H2),
    retract(node_color(H,H2)),
    remove(N,M,T,T2),!.

remove(_,_,[],[]).


lastNode([H],H).
lastNode([_|T],Element):-
    lastNode(T,Element).

check_goal([H|T], M) :-
    length([H|T], L),
    L >= 4,
    lastNode([H|T], LastNode),
    ((H+1 =:= LastNode, (H+1) mod M =\= 1) |
     (H-1 =:= LastNode, (H-1) mod M =\= 0) |
      H+M =:= LastNode |
      H-M =:= LastNode).

dfs(N, M, CurNode, Path, Sol):-
    node_color(CurNode,_),
    getNextState(CurNode, N, M, NextNode),
    \+member(NextNode, Path),
    dfs(N, M, NextNode, [CurNode|Path], Sol).

dfs(_, M, CurNode, Path, Sol):-
    check_goal([CurNode|Path], M), !,
    reverse([CurNode|Path], Sol),
    node_color(CurNode, Color),
    write(Color), nl.


getNextState(CurNode, N, M, NextNode):-
    move(CurNode, N, M, NextNode).

move(CurNode, N, M, NextNode):-
    (left(CurNode, N, M, NextNode),
     CurNode mod M =\= 1); % Not the left most node
    (right(CurNode, N, M, NextNode),
    CurNode mod M =\= 0); % Not the right most node
    up(CurNode, N, M, NextNode);
    down(CurNode, N, M, NextNode).

left(CurNode, N, M, NextNode):-
    NextNode is CurNode-1,
   (NextNode =< N*M),
   (NextNode >= 1),
   node_color(CurNode, X),
   node_color(NextNode, X).

right(CurNode, N, M, NextNode):-
    NextNode is CurNode+1,
   (NextNode =< N*M),
   (NextNode >= 1),
   node_color(CurNode, X),
   node_color(NextNode, X).

up(CurNode, N, M, NextNode):-
    NextNode is CurNode-M,
   (NextNode =< N*M),
   (NextNode >= 1),
   node_color(CurNode, X),
   node_color(NextNode, X).

down(CurNode, N, M, NextNode):-
    NextNode is CurNode+M,
   (NextNode =< N*M),
   (NextNode >= 1),
   node_color(CurNode, X),
   node_color(NextNode, X).








