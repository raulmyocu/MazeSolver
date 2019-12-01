# Maze Solver
### A Prolog Implementation
This is a Maze Solver that uses a Depth First Search algorithm implemented in Prolog.
The *maze.txt* file contains a visual representation of the maze to be solved.

The space characters represent the path, and the # characters are walls.
The beggining is marked with a B and the ending is marked with an E.

To create the facts archive, run:

``` bash
python3 mazeFacts.py
```

and the ``mazeFacts.pl`` file will be automatically created.

To solve the maze, run:

``` bash
swipl mazeSolver.pl
```

and type:
``` python
solveMaze().
```
The result will be displayed.

This project was developed using *SWI-Prolog version 8.0.3*.
