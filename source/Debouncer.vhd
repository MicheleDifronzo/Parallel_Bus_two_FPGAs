----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/01/2019 02:52:17 PM
-- Design Name: 
-- Module Name: MasterTopLevel - Behavioral
-- Project Name: Pbus
-- Author: Michele Difronzo
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

library xil_defaultlib;



entity Debouncer is
		Port( 
			  clk_in : in STD_LOGIC;
			  start : in STD_LOGIC;
			  reset : in STD_LOGIC;		
			  begin_run : out STD_LOGIC		
			);
end Debouncer;



architecture Behavioral of Debouncer is


signal begin_run_i          : std_logic := '0'; --! triggers logic to run


begin


	begin_run<=begin_run_i;

  debounce_begin_run: process(clk_in, start, reset) -- <--- CHECK what clock should be used for "user_clk"  	
	variable hystersis : std_logic := '0';
	
	begin
		if(rising_edge(clk_in) ) then
		
				if(reset = '1') then
						begin_run_i <= '0';
						hystersis := '0';
				else
					if(start = '1' and hystersis = '0') then
						hystersis := '1';
					else
						hystersis := hystersis;
					end if;
					
					if(hystersis = '1') then
						begin_run_i <= '1';
					else
						begin_run_i <= begin_run_i;
					end if;
				end if;							
		end if;
	end process;
	
end Behavioral;
