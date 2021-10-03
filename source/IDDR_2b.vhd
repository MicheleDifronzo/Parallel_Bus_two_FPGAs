----------------------------------------------------------------------------------
-- Company: 
-- Author: MICHELE DIFRONZO



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
Library UNISIM;
use UNISIM.vcomponents.all;

--! Interface to the Texas Instruments DAC34H84EVM DAC Evaluation Board
entity IDDR_2b is
    Port ( 
			data_in_from_pins_p : in  std_logic_vector(0 downto 0);
			data_in_from_pins_n : in  std_logic_vector(0 downto 0);
			data_in_to_device   : out std_logic_vector(1 downto 0);
			-- Clock and reset signals
			clk_in                  : in  std_logic;                    -- Fast clock from PLL/MMCM 
			clk_en                  : in  std_logic;    
			io_reset                : in  std_logic     		
	);
end IDDR_2b;

architecture ARCH of IDDR_2b is


---------------------------------------------------------------------------------------------------
-- SIGNALS AND VARIABLES

signal clk_in_buf       : STD_LOGIC;
-- signal SYS_W       : STD_LOGIC;
signal clock_enable       : STD_LOGIC;
signal Datareg       : STD_LOGIC_VECTOR (0 downto 0);
signal Datareg_i       : STD_LOGIC_VECTOR (0 downto 0);
---------------------------------------------------------------------------------------------------

begin


clk_in_buf<=clk_in;

   pin0_IBUFDS_inst : IBUFDS
   generic map (
      DQS_BIAS => "FALSE"  -- (FALSE, TRUE)
   )
   port map (
      O => Datareg(0),   -- 1-bit output: Buffer output
      I => data_in_from_pins_p(0),   -- 1-bit input: Diff_p buffer input (connect directly to top-level port)
      IB => data_in_from_pins_n(0)  -- 1-bit input: Diff_n buffer input (connect directly to top-level port)
   );


	-- Input_Register_0: process
						-- (
							-- clk_in_buf,
							-- clock_enable,
							-- Datareg_i,
							-- Datareg
							
						-- )
	-- BEGIN
		-- IF(rising_edge(clk_in_buf))
			-- THEN
				-- IF(clock_enable='1')
					-- THEN
						-- Datareg_i(0) <= Datareg(0);
					-- ELSIF(clock_enable ='0') THEN
						-- Datareg_i(0) <= Datareg_i(0);										
				-- END IF;					

		-- END IF;
	-- END PROCESS;   
 

 Datareg_i(0) <= Datareg(0);
 
 
   pin0_IDDRE1_inst : IDDRE1
   generic map (
      DDR_CLK_EDGE => "OPPOSITE_EDGE", -- IDDRE1 mode (OPPOSITE_EDGE, SAME_EDGE, SAME_EDGE_PIPELINED)
      IS_CB_INVERTED => '1',           -- Optional inversion for CB
      IS_C_INVERTED => '0'             -- Optional inversion for C
   )
   port map (
      Q1 => data_in_to_device(1), -- 1-bit output: Registered parallel output 1
      Q2 => data_in_to_device(0), -- 1-bit output: Registered parallel output 2
      C => clk_in_buf,   -- 1-bit input: High-speed clock
      CB => clk_in_buf, -- 1-bit input: Inversion of High-speed clock C
      D => Datareg_i(0),   -- 1-bit input: Serial Data Input
      R => io_reset    -- 1-bit input: Active High Async Reset
   );
 
end ARCH;
