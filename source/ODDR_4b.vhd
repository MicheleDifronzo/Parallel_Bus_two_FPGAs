----------------------------------------------------------------------------------
-- Company: 
-- Engineer: MICHELE DIFRONZO



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
Library UNISIM;
use UNISIM.vcomponents.all;


--! Interface to the Texas Instruments DAC34H84EVM DAC Evaluation Board
entity ODDR_4b is
    Port ( 
			data_out_from_device : in STD_LOGIC_VECTOR ( 29 downto 0 );
			data_out_to_pins_p : out STD_LOGIC_VECTOR ( 14 downto 0 );
			data_out_to_pins_n : out STD_LOGIC_VECTOR ( 14 downto 0 );
			clk_in : in STD_LOGIC;
			clk_en : in STD_LOGIC;
			io_reset : in STD_LOGIC				
	);
end ODDR_4b;

architecture ARCH of ODDR_4b is


---------------------------------------------------------------------------------------------------
-- SIGNALS AND VARIABLES

signal data_out_to_pins_int  : STD_LOGIC_VECTOR (14 downto 0):=(others=>'0'); 
signal clk_in_int_buf     : STD_LOGIC:= '0';
signal clk_out_int_buf    : STD_LOGIC:= '0';
signal clock_enable       : STD_LOGIC:= '0';
signal data_out_from_device_i : STD_LOGIC_VECTOR ( 29 downto 0 );

---------------------------------------------------------------------------------------------------

begin

   clk_out_int_buf <= clk_in;
 

data_out_from_device_i <= data_out_from_device;	
	

ODDR_GEN: for i in data_out_to_pins_int'range generate
    
  pin_ODDRE1_inst : ODDRE1
   generic map(
	  IS_C_INVERTED => '0',       -- Optional inversion for C
      IS_D1_INVERTED => '0',      -- Unsupported, do not use
      IS_D2_INVERTED => '0',      -- Unsupported, do not use
      SIM_DEVICE => "ULTRASCALE_PLUS", -- Set the device version (ULTRASCALE, ULTRASCALE_PLUS, ULTRASCALE_PLUS_ES1,
      SRVAL => '0')   
   port map (
      Q => data_out_to_pins_int(i),  
      C =>  clk_out_int_buf,   
      D1 => data_out_from_device_i(2*i+1),--data_out_from_device_i(0), 
      D2 => data_out_from_device_i(2*i),--data_out_from_device_i(1),	 
	  SR=> io_reset
   );


   pin_OBUFDS_inst : OBUFDS
   port map (   
      O =>  data_out_to_pins_p(i),   
      OB => data_out_to_pins_n(i), 
      I => data_out_to_pins_int(i)   
   ); 	
	
END GENERATE ODDR_GEN;	
	
	


  
  -- pin0_ODDRE1_inst : ODDRE1
   -- generic map(
	  -- IS_C_INVERTED => '0',       -- Optional inversion for C
      -- IS_D1_INVERTED => '0',      -- Unsupported, do not use
      -- IS_D2_INVERTED => '0',      -- Unsupported, do not use
      -- SIM_DEVICE => "ULTRASCALE_PLUS", -- Set the device version (ULTRASCALE, ULTRASCALE_PLUS, ULTRASCALE_PLUS_ES1,
      -- SRVAL => '0')   
   -- port map (
      -- Q => data_out_to_pins_int(0),  
      -- C =>  clk_out_int_buf,   
      -- D1 => data_out_from_device_i(1),--data_out_from_device_i(0), 
      -- D2 => data_out_from_device_i(0),--data_out_from_device_i(1),	 
	  -- SR=> io_reset
   -- );


   -- pin0_OBUFDS_inst : OBUFDS
   -- port map (   
      -- O =>  data_out_to_pins_p(0),   
      -- OB => data_out_to_pins_n(0), 
      -- I => data_out_to_pins_int(0)   
   -- );
		

-- -------------------------------------------------------------------------	
  -- pin1_ODDRE1_inst : ODDRE1
   -- generic map(
	  -- IS_C_INVERTED => '0',       -- Optional inversion for C
      -- IS_D1_INVERTED => '0',      -- Unsupported, do not use
      -- IS_D2_INVERTED => '0',      -- Unsupported, do not use
      -- SIM_DEVICE => "ULTRASCALE_PLUS", -- Set the device version (ULTRASCALE, ULTRASCALE_PLUS, ULTRASCALE_PLUS_ES1,
      -- SRVAL => '0')   
   -- port map (
      -- Q => data_out_to_pins_int(1),  
      -- C =>  clk_out_int_buf,   
      -- D1 => data_out_from_device_i(3),--data_out_from_device_i(2), 
      -- D2 => data_out_from_device_i(2),--data_out_from_device_i(3),	 
	  -- SR=> io_reset
   -- );

	
   -- pin1_OBUFDS_inst : OBUFDS
   -- port map (   
      -- O =>  data_out_to_pins_p(1),   
      -- OB => data_out_to_pins_n(1), 
      -- I => data_out_to_pins_int(1)   
   -- );
   

   
end ARCH;