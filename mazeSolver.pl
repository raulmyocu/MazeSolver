/* To read facts from mazeFacts.pl */
read_facts(_, [], R) :-
	R == end_of_file,
	!. % Green Cut at the end of the file

read_facts(Stream, [T|X], _) :-
	read(Stream, T),
	assert(T), % only the dynamic predicates can be asserted (kind of format checking)
	read_facts(Stream,X,T).

load_facts(File_name) :-
  open(File_name, read, Stream), % open the File given as input (must include the extension)
  read_facts(Stream, _, _), % read AND ASSERT the facts
  close(Stream).

seq(From,_,From).
seq(From,To,X) :-
	From<To - 1,
	Next is From+1,
	seq(Next,To,X).

:-
	load_facts('mazeFacts.pl').

/*To print the unsolved maze*/

printMaze(MW, MH) :-
	seq(0,MH,Index),
	nl,
	printLine(MW, Index),
	fail.

printLine(MW, Y) :-
	seq(0,MW,Index),
	printChar(Index, Y),
	fail.

printChar(X, Y) :-
	path((X,Y)) -> write(' ')
	; write('█').

/*To print the solved maze*/

printSolvedMaze(Path, MW, MH) :-
	seq(0,MH,Index),
	nl,
	printSolvedLine(MW, Index, Path),
	fail.

printSolvedLine(MW, Y, Path) :-
	seq(0,MW,Index),
	printSolvedChar(Index, Y, Path),
	fail.

printSolvedChar(X, Y, Path) :-
	member((X,Y), Path) -> write('#')
	; path((X,Y)) -> write(' ')
	; write('█').

/* To find contiguous points */
connects((X1,Y1),(X2,Y2)) :-
	path((X1,Y1)),
	path((X2,Y2)),
	B is Y2 - 1,
	Y1 =:= B,
	X1 =:= X2.

connects((X1,Y1),(X2,Y2)) :-
	path((X1,Y1)),
	path((X2,Y2)),
	B is Y2 + 1,
	Y1 =:= B,
	X1 =:= X2.

connects((X1,Y1),(X2,Y2)) :-
	path((X1,Y1)),
	path((X2,Y2)),
	A is X2 - 1,
	X1 =:= A,
	Y1 =:= Y2.

connects((X1,Y1),(X2,Y2)) :-
	path((X1,Y1)),
	path((X2,Y2)),
	A is X2 + 1,
	X1 =:= A,
	Y1 =:= Y2.

% solve( Node, Solution):
%    Solution is an acyclic path (in reverse order) between Node and a goal
solve( Node, Solution )  :-
  depthfirst( [], Node, Solution).

% depthfirst( Path, Node, Solution):
%   extending the path [Node | Path] to a goal gives Solution
depthfirst( Path, Node, [Node | Path] )  :-
   end( Node ).

depthfirst( Path, Node, Sol)  :-
  connects( Node, Node1),
  \+ member( Node1, Path),                % To prevent a cycle
  depthfirst( [Node | Path], Node1, Sol).

solveMaze() :-
	mazeHeight(MHeight),
	mazeWidth(MWidth),
	begin((XB,YB)),
	solve((XB,YB), Sol),
	printSolvedMaze(Sol, MWidth, MHeight).


:-
	mazeHeight(MHeight),
	mazeWidth(MWidth),
	printMaze(MWidth, MHeight).
