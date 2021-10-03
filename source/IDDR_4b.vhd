----------------------------------------------------------------------------------
-- Company: 
-- Author: MICHELE DIFRONZO



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
Library UNISIM;
use UNISIM.vcomponents.all;


entity IDDR_4b is
    Port ( 

			data_in_from_pins_p : in  std_logic_vector(14 downto 0);
			data_in_from_pins_n : in  std_logic_vector(14 downto 0);
			data_in_to_device   : out std_logic_vector(29 downto 0);
			-- Clock and reset signals
			clk_in                  : in  std_logic;                    -- Fast clock from PLL/MMCM 
			clk_en                  : in  std_logic;    
			io_reset                : in  std_logic                   -- Reset signal for IO circuit		
		 );
end IDDR_4b;

architecture ARCH of IDDR_4b is


---------------------------------------------------------------------------------------------------
-- SIGNALS AND VARIABLES



signal clk_in_buf       : STD_LOGIC:= '0';
-- signal SYS_W       : STD_LOGIC;
signal clock_enable       : STD_LOGIC:= '0';
signal Datareg       : STD_LOGIC_VECTOR (14 downto 0);

---------------------------------------------------------------------------------------------------

begin

   clk_in_buf <= clk_in;
   clock_enable <= clk_en;
   

   
   
IDDR_GEN: for i in Datareg'range generate
    
   pin_IBUFDS_inst : IBUFDS
   generic map (
      DQS_BIAS => "FALSE"  -- (FALSE, TRUE)
   )
   port map (
      O => Datareg(i),   -- 1-bit output: Buffer output
      I => data_in_from_pins_p(i),   -- 1-bit input: Diff_p buffer input (connect directly to top-level port)
      IB => data_in_from_pins_n(i)  -- 1-bit input: Diff_n buffer input (connect directly to top-level port)
   );



   pin0_IDDRE1_inst : IDDRE1
   generic map (
      DDR_CLK_EDGE => "OPPOSITE_EDGE", -- IDDRE1 mode (OPPOSITE_EDGE, SAME_EDGE, SAME_EDGE_PIPELINED)
      IS_CB_INVERTED => '1',           -- Optional inversion for CB
      IS_C_INVERTED => '0'             -- Optional inversion for C
   )
   port map (
      Q1 => data_in_to_device(2*i+1), -- was (2*i+1) -- 1-bit output: Registered parallel output 1
      Q2 => data_in_to_device(2*i), -- was (2*i) 1-bit output: Registered parallel output 2
      C => clk_in_buf,   -- 1-bit input: High-speed clock
      CB => clk_in_buf, -- 1-bit input: Inversion of High-speed clock C
      D => Datareg(i),   -- 1-bit input: Serial Data Input
      R => io_reset    -- 1-bit input: Active High Async Reset
   );
	
	
end generate IDDR_GEN;   
   
   
   
   
   

   
   
   
 ----PIN(0)---------------------------------------------------------------------------
   


   -- pin0_IBUFDS_inst : IBUFDS
   -- generic map (
      -- DQS_BIAS => "FALSE"  -- (FALSE, TRUE)
   -- )
   -- port map (
      -- O => Datareg(0),   -- 1-bit output: Buffer output
      -- I => data_in_from_pins_p(0),   -- 1-bit input: Diff_p buffer input (connect directly to top-level port)
      -- IB => data_in_from_pins_n(0)  -- 1-bit input: Diff_n buffer input (connect directly to top-level port)
   -- );



   -- pin0_IDDRE1_inst : IDDRE1
   -- generic map (
      -- DDR_CLK_EDGE => "OPPOSITE_EDGE", -- IDDRE1 mode (OPPOSITE_EDGE, SAME_EDGE, SAME_EDGE_PIPELINED)
      -- IS_CB_INVERTED => '1',           -- Optional inversion for CB
      -- IS_C_INVERTED => '0'             -- Optional inversion for C
   -- )
   -- port map (
      -- Q1 => data_in_to_device(0), -- 1-bit output: Registered parallel output 1
      -- Q2 => data_in_to_device(1), -- 1-bit output: Registered parallel output 2
      -- C => clk_in_buf,   -- 1-bit input: High-speed clock
      -- CB => clk_in_buf, -- 1-bit input: Inversion of High-speed clock C
      -- D => Datareg(0),   -- 1-bit input: Serial Data Input
      -- R => io_reset    -- 1-bit input: Active High Async Reset
   -- );
 -- ----PIN(1)---------------------------------------------------------------------------
   


   -- pin1_IBUFDS_inst : IBUFDS
   -- generic map (
      -- DQS_BIAS => "FALSE"  -- (FALSE, TRUE)
   -- )
   -- port map (
      -- O => Datareg(1),   -- 1-bit output: Buffer output
      -- I => data_in_from_pins_p(1),   -- 1-bit input: Diff_p buffer input (connect directly to top-level port)
      -- IB => data_in_from_pins_n(1)  -- 1-bit input: Diff_n buffer input (connect directly to top-level port)
   -- );


   -- pin1_IDDRE1_inst : IDDRE1
   -- generic map (
      -- DDR_CLK_EDGE => "OPPOSITE_EDGE", -- IDDRE1 mode (OPPOSITE_EDGE, SAME_EDGE, SAME_EDGE_PIPELINED)
      -- IS_CB_INVERTED => '1',           -- Optional inversion for CB
      -- IS_C_INVERTED => '0'             -- Optional inversion for C
   -- )
   -- port map (
      -- Q1 => data_in_to_device(2), -- 1-bit output: Registered parallel output 1
      -- Q2 => data_in_to_device(3), -- 1-bit output: Registered parallel output 2
      -- C => clk_in_buf,   -- 1-bit input: High-speed clock
      -- CB => clk_in_buf, -- 1-bit input: Inversion of High-speed clock C
      -- D => Datareg(1),   -- 1-bit input: Serial Data Input
      -- R => io_reset    -- 1-bit input: Active High Async Reset
   -- );

end ARCH;
