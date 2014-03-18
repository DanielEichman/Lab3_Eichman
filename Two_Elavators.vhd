----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Daniel Eichman
-- 
-- Create Date:    21:18:25 03/16/2014 
-- Design Name: 
-- Module Name:    Two_Elavators - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: This is the interface that interacts with two Mealy Elevators. It takes in a current floor and wanted floor. Then it choses the closes elevator and picks up the passenger then travels to the wanted floor. 

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
Use ieee.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Two_Elavators is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           currentFloor : in  STD_LOGIC_VECTOR (2 downto 0);
           wantedFloor : in  STD_LOGIC_VECTOR (2 downto 0);
           elevator1 : out  STD_LOGIC_VECTOR (3 downto 0);
           elevator2 : out STD_LOGIC_VECTOR (3 downto 0);
           LEDIN : in  STD_LOGIC_VECTOR (7 downto 0);
           LED : out  STD_LOGIC_VECTOR (7 downto 0));
end Two_Elavators;

architecture Behavioral of Two_Elavators is
COMPONENT MooreElevatorController_Shell_ChangeInput
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		wantedFloor : IN std_logic_vector(2 downto 0);          
		floor : OUT std_logic_vector(3 downto 0);
		LEDIN : in std_logic_vector(7 downto 0);
		LED : out STD_LOGIC_VECTOR(7 downto 0)
		);
	END COMPONENT;
	
signal wantedFloor1: std_logic_vector(2 downto 0);
signal wantedFloor2: std_logic_vector(2 downto 0);
signal el1: std_logic_vector(3 downto 0);
signal el2: std_logic_vector(3 downto 0);
signal LED1: std_logic_vector(7 downto 0);
signal LED2: std_logic_vector(7 downto 0);
type closesetElevator is (one, two, none);

signal choseElevator : closesetElevator := none;
type pickedUpPassenger is (yes, no);
signal el1Picked : pickedUpPassenger := no;
signal el2Picked : pickedUpPassenger := no;
begin
	vator1: MooreElevatorController_Shell_ChangeInput PORT MAP(
		clk => clk,
		reset => reset,
		wantedFloor => wantedFloor1,
		floor => el1,
		LEDIN => LEDIN,
		LED => LED1
	);
	vator2: MooreElevatorController_Shell_ChangeInput PORT MAP(
		clk => clk,
		reset => reset,
		wantedFloor => wantedFloor2,
		floor => el2,
		LEDIN => LEDIN,
		LED => LED2
	);
--process(clk)
--begin
--	if(abs(to_integer(unsigned(el1))-to_integer(unsigned(currentFloor)))<abs(to_integer(unsigned(el2))-to_integer(unsigned(currentFloor))))then
--		choseElevator<=one;
--		LED<="00000001";
--	else
--		choseElevator<=two;
--		LED<="00000010";
--	end if;
--	if(choseElevator=one) then
--		while not el1(2 DOWNTO 0)=wantedFloor loop
--			wantedFloor1<=wantedFloor;
--			LED<="00001000";
--		end loop;
--		choseElevator<=none;
--	elsif(choseElevator=two) then
--		while not el2(2 DOWNTO 0)=wantedFloor loop
--			wantedFloor2<=wantedFloor;
--			LED<="00010000";
--		end loop;
--		choseElevator<=none;
--	else
--		choseElevator<=none;
--	end if;
--end process;
--	elevator1<=el1;
--	elevator2<=el2;
--end Behavioral;


process(clk)
	begin
	if(rising_edge(clk)) then
	if(choseElevator=none) then
		--below finds the closer elevator to currentFloor
		if(abs(to_integer(unsigned(el1))-to_integer(unsigned(currentFloor)))<abs(to_integer(unsigned(el2))-to_integer(unsigned(currentFloor))))then
			choseElevator<=one;
			LED<="00000001";
		else
			choseElevator<=two;
			LED<="00000010";
		end if;
	else
		if(choseElevator=one) then
			if(el1(2 downto 0) = currentFloor or el1Picked=yes) then
			el1Picked<=yes;
				if(el1(2 DOWNTO 0)=wantedFloor) then
					choseElevator<=none;
					wantedFloor1<=wantedFloor1;
					LED<="00000100";
					el1Picked<=no;
				else
					el1Picked<=yes;
					wantedFloor1<=wantedFloor;
					choseElevator<=one;
					LED<="00001000";
				end if;
			else
				el1Picked<=no;
				wantedFloor1<=currentFloor;
				choseElevator<=one;
				LED<="00001000";
			end if;
			
		else--two
			if(el2(2 downto 0) = currentFloor or el2Picked=yes) then
				el2Picked<=yes;
					if(el2(2 DOWNTO 0)=wantedFloor) then
						el2Picked<=no;
						choseElevator<=none;
						wantedFloor2<=wantedFloor2;
						LED<="00010000";
					else
						el2Picked<=yes;
						wantedFloor2<=wantedFloor;
						choseElevator<=two;
						LED<="00100000";
					end if;
			else
				el2Picked<=no;
				wantedFloor2<=currentFloor;
				choseElevator<=two;
				LED<="00001000";
			end if;
		end if;
	end if;
	else
	end if;
end process;
	
	elevator1<=el1;
	elevator2<=el2;
end Behavioral;

