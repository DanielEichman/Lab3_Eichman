Lab3_Eichman
============
##Prelab
###Schematic
![Schematic](https://raw.github.com/DanielEichman/Lab3_Eichman/master/Schematic.jpg)
###Inputs and Output’s

#####LCD (4 numbers)
->display floor number (2 Digits for each elevator)

#####Buttons (4)
->Btn(0):Reset (Moore, Mealy, Prime)

->Btn(3):Stop (Moore, Mealy, Prime)

->Switch(1):up_down (Moore, Mealy, Prime)

#####LED’s (8)
->moving lights that symbolize the directions of the elevator 

#####Switches (8)
->Switch (2 to 0): Three bit number to input to floor to go to (Change Inputs, Multiple Elevators)

->Switch (7 to 5): Three bit number to input present floor (Multiple Elevators) 
	
####Basic Elevator Controller
![Image](https://raw.github.com/DanielEichman/Lab3_Eichman/master/Basic_Moore.JPG)

The above code shows how the inputs were matched up. The link to the fully shell can be found ![here](https://github.com/DanielEichman/Lab3_Eichman/blob/master/MooreElevatorController_Shell.vhd).
####Mealy Elevator Controller	
![Image](https://raw.github.com/DanielEichman/Lab3_Eichman/master/Basic_Mealy.JPG)

The above code shows the relationship between inputs and outputs. The full shell can be found ![here](https://github.com/DanielEichman/Lab3_Eichman/blob/master/MealyElevatorController_Shell.vhd).
####More Floors(Prime Floors)
![Image](https://raw.github.com/DanielEichman/Lab3_Eichman/master/Prime_Elevator.JPG)

The prime elevator ![shell](https://github.com/DanielEichman/Lab3_Eichman/blob/master/MooreElevatorController_Shell_Prime.vhd) was redesied to have 8 floors. This shell will return a floor from 1-8 (0001 to 1000). To then light up the first eight prime floors a process was need that mapped 1-8 to 2-19. 
####Change Inputs
####Moving Lights
####Demonstrated Multiple Elevators

###Documentation
C3C Sean Bapty helped me understand what was needed for the schematic
