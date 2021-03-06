----------------------------------------------------------------------------------
-- Company: USAFA/DFEC
-- Engineer: Daniel Eichman
-- 
-- Create Date:    	10:33:47 07/07/2012 
-- Design Name:		CE3
-- Module Name:    	MooreElevatorController_Shell_Prime - Behavioral 
-- Description: 		Moore Elevator Controller with an output of current floor. It has a total of 8 ouputs ranging from 0001 to 1000. It does not output prime numbers as the name suggests but rather the prime numbers can be mapped later on. 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity MooreElevatorController_Shell_Prime is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           stop : in  STD_LOGIC;
           up_down : in  STD_LOGIC;
           floor : out  STD_LOGIC_VECTOR (3 downto 0));
end MooreElevatorController_Shell_Prime;

architecture Behavioral of MooreElevatorController_Shell_Prime is

--Below you create a new variable type! You also define what values that 
--variable type can take on. Now you can assign a signal as 
--"floor_state_type" the same way you'd assign a signal as std_logic 
type floor_state_type is (floor1, floor2, floor3, floor4, floor5, floor6, floor7, floor8);

--Here you create a variable "floor_state" that can take on the values
--defined above. Neat-o!
signal floor_state : floor_state_type;

begin
---------------------------------------------
--Below you will code your next-state process
---------------------------------------------

--This line will set up a process that is sensitive to the clock
floor_state_machine: process(clk)
begin
	--clk'event and clk='1' is VHDL-speak for a rising edge
	if clk'event and clk='1' then
		--reset is active high and will return the elevator to floor1
		--Question: is reset synchronous or asynchronous?
		if reset='1' then
			floor_state <= floor1;
		--now we will code our next-state logic
		else
			case floor_state is
				--when our current state is floor1
				when floor1 =>
					--if up_down is set to "go up" and stop is set to 
					--"don't stop" which floor do we want to go to?
					if (up_down='1' and stop='0') then 
						--floor2 right?? This makes sense!
						floor_state <= floor2;
					--otherwise we're going to stay at floor1
					else
						floor_state <= floor1;
					end if;
				--when our current state is floor2
				when floor2 => 
					--if up_down is set to "go up" and stop is set to 
					--"don't stop" which floor do we want to go to?
					if (up_down='1' and stop='0') then 
						floor_state <= floor3; 			
					--if up_down is set to "go down" and stop is set to 
					--"don't stop" which floor do we want to go to?
					elsif (up_down='0' and stop='0') then 
						floor_state <= floor1;
					--otherwise we're going to stay at floor2
					else
						floor_state <= floor2;
						
					end if;
				
--COMPLETE THE NEXT STATE LOGIC ASSIGNMENTS FOR FLOORS 3 AND 4
				when floor3 =>
					if (up_down='1' and stop='0') then 
						floor_state <= floor4;
					elsif (up_down='0' and stop='0') then 
						floor_state <= floor2;	
					else--stop==1
						floor_state <= floor3;
					end if;
				when floor4 =>
					if (up_down='1' and stop='0') then 
						floor_state <= floor5;
					elsif (up_down='0' and stop='0') then 
						floor_state <= floor3;	
					else--stop==1
						floor_state <= floor4;
					end if;
				when floor5 =>
					if (up_down='1' and stop='0') then 
						floor_state <= floor6;
					elsif (up_down='0' and stop='0') then 
						floor_state <= floor4;	
					else--stop==1
						floor_state <= floor5;
					end if;
				when floor6 =>
					if (up_down='1' and stop='0') then 
						floor_state <= floor7;
					elsif (up_down='0' and stop='0') then 
						floor_state <= floor5;	
					else--stop==1
						floor_state <= floor6;
					end if;
				when floor7 =>
					if (up_down='1' and stop='0') then 
						floor_state <= floor8;
					elsif (up_down='0' and stop='0') then 
						floor_state <= floor6;	
					else--stop==1
						floor_state <= floor7;
					end if;
				when floor8 =>
					if (up_down='0' and stop='0') then 
						floor_state <= floor7;	
					else 
						floor_state <= floor8;	
					end if;
				
				--This line accounts for phantom states
				when others =>
					floor_state <= floor1;
			end case;
		end if;
	end if;
end process;

-- Here you define your output logic. Finish the statements below
floor <= "0001" when (floor_state = floor1) else
			"0010" when (floor_state = floor2) else
			"0011" when (floor_state = floor3) else
			"0100" when (floor_state = floor4) else
			"0101" when (floor_state = floor5) else
			"0110" when (floor_state = floor6) else
			"0111" when (floor_state = floor7) else
			"1000" when (floor_state = floor8) else
			"0001";

end Behavioral;

