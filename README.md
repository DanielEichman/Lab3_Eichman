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


#####LED’s (8)
->moving lights that symbolize the directions of the elevator 

#####Switches (8)
->Switch(0):up_down (Moore, Mealy, Prime)

->Switch (2 to 0): Three bit number to input to floor to go to (Change Inputs, Multiple Elevators)

->Switch (7 to 5): Three bit number to input present floor (Multiple Elevators) 
##Lab	
####Basic Elevator Controller
![Image](https://raw.github.com/DanielEichman/Lab3_Eichman/master/Basic_Moore.JPG)

The above code shows how the inputs were matched up. The link to the fully shell can be found ![here](https://github.com/DanielEichman/Lab3_Eichman/blob/master/MooreElevatorController_Shell.vhd).
####Mealy Elevator Controller	
![Image](https://raw.github.com/DanielEichman/Lab3_Eichman/master/Basic_Mealy.JPG)

The above code shows the relationship between inputs and outputs. The full shell can be found ![here](https://github.com/DanielEichman/Lab3_Eichman/blob/master/MealyElevatorController_Shell.vhd).
####More Floors(Prime Floors)
![Image](https://raw.github.com/DanielEichman/Lab3_Eichman/master/Prime_Elevator.JPG)

The prime elevator ![shell](https://github.com/DanielEichman/Lab3_Eichman/blob/master/MooreElevatorController_Shell_Prime.vhd) was redesigned to have 8 floors. This shell will return a floor from 1-8 (0001 to 1000). To then light up the first eight prime floors a process was need that mapped 1-8 to 2-19. 

####Change Inputs and Moving Lights
![Image](https://raw.github.com/DanielEichman/Lab3_Eichman/master/Change_Inputs.JPG)

Most the fancy code happens in the ![shell](https://github.com/DanielEichman/Lab3_Eichman/blob/master/MooreElevatorController_Shell_ChangeInputs.vhd). In the shell there are a set of 64 if statements to determine if the current floor is above or below the desired floor. 

For the moving lights the CLOCKBUS_SIG  was used while travelling up and reversed when it was travelling down. Another emancipated state was created to determine direction of travel. 

####Multiple Elevators
![Image](https://raw.github.com/DanielEichman/Lab3_Eichman/master/Two_Elavators.JPG)

This scenario required another intermediate ![shell](https://github.com/DanielEichman/Lab3_Eichman/blob/master/Two_Elavators.vhd) that interacted with two MooreElevatorController_Shell_ChangeInputs. This shell determined which elevator was closer sent it to the current floor then to the desired floor. 
##Code Critique 
```
--clk'event and clk='1' is VHDL-speak for a rising edge
   if clk'event and clk='1' then
```
###Documentation
C3C Sean Bapty helped me understand what was needed for the schematic
