----------------------------------------------------------------------------------
-- Company: 
-- Author: MICHELE DIFRONZO



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
Library UNISIM;
use UNISIM.vcomponents.all;

--! Interface to the Texas Instruments DAC34H84EVM DAC Evaluation Board
entity ODDR_2b is
    Port ( 
			data_out_from_device : in STD_LOGIC_VECTOR ( 1 downto 0 );
			data_out_to_pins_p : out STD_LOGIC_VECTOR ( 0 to 0 );
			data_out_to_pins_n : out STD_LOGIC_VECTOR ( 0 to 0 );
			clk_in : in STD_LOGIC;
			clk_en : in STD_LOGIC;
			io_reset : in STD_LOGIC				
	);
end ODDR_2b;

architecture ARCH of ODDR_2b is


---------------------------------------------------------------------------------------------------
-- SIGNALS AND VARIABLES

signal data_out_to_pins_int : STD_LOGIC_VECTOR (1 downto 0):=(others=>'0'); 
signal data_out_to_pins_predelay : STD_LOGIC_VECTOR (1 downto 0):=(others=>'0'); 
signal clk_in_int_buf       : STD_LOGIC:= '0';
signal clk_in_buf       : STD_LOGIC:= '0';
signal SYS_W       : STD_LOGIC:= '0';
signal clock_enable       : STD_LOGIC:= '0';
--signal t1 : STD_LOGIC;
--signal t2 : STD_LOGIC;
signal data_out_from_device_i : STD_LOGIC_VECTOR ( 1 downto 0 );
---------------------------------------------------------------------------------------------------

begin

   clk_in_buf <= clk_in;
   clock_enable <= clk_en;
   


	-- Input_Register: process
						-- (
							-- clk_in_buf,
							-- clock_enable,
							-- data_out_from_device_i,
							-- data_out_from_device
							
						-- )
	-- BEGIN
		-- IF(rising_edge(clk_in_buf))
			-- THEN
				-- IF(clock_enable='1')
					-- THEN
						-- data_out_from_device_i <= data_out_from_device;
					-- ELSIF(clock_enable ='0') THEN
						-- data_out_from_device_i <= data_out_from_device_i;										
				-- END IF;					
			-- ELSE
				-- data_out_from_device_i <= data_out_from_device_i;	
		-- END IF;
	-- END PROCESS;

data_out_from_device_i <= data_out_from_device;

   ODDRE1_inst : ODDRE1
   generic map(
	  IS_C_INVERTED => '0',       -- Optional inversion for C
      IS_D1_INVERTED => '0',      -- Unsupported, do not use
      IS_D2_INVERTED => '0',      -- Unsupported, do not use
      SIM_DEVICE => "ULTRASCALE_PLUS", -- Set the device version (ULTRASCALE, ULTRASCALE_PLUS, ULTRASCALE_PLUS_ES1,
      SRVAL => '0')   
   port map (
      Q =>  data_out_to_pins_int(0),   
      C =>  clk_in_buf,   
      D1 => data_out_from_device_i(1), 
      D2 => data_out_from_device_i(0),	 
	  SR=>  io_reset
   );

  -- data_out_to_pins_int(0) <= data_out_to_pins_predelay(0);

   pin0_OBUFDS_inst : OBUFDS
   port map (
      O => data_out_to_pins_p(0),   
      OB => data_out_to_pins_n(0), 
      I => data_out_to_pins_int(0)   
   );


 
end ARCH;
