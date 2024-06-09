:- dynamic(node_color/2).


input(N,M,[H|T],[H2|T2], Start, End, Sol):-
    \+node_color(H,H2),
    assert(node_color(H,H2)),
    input(N,M,T,T2,Start,End,Sol),!.

input(N,M,[],[],Start,End,_):-
    search(N, M, [[Start, null, 0, 0, 0]], [], End). % State, Parent, G, H, F

remove(N,M,[H|T],[H2|T2]):-
    node_color(H,H2),
    retract(node_color(H,H2)),
    remove(N,M,T,T2),!.

remove(_,_,[],[]).

first_element([X|_], X).

search(N, M, Open, Closed, Goal):-
    getBestState(Open, CurrentNode, TmpOpen),
    ((first_element(CurrentNode, X)), X \= Goal),
    getAllValidChildren(N, M, CurrentNode, TmpOpen, Closed, Goal, Children),
    addChildren(Children, TmpOpen, NewOpen),
    append(Closed, [CurrentNode], NewClosed),
    search(N, M, NewOpen, NewClosed, Goal).

search(_, _, Open, Closed, Goal):-
    getBestState(Open, [CurrentState,Parent,G,H,F], _),
    CurrentState = Goal ->
        (printSolution([CurrentState,Parent,G,H,F], Closed), !);
        (write("No Path exists!"), nl).

getBestState(Open,BestChild,Rest):-
    findMin(Open,BestChild),
    delete(Open,BestChild,Rest).

getAllValidChildren(N, M, Node, Open, Closed, Goal, Children):-
    findall(Next, getNextState(N, M, Node,Open,Closed,Goal,Next),Children).

getNextState(N, M, [State,_,G,_,_],Open,Closed,Goal,[Next,State,NewG,NewH,NewF]):-
    move(N, M, State, Next, MoveCost),
    calculateH(Next, Goal, NewH),
    NewG is G + MoveCost,
    NewF is NewG + NewH,
    (not(member([Next,_,_,_,_],Open));memberButBetter(Next,Open,NewF)),
    (not(member([Next,_,_,_,_],Closed));memberButBetter(Next,Closed,NewF)).

calculateH(Next, Goal, Cost) :-
    Cost is abs(Goal - Next).

addChildren(Children, Open, NewOpen):-
    append(Open, Children, NewOpen).

findMin([X], X):- !.

findMin([Head|T], Min):-
    findMin(T, TmpMin),
    Head = [_,_,_,_,HeadF],
    TmpMin = [_,_,_,_,TmpF],
    (TmpF < HeadF -> Min=TmpMin; Min=Head).


memberButBetter(Next,List,NewF):-
    findall(F,member([Next,_,_,_,F],List),Numbers),
    min_list(Numbers,MinOldF),
    MinOldF > NewF.

printSolution([State,null,G,H,F],_):-
    write([State,G,H,F]), nl.

printSolution([State,Parent,G,H,F],Closed):-
    member([Parent,GrandParent,PrevG,Ph,Pf], Closed),
    printSolution([Parent,GrandParent,PrevG,Ph,Pf], Closed),
    write([State,G,H,F]), nl.

move(N, M, CurNode, NextNode, 1):-
    (left(N, M, CurNode, NextNode),
     CurNode mod M =\= 1); % Not the left most node.
    (right(N, M, CurNode, NextNode),
    CurNode mod M =\= 0); % Not the right most node.
    up(N, M, CurNode, NextNode);
    down(N, M, CurNode, NextNode).

left(N, M, CurNode, NextNode):-
    NextNode is CurNode - 1,
    (NextNode =< N*M),
   (NextNode >= 1),
    node_color(CurNode, X),
    node_color(NextNode, X).

right(N, M, CurNode, NextNode):-
    NextNode is CurNode+1,
   (NextNode =< N*M),
   (NextNode >= 1),
   node_color(CurNode, X),
   node_color(NextNode, X).

up(N, M, CurNode, NextNode):-
    NextNode is CurNode-M,
   (NextNode =< N*M),
   (NextNode >= 1),
   node_color(CurNode, X),
   node_color(NextNode, X).

down(N, M, CurNode, NextNode):-
    NextNode is CurNode+M,
   (NextNode =< N*M),
   (NextNode >= 1),
   node_color(CurNode, X),
   node_color(NextNode, X).
