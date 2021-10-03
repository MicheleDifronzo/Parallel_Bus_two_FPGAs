----------------------------------------------------------------------------------
-- Company: 
-- Engineer: MICHELE DIFRONZO

-- AUTHOR : MICHELE DIFRONZO


--Auto reset process to avoid unexpected bahevior with FIFO

--The following explanation is quoted from XILINX web site:
--https://www.xilinx.com/support/answers/38023.html

-- Asynchronous reset behavior:

-- (Memory Type is Block Ram, Distributed Ram, and Shift RAM)

-- There are two asynchronous reset behaviors available for FIFO configurations:

    -- Full flags reset to 1
    -- Full flags reset to 0 


-- The reset requirements and the behavior of the FIFO is different depending on the full flags reset value chosen. Full flags reset value of 1:

-- FIFO requires a minimum asynchronous reset pulse of 1 write clock period.

-- After reset is deasserted, Full flags deassert after 3 clock periods (wr_clk) and the FIFO is now ready for writing.

-- So wr_en and rd_en cannot be asserted when reset is asserted in order to avoid unexpected behavior.
-- Full flags reset value of 0:

-- FIFO requires a minimum asynchronous reset pulse of 1 write clock period.

-- Wr_en can be asserted approximately three clock cycles after the assertion of asynchronous reset.

-- Overflow and underflow will be de-asserted after reset.


-- Asynchronous reset behavior (Memory Type is Built-in FIFO)

-- Built-In FIFOs require an asynchronous reset pulse of at least 3 read and write clock cycles.

-- During reset, wr_en and rd_en cannot be asserted.

-- Wr_en can be asserted after asynchronous reset is released.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
Library UNISIM;
use UNISIM.vcomponents.all;

--! Interface to the Texas Instruments DAC34H84EVM DAC Evaluation Board
entity AutoReset is
    Port ( 
			CLOCK 		: IN  std_logic;
			RESET  : OUT  std_logic     		
	);
end AutoReset;

architecture ARCH of AutoReset is


---------------------------------------------------------------------------------------------------
-- SIGNALS AND VARIABLES



---------------------------------------------------------------------------------------------------



BEGIN

	AUTO_RESET_PROCESS: process
				(
					CLOCK
				)
	variable counter: integer range 0 to 300:= 0;
	variable reset_i: std_logic := '1';
	
	BEGIN	
		if(rising_edge(CLOCK))
			then	

				if(counter < 100) -- to count the exten of each reset cycle
					then
						reset_i:= '1';	
						counter := counter+1;						
					elsif(counter>=100) then
						reset_i:= '0';	
						counter := 101;						
				end if;						
		end if;		
        RESET<= reset_i ;
	END PROCESS;


	-- AUTO_RESET_PROCESS: process
				-- (
					-- CLOCK
				-- )
	-- variable counter: integer range 0 to 300:= 0;
	-- variable cycle_counter: integer range 0 to 6:= 0;
	-- variable reset_i: std_logic := '1';
	
	-- BEGIN	
		-- if(rising_edge(CLOCK))
			-- then	
				-- if(cycle_counter < 12)   --to count the number of reset cycles 
					-- then					
						-- if(counter < 100) -- to count the exten of each reset cycle
							-- then
								-- reset_i:= '1';								
							-- elsif(counter>=100 and counter < 200) then
								-- reset_i:= '0';								
							-- elsif(counter>= 200) then	
								-- counter := 0;
								-- cycle_counter:= cycle_counter+1;
						-- end if;						
						-- counter := counter+1;
				-- end if;					
			
		-- end if;	
		
        -- RESET<= reset_i ;
	-- END PROCESS;

end ARCH;
