----------------------------------------------------------------------------------
-- Company: USAFA/DFEC
-- Engineer: Daniel Eichman
-- 
-- Create Date:    	10:33:47 07/07/2012 
-- Design Name:		CE3
-- Module Name:    	MooreElevatorController_Shell - Behavioral 
-- Description: 		Shell for completing CE3
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity MooreElevatorController_Shell_ChangeInput is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           wantedFloor : in  STD_LOGIC_VECTOR (2 downto 0);
           floor : out  STD_LOGIC_VECTOR (3 downto 0);
			  LEDIN : in std_logic_vector(7 downto 0);
			  LED : out STD_LOGIC_VECTOR(7 downto 0));
end MooreElevatorController_Shell_ChangeInput;

architecture Behavioral of MooreElevatorController_Shell_ChangeInput is

--Below you create a new variable type! You also define what values that 
--variable type can take on. Now you can assign a signal as 
--"floor_state_type" the same way you'd assign a signal as std_logic 
type floor_state_type is (floor0, floor1, floor2, floor3, floor4, floor5, floor6, floor7);
type direction is (up,down,stopped);
--Here you create a variable "floor_state" that can take on the values
--defined above. Neat-o!
signal wanted_floor: floor_state_type;
signal floor_state : floor_state_type;
signal current_direction : direction;
signal LEDIN_REV: std_logic_vector( 7 downto 0);
begin
---------------------------------------------
--Below you will code your next-state process
---------------------------------------------
wanted_floor <= 	floor0 when (wantedFloor = "000") else
						floor1 when (wantedFloor = "001") else
						floor2 when (wantedFloor = "010") else
						floor3 when (wantedFloor = "011") else
						floor4 when (wantedFloor = "100") else
						floor5 when (wantedFloor = "101") else
						floor6 when (wantedFloor = "110") else
						floor7 when (wantedFloor = "111") else
						floor0;
	
	LEDIN_REV(0) <= LEDIN(7);
	LEDIN_REV(1) <= LEDIN(6);
	LEDIN_REV(2) <= LEDIN(5);
	LEDIN_REV(3) <= LEDIN(4);
	LEDIN_REV(4) <= LEDIN(3);
	LEDIN_REV(5) <= LEDIN(2);
	LEDIN_REV(6) <= LEDIN(1);
	LEDIN_REV(7) <= LEDIN(0);
	LED  <= LEDIN WHEN current_direction=up ELSE
			  LEDIN_REV WHEN current_direction=down ELSE
			  "00000000";
