mazeF = open("maze.txt", "r")
factsF = open("mazeFacts.pl", "w+")

mazeStr = mazeF.readlines()

factsF.write('mazeHeight('+str(len(mazeStr))+').\n')
factsF.write('mazeWidth('+str(len(mazeStr[0])-1)+').\n')

for yi in range(len(mazeStr)):
    for xi in range(len(mazeStr[yi])):
        if mazeStr[yi][xi] == ' ':
            factsF.write('path(('+str(xi)+','+str(yi)+')).\n')
        elif mazeStr[yi][xi] == 'B':
            factsF.write('path(('+str(xi)+','+str(yi)+')).\n')
            factsF.write('begin(('+str(xi)+','+str(yi)+')).\n')
        elif mazeStr[yi][xi] == 'E':
            factsF.write('path(('+str(xi)+','+str(yi)+')).\n')
            factsF.write('end(('+str(xi)+','+str(yi)+')).\n')
mazeF.close()
factsF.close()
