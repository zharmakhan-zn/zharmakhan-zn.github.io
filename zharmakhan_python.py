import random
import os
import time
SHIP_SIZE=4 #constant (global) variable not to hardcode things
DIMENSION=10 #constant (global) variable not to hardcode things

board=[]
ship=[] #lists of each 4 coordinates of ship inside the ship list


for row in range(DIMENSION):
	row_list=[]
	for column in range(DIMENSION):
			row_list.append('   ')
	board.append(row_list)


random_row=random.randint(0,6)
random_column=random.randint(0,6) #end value is 6 otherwise it would exceed the board limits
ship.append([random_row, random_column])
random_orientation=random.randint(0,1)

if random_orientation==0: #for vertical orientation
	for i in range(1,4): #let the 1st coordinate stay the same and add next coordinates and modify them
		new_row= random_row + i
		ship.append([new_row,random_column])
if random_orientation==1: #for horizontal orientation
	for i in range(1,4):#start value is 1 because [0] is in first coordinate
		new_column= random_column + i
		ship.append([random_row,new_column])


for column in range(65,75): #for letters of table
	print('   '+chr(column), end='')

print('\n +'+'---+'*DIMENSION)

for row in range(DIMENSION):
	print(str(row)+'|', end='')
	for column in range(DIMENSION):
		print(board[row][column]+'|', end ='')
	print('\n +'+'---+'*DIMENSION)


hit=0 #number of times user guesses coordinates of ship
attempts=0 #number of times user attempts to guess
storage=[] # stores all the inputted guesses to check repetitiveness
while hit<4: #itiretaes till the ship is sunk and terminates
	guess=input('try to guess ship coordinates: ')

	row=0
	column=0
	letter=guess[0]
	number=guess[1]
	column= ord(letter)-65
	row=number
	
	

	if letter.isupper() and number.isdigit() and letter.isalpha() and len(guess)==2: #to check for invalid input
		if guess in storage:
			print('you have already guessed it, try other')
		elif int(row)==ship[0][0] and column==ship[0][1] or int(row)==ship[1][0] and column==ship[1][1] or int(row)==ship[2][0] and column==ship[2][1] or int(row)==ship[3][0] and column==ship[3][1] : #or
			
			board[int(row)][column]=' X '
			storage.append(guess)
			hit+=1
			attempts+=1
			
		else:
			board[int(row)][column]=' # '
			storage.append(guess)
			attempts+=1
		
		time.sleep(1) 
		os.system('clear')
		for column in range(65,75):
			print('   '+chr(column), end='')

		print('\n +'+'---+'*DIMENSION)

		for row in range(DIMENSION):
			print(str(row)+'|', end='')
			for column in range(DIMENSION):
				print(board[row][column]+'|', end ='')
			print('\n +'+'---+'*DIMENSION)
	else:
		print('you entered invalid coordinate')

if hit==4:
	print('YESSS U WOOONNN!!!')
	print('ur score is', (hit/attempts)*100, '/100.0') #displays score after ship is sunk
		