--This line will set up a process that is sensitive to the clock
floor_state_machine: process(clk)
begin

	
	--clk'event and clk='1' is VHDL-speak for a rising edge
	if clk'event and clk='1' then
		--reset is active high and will return the elevator to floor1
		--Question: is reset synchronous or asynchronous?
		if reset='1' then
			floor_state <= floor0;
			current_direction <= stopped;
		--now we will code our next-state logic
		else
			case wanted_floor is
				when floor0 =>
					if (floor_state=wanted_floor) then 
						floor_state <= floor0;
						current_direction <= stopped;
					--Current floor is greater than wanted floor
					elsif ( floor_state=floor1) then
						floor_state <= floor0;
						current_direction <= down;
					elsif ( floor_state=floor2) then
						floor_state <= floor1;
						current_direction <= down;
					elsif ( floor_state=floor3) then
						floor_state <= floor2;
						current_direction <= down;
					elsif ( floor_state=floor4) then
						floor_state <= floor3;
						current_direction <= down;
					elsif ( floor_state=floor5) then
						floor_state <= floor4;
						current_direction <= down;
					elsif ( floor_state=floor6) then
						floor_state <= floor5;
						current_direction <= down;
					elsif ( floor_state=floor7) then
						floor_state <= floor6;
						current_direction <= down;
					else
					end if;
				when floor1 => 
					if (floor_state=wanted_floor) then 
						floor_state <= floor1;
						current_direction <= stopped;
					--Current floor is less than wanted floor
					elsif ( floor_state=floor0) then 
						floor_state <= floor1;
						current_direction <= up;
					--Current floor is greater than wanted floor
					elsif ( floor_state=floor2) then
						floor_state <= floor1;
						current_direction <= down;
					elsif ( floor_state=floor3) then
						floor_state <= floor2;
						current_direction <= down;
					elsif ( floor_state=floor4) then
						floor_state <= floor3;
						current_direction <= down;
					elsif ( floor_state=floor5) then
						floor_state <= floor4;
						current_direction <= down;
					elsif ( floor_state=floor6) then
						floor_state <= floor5;
						current_direction <= down;
					elsif ( floor_state=floor7) then
						floor_state <= floor6;
						current_direction <= down;
					else
					end if;
				when floor2 => 
					if (floor_state=wanted_floor) then 
						floor_state <= floor2;
						current_direction <= stopped;
					--Current floor is less than wanted floor
					elsif ( floor_state=floor0) then 
						floor_state <= floor1;
						current_direction <= up;
					elsif ( floor_state=floor1) then 
						floor_state <= floor2;
						current_direction <= up;
					--Current floor is greater than wanted floor
					elsif ( floor_state=floor3) then
						floor_state <= floor2;
						current_direction <= down;
					elsif ( floor_state=floor4) then
						floor_state <= floor3;
						current_direction <= down;
					elsif ( floor_state=floor5) then
						floor_state <= floor4;
						current_direction <= down;
					elsif ( floor_state=floor6) then
						floor_state <= floor5;
						current_direction <= down;
					elsif ( floor_state=floor7) then
						floor_state <= floor6;
						current_direction <= down;
					else
					end if;
				when floor3 => 
					if (floor_state=wanted_floor) then 
						floor_state <= floor3;
						current_direction <= stopped;
					--Current floor is less than wanted floor
					elsif ( floor_state=floor0) then 
						floor_state <= floor1;
						current_direction <= up;
					elsif ( floor_state=floor1) then 
						floor_state <= floor2;
						current_direction <= up;
					elsif ( floor_state=floor2) then 
						floor_state <= floor3;
						current_direction <= up;
					--Current floor is greater than wanted floor
					elsif ( floor_state=floor4) then
						floor_state <= floor3;
						current_direction <= down;
					elsif ( floor_state=floor5) then
						floor_state <= floor4;
						current_direction <= down;
					elsif ( floor_state=floor6) then
						floor_state <= floor5;
						current_direction <= down;
					elsif ( floor_state=floor7) then
						floor_state <= floor6;
						current_direction <= down;
					else
					end if;
				when floor4 => 
					if (floor_state=wanted_floor) then 
						floor_state <= floor4;
						current_direction <= stopped;
					--Current floor is less than wanted floor
					elsif ( floor_state=floor0) then 
						floor_state <= floor1;
						current_direction <= up;
					elsif ( floor_state=floor1) then 
						floor_state <= floor2;
						current_direction <= up;
					elsif ( floor_state=floor2) then 
						floor_state <= floor3;
						current_direction <= up;
					elsif ( floor_state=floor3) then 
						floor_state <= floor4;
						current_direction <= up;
					--Current floor is greater than wanted floor
					elsif ( floor_state=floor5) then
						floor_state <= floor4;
						current_direction <= down;
					elsif ( floor_state=floor6) then
						floor_state <= floor5;
						current_direction <= down;
					elsif ( floor_state=floor7) then
						floor_state <= floor6;
						current_direction <= down;
					else
					end if;
				when floor5 => 
					if (floor_state=wanted_floor) then 
						floor_state <= floor5;
						current_direction <= stopped;
					--Current floor is less than wanted floor
					elsif ( floor_state=floor0) then 
						floor_state <= floor1;
						current_direction <= up;
					elsif ( floor_state=floor1) then 
						floor_state <= floor2;
						current_direction <= up;
					elsif ( floor_state=floor2) then 
						floor_state <= floor3;
						current_direction <= up;
					elsif ( floor_state=floor3) then 
						floor_state <= floor4;
						current_direction <= up;
					elsif ( floor_state=floor4) then 
						floor_state <= floor5;
						current_direction <= up;
					--Current floor is greater than wanted floor
					elsif ( floor_state=floor6) then
						floor_state <= floor5;
						current_direction <= down;
					elsif ( floor_state=floor7) then
						floor_state <= floor6;
						current_direction <= down;
					else
					end if;
				when floor6 => 
					if (floor_state=wanted_floor) then 
						floor_state <= floor6;
						current_direction <= stopped;
					--Current floor is less than wanted floor
					elsif ( floor_state=floor0) then 
						floor_state <= floor1;
						current_direction <= up;
					elsif ( floor_state=floor1) then 
						floor_state <= floor2;
						current_direction <= up;
					elsif ( floor_state=floor2) then 
						floor_state <= floor3;
						current_direction <= up;
					elsif ( floor_state=floor3) then 
						floor_state <= floor4;
						current_direction <= up;
					elsif ( floor_state=floor4) then 
						floor_state <= floor5;
						current_direction <= up;
					elsif ( floor_state=floor5) then 
						floor_state <= floor6;
						current_direction <= up;
					--Current floor is greater than wanted floor
					elsif ( floor_state=floor7) then
						floor_state <= floor6;
						current_direction <= down;
					else
					end if;
				when floor7 => 
					if (floor_state=wanted_floor) then 
						floor_state <= floor7;
						current_direction <= stopped;
					--Current floor is less than wanted floor
					elsif ( floor_state=floor0) then 
						floor_state <= floor1;
						current_direction <= up;
					elsif ( floor_state=floor1) then 
						floor_state <= floor2;
						current_direction <= up;
					elsif ( floor_state=floor2) then 
						floor_state <= floor3;
						current_direction <= up;
					elsif ( floor_state=floor3) then 
						floor_state <= floor4;
						current_direction <= up;
					elsif ( floor_state=floor4) then 
						floor_state <= floor5;
						current_direction <= up;
					elsif ( floor_state=floor5) then 
						floor_state <= floor6;
						current_direction <= up;
					elsif ( floor_state=floor6) then 
						floor_state <= floor7;
						current_direction <= up;
					else
					end if;
				when others =>
					floor_state <= floor0;
					current_direction <= stopped;
			end case;
		end if;
	end if;
end process;

-- Here you define your output logic. Finish the statements below
floor <= "0000" when (floor_state = floor0) else
			"0001" when (floor_state = floor1) else
			"0010" when (floor_state = floor2) else
			"0011" when (floor_state = floor3) else
			"0100" when (floor_state = floor4) else
			"0101" when (floor_state = floor5) else
			"0110" when (floor_state = floor6) else
			"0111" when (floor_state = floor7) else
			"0000";
--LED<= 	"00000001" when (floor_state = floor0) else
--			"00000010" when (floor_state = floor1) else
--			"00000100" when (floor_state = floor2) else
--			"00001000" when (floor_state = floor3) else
--			"00010000" when (floor_state = floor4) else
--			"00100000" when (floor_state = floor5) else
--			"01000000" when (floor_state = floor6) else
--			"10000000" when (floor_state = floor7) else
--			"00000000";
end Behavioral;

