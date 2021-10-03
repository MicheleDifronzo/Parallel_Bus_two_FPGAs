----------------------------------------------------------------------------------
-- Company: 
-- Engineer: MICHELE DIFRONZO

-- AUTHOR : MICHELE DIFRONZO


--TWO STAGES SYNCHRONIZER FOR CLOCK DOMAIN CROSSING


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
Library UNISIM;
use UNISIM.vcomponents.all;

--! Interface to the Texas Instruments DAC34H84EVM DAC Evaluation Board
entity Two_Stages_Synchronizer is
    Port ( 

			DESTINATION_CLOCK  : IN  STD_LOGIC;     		
			INPUT_DATA  : IN  STD_LOGIC_VECTOR(89 downto 0);     		
			OUTPUT_DATA  : OUT  STD_LOGIC_VECTOR(89 downto 0)     		
	);
end Two_Stages_Synchronizer;

architecture ARCH of Two_Stages_Synchronizer is


---------------------------------------------------------------------------------------------------
-- SIGNALS AND VARIABLES



---------------------------------------------------------------------------------------------------

signal first_stage_data  :   STD_LOGIC_VECTOR(89 downto 0);  


BEGIN


	STAGE_NR: process
				(
					DESTINATION_CLOCK,
					INPUT_DATA,
					first_stage_data
				)	
	BEGIN	
		if(rising_edge(DESTINATION_CLOCK))
			then
				first_stage_data <= INPUT_DATA;  ---first stage
				OUTPUT_DATA <= first_stage_data;  --second stage
		end if;	
		
	END PROCESS;

END ARCH;
