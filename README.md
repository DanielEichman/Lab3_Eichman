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
####Bad Code
```
floor_state_machine: process(clk)
...
```
####Good Code
```
floor_state_machine: process(clk,floor_state,reset)
...
```
This is better code as it prevents memory from being created. As for if some reason floor_state chagnes outside the process memory will not be created.
####Bad Code
```
--clk'event and clk='1' is VHDL-speak for a rising edge
   if clk'event and clk='1' then
   ...
```
####Good Code
```
--clk'event and clk='1' is VHDL-speak for a rising edge
   if (rising_edge(clk))then
   ...
```
This is better code as though they achieve the same end result, the above code is easier to understand. 
####Bad Code
```
when floor3 =>
					if (							) then 
						floor_state <= 
					elsif (						) then 
						floor_state <= 	
					else
						floor_state <= 	
					end if;
				when floor4 =>
					if (							) then 
						floor_state <= 	
					else 
						floor_state <= 	
					end if;
```
####Good Code
```
when floor3 =>
					if (up_down='1' and stop='0') then 
						floor_state <= floor4;
					elsif (up_down='0' and stop='0') then 
						floor_state <= floor2;	
					else--stop==1
						floor_state <= floor3;
					end if;
				when floor4 =>
					if (up_down='0' and stop='0') then 
						floor_state <= floor3;	
					else 
						floor_state <= floor4;	
					end if;
```
Obviously the bad code is completely missing. The good code completes the missing code and follows correct logic.
####Bad Code
```
floor <= "0001" when (floor_state =       ) else
			"0010" when (                    ) else
			"0011" when (                    ) else
			"0100" when (                    ) else
			"0001";
```
####Good Code
```
floor <= "0001" when (floor_state = floor1) else
			"0010" when (floor_state = floor2) else
			"0011" when (floor_state = floor3) else
			"0100" when (floor_state = floor4) else
			"0001";
```
The bad code is also completely missing the logic portion. Good code basically just completes the logic.

###Documentation
C3C Sean Bapty helped me understand what was needed for the schematic
