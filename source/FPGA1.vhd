----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/01/2019 02:52:17 PM
-- Design Name: 
-- Module Name: MasterTopLevel - Behavioral
-- Project Name: MULTI FPGA SYSTEM LEVEL HIL SIMULATOR
-- Author: MICHELE DIFRONZO
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
--LEGEND:
--------
--SE = single ended
--DDR=dual data rate
--LVDS = low voltage differential standard
--FSM = finite state machine
--clk = clock





library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;
library xil_defaultlib;

entity FPGA1 is  --old name was "MasterTopLevel
		Port ( 
		--on the Master this 2 ports are connected to the system clock (300MHz)
				USER_SMA_CLOCK_P : in std_logic;--<-- gahters the reference clock signal from the Clock Generator (external device) through SMA port
				USER_SMA_CLOCK_N : in std_logic;--<-- gahters the reference state signal from the Clock Generator (external device) through SMA port									
				-----LVDS I/O FMC PORTS	
				FMC_HPC1_LA00_CC_P : out STD_LOGIC;    
				FMC_HPC1_LA01_CC_P : out STD_LOGIC; 	
				FMC_HPC1_LA02_P    : out STD_LOGIC; 	
				FMC_HPC1_LA03_P    : out STD_LOGIC; 	
				FMC_HPC1_LA04_P    : out STD_LOGIC; 				
				FMC_HPC1_LA05_P    : out STD_LOGIC; 				
				FMC_HPC1_LA06_P    : out STD_LOGIC; 
				FMC_HPC1_LA07_P    : out STD_LOGIC; 
				FMC_HPC1_LA08_P    : out STD_LOGIC; 	
				FMC_HPC1_LA09_P    : out STD_LOGIC; 
				FMC_HPC1_LA10_P    : out STD_LOGIC; 
				FMC_HPC1_LA11_P    : out STD_LOGIC; 		
				FMC_HPC1_LA12_P    : out STD_LOGIC; 
				FMC_HPC1_LA13_P    : out STD_LOGIC; 
				FMC_HPC1_LA14_P    : out STD_LOGIC; 
				FMC_HPC1_LA15_P    : out STD_LOGIC; 
				FMC_HPC1_LA16_P    : out STD_LOGIC; 
				FMC_HPC1_LA17_CC_P : in STD_LOGIC; 
				FMC_HPC1_LA18_CC_P : in STD_LOGIC;
				FMC_HPC1_LA19_P    : in STD_LOGIC; 
				FMC_HPC1_LA20_P    : in STD_LOGIC;	
				FMC_HPC1_LA21_P    : in STD_LOGIC; 	
				FMC_HPC1_LA22_P    : in STD_LOGIC;
				FMC_HPC1_LA23_P    : in STD_LOGIC;
				FMC_HPC1_LA24_P    : in STD_LOGIC;
				FMC_HPC1_LA25_P    : in STD_LOGIC;
				FMC_HPC1_LA26_P    : in STD_LOGIC;
				FMC_HPC1_LA27_P    : in STD_LOGIC;
				FMC_HPC1_LA28_P    : in STD_LOGIC;	
				FMC_HPC1_LA29_P    : in STD_LOGIC;
				FMC_HPC1_LA30_P	   : in STD_LOGIC;
				FMC_HPC1_LA31_P    : in STD_LOGIC;
				FMC_HPC1_LA32_P    : in STD_LOGIC;
				FMC_HPC1_LA33_P    : in STD_LOGIC;
				
				FMC_HPC1_LA00_CC_N : out STD_LOGIC; 
				FMC_HPC1_LA01_CC_N : out STD_LOGIC; 	
				FMC_HPC1_LA02_N    : out STD_LOGIC; 	
				FMC_HPC1_LA03_N    : out STD_LOGIC; 	
				FMC_HPC1_LA04_N    : out STD_LOGIC; 				
				FMC_HPC1_LA05_N    : out STD_LOGIC; 				
				FMC_HPC1_LA06_N    : out STD_LOGIC; 
				FMC_HPC1_LA07_N    : out STD_LOGIC; 
				FMC_HPC1_LA08_N    : out STD_LOGIC; 	
				FMC_HPC1_LA09_N    : out STD_LOGIC; 
				FMC_HPC1_LA10_N    : out STD_LOGIC; 
				FMC_HPC1_LA11_N    : out STD_LOGIC; 		
				FMC_HPC1_LA12_N    : out STD_LOGIC; 
				FMC_HPC1_LA13_N    : out STD_LOGIC; 
				FMC_HPC1_LA14_N    : out STD_LOGIC; 
				FMC_HPC1_LA15_N    : out STD_LOGIC; 
				FMC_HPC1_LA16_N    : out STD_LOGIC; 
				FMC_HPC1_LA17_CC_N : in STD_LOGIC; 
				FMC_HPC1_LA18_CC_N : in STD_LOGIC;
				FMC_HPC1_LA19_N    : in STD_LOGIC; 
				FMC_HPC1_LA20_N    : in STD_LOGIC;	
				FMC_HPC1_LA21_N    : in STD_LOGIC; 	
				FMC_HPC1_LA22_N    : in STD_LOGIC;
				FMC_HPC1_LA23_N    : in STD_LOGIC;
				FMC_HPC1_LA24_N    : in STD_LOGIC;
				FMC_HPC1_LA25_N    : in STD_LOGIC;
				FMC_HPC1_LA26_N    : in STD_LOGIC;
				FMC_HPC1_LA27_N    : in STD_LOGIC;
				FMC_HPC1_LA28_N    : in STD_LOGIC;	
				FMC_HPC1_LA29_N    : in STD_LOGIC;
				FMC_HPC1_LA30_N	   : in STD_LOGIC;
				FMC_HPC1_LA31_N    : in STD_LOGIC;
				FMC_HPC1_LA32_N    : in STD_LOGIC;
				FMC_HPC1_LA33_N    : in STD_LOGIC;	
				
				--------------------------------------------
				--		TI-DAC FMC PORTS
				--------------------------------------------
				FMCP_HSPC_CLK0_M2C_P : in STD_LOGIC; --!  dac_clk_to_device_p
				FMCP_HSPC_CLK0_M2C_N : in STD_LOGIC; --!  dac_clk_to_device_n
				FMCP_HSPC_LA18_CC_P : out STD_LOGIC; --!  data_clk_to_dac_p
				FMCP_HSPC_LA18_CC_N : out STD_LOGIC; --!  data_clk_to_dac_n				
						-- dac outputs (LVDS, DDR)   ----J2 VITA 57.1 FMC HPC1 Connections, pag 96 VCU118 User Guide-
							
						---channel AB    --I/O STANDARD: LVDS
				FMCP_HSPC_LA24_P  : out STD_LOGIC; --! AP13
				FMCP_HSPC_LA24_N  : out STD_LOGIC; --! AR13
				FMCP_HSPC_LA21_P  : out STD_LOGIC; --! AU11
				FMCP_HSPC_LA21_N  : out STD_LOGIC; --! AV11
				FMCP_HSPC_LA19_P  : out STD_LOGIC; --! AW12
				FMCP_HSPC_LA19_N  : out STD_LOGIC; --! AY12
				FMCP_HSPC_LA15_P  : out STD_LOGIC; --! BB16
				FMCP_HSPC_LA15_N  : out STD_LOGIC; --! BC16
				FMCP_HSPC_LA11_P  : out STD_LOGIC; --! BA16
				FMCP_HSPC_LA11_N  : out STD_LOGIC; --! BA15
				FMCP_HSPC_LA07_P  : out STD_LOGIC; --! BC15
				FMCP_HSPC_LA07_N  : out STD_LOGIC; --! BD15
				FMCP_HSPC_LA04_P  : out STD_LOGIC; --! BF12
				FMCP_HSPC_LA04_N  : out STD_LOGIC; --! BF11
				FMCP_HSPC_LA02_P  : out STD_LOGIC; --! BC11
				FMCP_HSPC_LA02_N  : out STD_LOGIC; --! BD11
				FMCP_HSPC_LA33_P  : out STD_LOGIC; --! AK14
				FMCP_HSPC_LA33_N  : out STD_LOGIC; --! AK13
				FMCP_HSPC_LA31_P  : out STD_LOGIC; --! AM13
				FMCP_HSPC_LA31_N  : out STD_LOGIC; --! AM12
				FMCP_HSPC_LA29_P  : out STD_LOGIC; --! AN15
				FMCP_HSPC_LA29_N  : out STD_LOGIC; --! AP15
				FMCP_HSPC_LA25_P  : out STD_LOGIC; --! AT12
				FMCP_HSPC_LA25_N  : out STD_LOGIC; --! AU12
				FMCP_HSPC_LA22_P  : out STD_LOGIC; --! AW13
				FMCP_HSPC_LA22_N  : out STD_LOGIC; --! AY13
				FMCP_HSPC_LA20_P  : out STD_LOGIC; --! AW11
				FMCP_HSPC_LA20_N  : out STD_LOGIC; --! AY10
				FMCP_HSPC_LA16_P  : out STD_LOGIC; --! AV9
				FMCP_HSPC_LA16_N  : out STD_LOGIC; --! AV8
				FMCP_HSPC_LA12_P  : out STD_LOGIC; --! BC14
				FMCP_HSPC_LA12_N  : out STD_LOGIC; --! BC13  
				
				-- -- channel CD  --  	
				FMCP_HSPC_LA06_P  	 : out STD_LOGIC; --! BD13 
				FMCP_HSPC_LA06_N  	 : out STD_LOGIC; --! BE13
				FMCP_HSPC_LA10_P  	 : out STD_LOGIC; --! BB13
				FMCP_HSPC_LA10_N  	 : out STD_LOGIC; --! BB12
				FMCP_HSPC_LA14_P  	 : out STD_LOGIC; --! AW8
				FMCP_HSPC_LA14_N  	 : out STD_LOGIC; --! AW7
				FMCP_HSPC_LA27_P  	 : out STD_LOGIC; --! AL14
				FMCP_HSPC_LA27_N  	 : out STD_LOGIC; --! AM14
				FMCP_HSPC_LA01_CC_P   : out STD_LOGIC; --! BF10
				FMCP_HSPC_LA01_CC_N   : out STD_LOGIC; --! BF9
				FMCP_HSPC_LA05_P  	 : out STD_LOGIC; --! BE14
				FMCP_HSPC_LA05_N  	 : out STD_LOGIC; --! BF14
				FMCP_HSPC_LA09_P  	 : out STD_LOGIC; --! BA14
				FMCP_HSPC_LA09_N  	 : out STD_LOGIC; --! BB14
				FMCP_HSPC_LA13_P  	 : out STD_LOGIC; --! AY8
				FMCP_HSPC_LA13_N  	 : out STD_LOGIC; --! AY7
				FMCP_HSPC_LA17_CC_P   : out STD_LOGIC; --! AR14
				FMCP_HSPC_LA17_CC_N   : out STD_LOGIC; --! AT14
				FMCP_HSPC_LA23_P  	 : out STD_LOGIC; --! AN16
				FMCP_HSPC_LA23_N  	 : out STD_LOGIC; --! AP16
				FMCP_HSPC_LA26_P  	 : out STD_LOGIC; --! AK15
				FMCP_HSPC_LA26_N  	 : out STD_LOGIC; --! AL15
				FMCP_HSPC_LA00_CC_P   : out STD_LOGIC; --! AY9
				FMCP_HSPC_LA00_CC_N   : out STD_LOGIC; --! BA9
				FMCP_HSPC_LA03_P  	 : out STD_LOGIC; --! BD12
				FMCP_HSPC_LA03_N  	 : out STD_LOGIC; --! BE12
				FMCP_HSPC_LA08_P  	 : out STD_LOGIC; --! BE15
				FMCP_HSPC_LA08_N  	 : out STD_LOGIC;  --! BF15
				-------Push Buttons
				GPIO_SW_N: in std_logic;	
				GPIO_SW_C:	in std_logic					
			);
end FPGA1;


---------------------------------------------------------------------------------------------------
architecture Behavioral of FPGA1 is
---------------------------------------------------------------------------------------------------
component MasterClockManager
port
(
	data_clk_0deg:  out std_logic;  
	data_clk_90deg:  out std_logic;  
	sim_clk:  out std_logic;  
	--Clock in ports
	clk_in1: in std_logic 
);
end component;

component IncomingClockManager  
	Port
	(  
		--Clock in ports
		clk_out1:  out std_logic;    --< the clock manager induces 0deg on this signal since this signal has already been phase shifted on the other fpga
		--Clock in ports
		clk_in1_p: in std_logic;         --name in virtex: sys_data_clk_90deg_p
		clk_in1_n: in std_logic          --name in virtex: sys_data_clk_90deg_n
	);	
end component;
	
component ParallelBusInterface
port
(
	--reset	
	reset_from_device       : in std_logic; --! reset for parallel bus interface
	
	--sender side from device	
	data_clk_0_from_device  : in std_logic; --! data clock (0deg) for sending data
	data_clk_90_from_device : in std_logic; --! data clock (90deg) to forward to another device (source synchronous)	
	data_to_send_from_device : in std_logic_vector(89 downto 0);--(89 downto 0); --! data to send from device to another device
	start_send_from_device   : in std_logic;                     --! pulsed start flag to trigger sending data from device to another device	
	--sender side to I/O	
	oddr_input_send_to_io  : out std_logic_vector(29 downto 0);--(29 downto 0); --! sent data packet bus to be sent to another device, going to input of an I/O output register for sender
	ce_oddr_send_to_io     : out std_logic;                     --! Clock enable going to CE of an I/O output register for sender
	data_clk_90_send_to_io : out std_logic;                     --! forwarded 90deg data clock to be sent to another device, going to clock of an I/O output register for sender
	incoming_send_to_io    : out std_logic;                     --! sent data incoming flag to be sent to another device, going to input of an I/O output register for sender
	READY: out std_logic;
	--receiver side to/from I/O	
	ce_iddr_recv_to_io : out std_logic;                               --! Clock enable going to CE of I/O input register for receiver
	iddr_output_recv_from_io      : in std_logic_vector(29 downto 0);--(29 downto 0); --! received data packet bus from another device, coming from output of an I/O input register for receiver
	incoming_recv_from_io         : in std_logic;                     --! received data incoming flag from another device, coming from output of an I/O input buffer for receiver
	data_clk_forward_recv_from_io : in std_logic;                     --! received forwarded (90deg+delay) data clock from another device, coming from output of an I/O input (clock capable) buffer for receiver
	--receiver side to device
	data_recv_to_device             : out std_logic_vector(89 downto 0);--(89 downto 0); --! data received from another device
	data_valid_recv_to_device       : out std_logic;                     --! data valid flag indicating received data is valid to read
	data_clk_forward_recv_to_device : out std_logic                     --! forwarded data clock (90deg+delay) from another device
     
);
end component;

---------------------------------------------------------------------------------------------------------

component IDDR_2b
port
(
	data_in_from_pins_p     : in  std_logic_vector(0 downto 0);
	data_in_from_pins_n     : in  std_logic_vector(0 downto 0);
	data_in_to_device       : out std_logic_vector(1 downto 0);
	-- Clock and reset signals
	clk_in                  : in  std_logic;                    -- Fast clock from PLL/MMCM 
	clk_en                  : in  std_logic;    
	io_reset                : in  std_logic                   -- Reset signal for IO circuit	
);
end component;

component IDDR_4b
port
(
	data_in_from_pins_p     : in  std_logic_vector(14 downto 0);
	data_in_from_pins_n     : in  std_logic_vector(14 downto 0);
	data_in_to_device       : out std_logic_vector(29 downto 0);
	-- Clock and reset signals
	clk_in                  : in  std_logic;                    -- Fast clock from PLL/MMCM 
	clk_en                  : in  std_logic;    
	io_reset                : in  std_logic                   -- Reset signal for IO circuit
);
end component;
---------------------------------------------------------------------------------------------------------

component ODDR_2b
port
(
	data_out_from_device : in STD_LOGIC_VECTOR ( 1 downto 0 );
	data_out_to_pins_p : out STD_LOGIC_VECTOR ( 0 to 0 );
	data_out_to_pins_n : out STD_LOGIC_VECTOR ( 0 to 0 );
	clk_in : in STD_LOGIC;
	clk_en : in STD_LOGIC;
	io_reset : in STD_LOGIC	
);
end component;


component ODDR_4b 
    port ( 
			data_out_from_device : in STD_LOGIC_VECTOR ( 29 downto 0 );
			data_out_to_pins_p : out STD_LOGIC_VECTOR ( 14 downto 0 );
			data_out_to_pins_n : out STD_LOGIC_VECTOR ( 14 downto 0 );
			clk_in : in STD_LOGIC;
			clk_en : in STD_LOGIC;
			io_reset : in STD_LOGIC			
	);
end component;






component AutoReset
port
(
			CLOCK 		: IN  std_logic;
			RESET  : OUT  std_logic   
);
end component;
---------------------------------------------------------------------------------------------------------

-- component SimulationEngine 
    -- port ( 
			  -- clk_in 		: in STD_LOGIC; --simulation clock 50ns			  
			  -- ref_clk_in 	: in STD_LOGIC; --ref clock 5ns			  
			  -- start 		: in STD_LOGIC;			  
			  -- data_in 		: in STD_LOGIC_VECTOR ( 89 downto 0 );--4bits counter		  		  
			  -- data_out 		   : out STD_LOGIC_VECTOR ( 89 downto 0 );		  
			  -- data_out_past 		   : out STD_LOGIC_VECTOR ( 89 downto 0 );	
			  -- ErrorDetector: out STD_LOGIC;
			  -- ErrorCounter: out STD_LOGIC_VECTOR ( 7 downto 0 )		 );
-- end component;

component toplevel_core_B
		Port( 
				ap_clk : IN STD_LOGIC;
				ap_rst : IN STD_LOGIC;
				ap_start : IN STD_LOGIC;
				ap_done : OUT STD_LOGIC;
				ap_idle : OUT STD_LOGIC;
				ap_ready : OUT STD_LOGIC;
				x_out_b_0_V : OUT STD_LOGIC_VECTOR (71 downto 0);
				x_out_b_1_V : OUT STD_LOGIC_VECTOR (71 downto 0);
				port_current_injection_from_b_to_a_V : OUT STD_LOGIC_VECTOR (71 downto 0);
				port_current_injection_from_b_to_a_V_ap_vld : OUT STD_LOGIC;
				i_in_port_from_a_V : IN STD_LOGIC_VECTOR (71 downto 0);
				V1out_dab1_V : OUT STD_LOGIC_VECTOR (71 downto 0);
				V2out_dab1_V : OUT STD_LOGIC_VECTOR (71 downto 0);
				I1out_dab1_V : OUT STD_LOGIC_VECTOR (71 downto 0);
				I2out_dab1_V : OUT STD_LOGIC_VECTOR (71 downto 0);
				I3out_dab1_V : OUT STD_LOGIC_VECTOR (71 downto 0);
				Vpout_dab1_V : OUT STD_LOGIC_VECTOR (71 downto 0);
				Vsout_dab1_V : OUT STD_LOGIC_VECTOR (71 downto 0);
				dac_a_V : OUT STD_LOGIC_VECTOR (15 downto 0);
				dac_a_V_ap_vld : OUT STD_LOGIC;
				dac_b_V : OUT STD_LOGIC_VECTOR (15 downto 0);
				dac_b_V_ap_vld : OUT STD_LOGIC;
				dac_c_V : OUT STD_LOGIC_VECTOR (15 downto 0);
				dac_c_V_ap_vld : OUT STD_LOGIC;
				dac_d_V : OUT STD_LOGIC_VECTOR (15 downto 0);
				dac_d_V_ap_vld : OUT STD_LOGIC 	
			);
end component;


COMPONENT TWO_STAGES_SYNCHRONIZER 
    Port ( 

			DESTINATION_CLOCK  : IN  STD_LOGIC;     		
			INPUT_DATA  : IN  STD_LOGIC_VECTOR(89 downto 0);     		
			OUTPUT_DATA  : OUT  STD_LOGIC_VECTOR(89 downto 0)     		
	);
END COMPONENT;

COMPONENT FIFO_90bit
  PORT (
			rst : IN STD_LOGIC;
			wr_clk : IN STD_LOGIC;
			rd_clk : IN STD_LOGIC;
			din : IN STD_LOGIC_VECTOR(89 DOWNTO 0);
			wr_en : IN STD_LOGIC;
			rd_en : IN STD_LOGIC;
			dout : OUT STD_LOGIC_VECTOR(89 DOWNTO 0);
			full : OUT STD_LOGIC;
			empty : OUT STD_LOGIC;
			valid : OUT STD_LOGIC;
			wr_rst_busy : OUT STD_LOGIC;
			rd_rst_busy : OUT STD_LOGIC
  );
END COMPONENT;

component DAC34H84Interface is
    Port ( 
		if_reset : in STD_LOGIC;	--! active high reset for interface; does NOT affect the DAC board
		
		a_from_device : in STD_LOGIC_VECTOR (15 downto 0);	--! channel A data from device; 2's complement or offset binary
		b_from_device : in STD_LOGIC_VECTOR (15 downto 0);	--! channel B data from device; 2's complement or offset binary
		c_from_device : in STD_LOGIC_VECTOR (15 downto 0);	--! channel C data from device; 2's complement or offset binary
		d_from_device : in STD_LOGIC_VECTOR (15 downto 0);	--! channel D data from device; 2's complement or offset binary
		
		dac_clk_to_device_p : in STD_LOGIC;	--! clock sourced from DAC board (LVDS)
		dac_clk_to_device_n : in STD_LOGIC;	--! clock sourced from DAC board (LVDS)
		dac_clk_to_device : out STD_LOGIC;	--! clock sourced from DAC board (Single Ended)
		data_clk_to_dac_p : out STD_LOGIC;	--! clock to DAC board to clock in data (LVDS)
		data_clk_to_dac_n : out STD_LOGIC;	--! clock to DAC board to clock in data (LVDS)
		data_clk_to_dac_e : out STD_LOGIC;	--! clock to DAC board to clock in data (Single Ended)
		
		ab_to_dac_p : out STD_LOGIC_VECTOR (15 downto 0);	--! channel AB data to DAC (DDR, LVDS)
		ab_to_dac_n : out STD_LOGIC_VECTOR (15 downto 0);	--! channel AB data to DAC (DDR, LVDS)
		cd_to_dac_p : out STD_LOGIC_VECTOR (15 downto 0);	--! channel CD data to DAC (DDR, LVDS)
		cd_to_dac_n : out STD_LOGIC_VECTOR (15 downto 0)	--! channel CD data to DAC (DDR, LVDS)
	);
end component;





COMPONENT ila_0

PORT (
	clk : IN STD_LOGIC;



	probe0 : IN STD_LOGIC_VECTOR(0 DOWNTO 0); 
	probe1 : IN STD_LOGIC_VECTOR(89 downto 0); 
	probe2 : IN STD_LOGIC_VECTOR(0 DOWNTO 0); 
	probe3 : IN STD_LOGIC_VECTOR(89 downto 0); 
	probe4 : IN STD_LOGIC_VECTOR(89 downto 0); 
	probe5 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
	probe6 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	probe7 : IN STD_LOGIC_VECTOR(0 DOWNTO 0)
);
END COMPONENT  ;

-------------------------------------------------------------------------------------

signal flag_in_packet_vec       :  std_logic_vector(1 downto 0);

signal state     : std_logic:= '0'; 
signal notstate     : std_logic:= '0'; 
signal notstate_i     : std_logic:= '0'; 
signal reset_oddr     : std_logic:= '0'; 
signal reset_iddr     : std_logic:= '0'; 


signal start_send     : std_logic:= '0'; 

signal sim_clk     : std_logic:= '0'; -- forwarded clock to slave board used as a system clock for it
signal clk_0deg    : std_logic:= '0'; -- user clock signal from clock manager to clock buffer
signal clk_90deg   : std_logic:= '0'; -- slave clock signal from clock manager to clock buffer
signal clk_90deg_packet   : std_logic:= '0'; -- slave clock signal from clock manager to clock buffer
signal clk_90deg_p : std_logic:= '0';
signal clk_90deg_n : std_logic:= '0';

signal clk_90deg_in   : std_logic:= '0'; -- slave clock signal from clock manager to clock buffer
signal clk_90deg_in_packet   : std_logic:= '0'; -- slave clock signal from clock manager to clock buffer
signal clk_90deg_in_from_fmc   : std_logic:= '0'; -- slave clock signal from clock manager to clock buffer
signal clk_90deg_in_p : std_logic:= '0';
signal clk_90deg_in_n : std_logic:= '0';

signal data_out  : std_logic_vector( 89 downto 0):=(others=>'0');
signal data_out_past  : std_logic_vector( 89 downto 0):=(others=>'0');
signal data_out_packet  : std_logic_vector( 29 downto 0):=(others=>'0');
signal data_out_p: std_logic_vector ( 14 downto 0):=(others=>'0');
signal data_out_n: std_logic_vector ( 14 downto 0):=(others=>'0');

signal data_in   : std_logic_vector( 89 downto 0):=(others=>'0');
signal data_in_cdc   : std_logic_vector( 89 downto 0):=(others=>'0');
signal data_in_hold   : std_logic_vector( 29 downto 0):=(others=>'0');
signal data_in_packet  : std_logic_vector( 29 downto 0):=(others=>'0');
signal data_in_p: std_logic_vector ( 14 downto 0);
signal data_in_n: std_logic_vector ( 14 downto 0):=(others=>'0');
signal data_valid_in: std_logic:= '0';

signal flag_out  : std_logic:= '0';
signal flag_out_packet  : std_logic:= '0';
signal flag_out_p: std_logic:= '0';
signal flag_out_n: std_logic:= '0';

signal flag_in   : std_logic:= '0';
signal flag_in_packet  : std_logic:= '0';
signal flag_in_packet_i  : std_logic:= '0';
signal flag_in_packet_debug  : std_logic_vector ( 0 downto 0);
signal flag_in_p : std_logic:= '0';
signal flag_in_n : std_logic:= '0';
signal clock_enable : std_logic:= '1';

signal CE_oddr : std_logic:= '0';
signal CE_iddr : std_logic;
--Signals for button debouncing
signal begin_run   : std_logic := '0'; --! triggers logic to run
signal begin_run_p : std_logic := '0';
signal begin_run_n : std_logic := '0';
signal start       : std_logic := '0'; --! internal start signal for user logic
signal reset : std_logic := '0'; -- reset signal for logic              : std_logic := '0'; --! internal start signal for user logic
signal start_i           : std_logic := '0'; 
signal reset_i : std_logic := '0'; 

signal ErrorDetector_i : std_logic := '0'; 
signal ErrorCounter_i : std_logic_vector (7 downto 0) := (others=>'0'); 

signal data_in_debug   : std_logic_vector( 89 downto 0):=(others=>'0');
signal data_valid_in_debug: std_logic_vector( 0 downto 0);
signal user_sma_state_debug: std_logic_vector( 0 downto 0);
signal data_out_debug  : std_logic_vector( 89 downto 0):=(others=>'0');
signal data_out_past_debug  : std_logic_vector( 89 downto 0):=(others=>'0');
signal ErrorDetector_i_debug : std_logic_vector( 0 downto 0);
signal ErrorCounter_i_debug : std_logic_vector (7 downto 0) := (others=>'0'); 

signal data_in_polished : STD_LOGIC;
signal nc : STD_LOGIC;

signal ErrorDetector:  STD_LOGIC;
signal ErrorCounter:  STD_LOGIC_VECTOR ( 7 downto 0 );

signal ErrorDetector_debug:  STD_LOGIC_VECTOR ( 0 downto 0 );
signal ErrorCounter_debug:  STD_LOGIC_VECTOR ( 7 downto 0 );

---  CLOCK DOMAIN FIFOS SIGNALS 
signal wr_en_a_u_1:  STD_LOGIC;
signal rd_en_a_u_1:  STD_LOGIC;
signal full_a_u_1:  STD_LOGIC;
signal empty_a_u_1:  STD_LOGIC;

signal wr_en_u_a_1:  STD_LOGIC;
signal full_u_a_1:  STD_LOGIC;
signal empty_u_a_1:  STD_LOGIC;
signal ap_ready_sim:  STD_LOGIC;
signal rd_en_u_a_1:  STD_LOGIC;


signal pbus_tx_fsm_ready: std_logic:= '0';
------------------------------------------------------
-- 			TI_DAC
-------------------------------------------------------
signal a_from_device : STD_LOGIC_VECTOR (15 downto 0);
signal b_from_device : STD_LOGIC_VECTOR (15 downto 0);
signal c_from_device : STD_LOGIC_VECTOR (15 downto 0);
signal d_from_device : STD_LOGIC_VECTOR (15 downto 0);

signal ab_to_dac_p : STD_LOGIC_VECTOR (15 downto 0);
signal ab_to_dac_n : STD_LOGIC_VECTOR (15 downto 0);
signal cd_to_dac_p : STD_LOGIC_VECTOR (15 downto 0);
signal cd_to_dac_n : STD_LOGIC_VECTOR (15 downto 0);

signal dac_clk_to_device_p : STD_LOGIC;
signal dac_clk_to_device_n : STD_LOGIC;
signal dac_clk_to_device : STD_LOGIC;
signal data_clk_to_dac_p : STD_LOGIC;
signal data_clk_to_dac_n : STD_LOGIC;


signal a_out: STD_LOGIC_VECTOR (15 downto 0);
signal b_out: STD_LOGIC_VECTOR (15 downto 0);
signal c_out: STD_LOGIC_VECTOR (15 downto 0);
signal d_out: STD_LOGIC_VECTOR (15 downto 0);



signal zeros   : std_logic_vector( 17 downto 0);
signal concat_inj_tx   : std_logic_vector( 89 downto 0);
signal concat_inj_rx   : std_logic_vector( 89 downto 0);

signal din_current_injection_TX : STD_LOGIC_VECTOR (71 downto 0);
signal current_inject_from_cdc   : std_logic_vector( 71 downto 0);



--CDC_SIM_TO_PBUS
signal wr_en_s_p :  STD_LOGIC;
signal rd_en_s_p :  STD_LOGIC;
signal full_s_p :  STD_LOGIC;
signal empty_s_p :  STD_LOGIC;
signal valid_s_p :  STD_LOGIC;
-------------------------------------------------------------------------------------



begin


    --GENERATE THE CLOCK SIGNALS FROM EXTERNAL CLOCK MANAGER SIGNAL
	MasterClockManager_inst: MasterClockManager  
	Port map
	(  
		data_clk_0deg => clk_0deg,  --clock 100MHz  0deg
		data_clk_90deg => clk_90deg,  --clock 100MHz  90deg
		sim_clk=>sim_clk,
		--Clock in ports
		clk_in1 => USER_SMA_CLOCK_P      --name in virtex: sys_data_clk_90deg_n
	);


	--start             <= GPIO_SW_N;
	--reset             <= GPIO_SW_C;
-------------------------------------------------------------------------------------------------		

-- DEBOUNCING THE START BUTTON	
--Debouncer_inst: Debouncer     --<-- to activate the Parallel bus push the button "start" such that "reset" has to stay equal to zero
--	Port map( 
--			  clk_in =>clk_0deg,
--			  start =>GPIO_SW_N,
--			  reset =>	GPIO_SW_C,	
--			  begin_run =>	begin_run
--			);
-------------------------------------------------------------------------------------------------					

RegisterStartState: process(clk_0deg, USER_SMA_CLOCK_N)
variable start_i : std_logic := '0';  
begin
	if(rising_edge(clk_0deg)) then
		start_send<= not USER_SMA_CLOCK_N;
	end if;
end process;				
-------------------------------------------------------------------------------------------------					
	--notstate <= not state;
	--notstate <= not USER_SMA_CLOCK_N;
	
	
	
	--reset_i <= not begin_run;
	
	ParallelBusInterface_inst: ParallelBusInterface
	Port map
	( 
		--reset	
		reset_from_device => '0', --: in std_logic; --! reset for parallel bus interface
		
		--sender side from device	
		data_clk_0_from_device   => clk_0deg, --  : in std_logic; --! data clock (0deg) for sending data
		data_clk_90_from_device  => clk_90deg, --: in std_logic; --! data clock (90deg) to forward to another device (source synchronous)	
		data_to_send_from_device => data_out,--"1011",--data_out, --: in std_logic_vector(89 downto 0); --! data to send from device to another device
		start_send_from_device   => start_send,--flag_out, -- : in std_logic;                     --! pulsed start flag to trigger sending data from device to another device	
		--sender side to I/O	
		oddr_input_send_to_io   => data_out_packet, --: out std_logic_vector(29 downto 0); --! sent data packet bus to be sent to another device, going to input of an I/O output register for sender
		ce_oddr_send_to_io      => CE_oddr, --: out std_logic;   --! Clock enable going to CE of an I/O output register for sender
		data_clk_90_send_to_io  => clk_90deg_packet, --: out std_logic;   --! forwarded 90deg data clock to be sent to another device, going to clock of an I/O output register for sender
		incoming_send_to_io     => flag_out_packet, --: out std_logic;   --! sent data incoming flag to be sent to another device, going to input of an I/O output register for sender
		READY => pbus_tx_fsm_ready,
		--receiver side to/from I/O	
		ce_iddr_recv_to_io             => CE_iddr, --: out std_logic;   --! Clock enable going to CE of I/O input register for receiver
		iddr_output_recv_from_io       => data_in_packet, --: in std_logic_vector(29 downto 0); --! received data packet bus from another device, coming from output of an I/O input register for receiver
		incoming_recv_from_io          => flag_in_packet, --: in std_logic;       --! received data incoming flag from another device, coming from output of an I/O input buffer for receiver
		data_clk_forward_recv_from_io  => clk_90deg_in_packet, --: in std_logic;       --! received forwarded (90deg+delay) data clock from another device, coming from output of an I/O input (clock capable) buffer for receiver
		--receiver side to device
		data_recv_to_device              => data_in, --: out std_logic_vector(89 downto 0); --! data received from another device
		data_valid_recv_to_device        => data_valid_in, --: out std_logic;    --! data valid flag indicating received data is valid to read
		data_clk_forward_recv_to_device  => clk_90deg_in --: out std_logic      --! forwarded data clock (90deg+delay) from another device 
	);	

-----------------------------------------------------------------------------------------------------------------------------------------------------------------		
--						SENDING SIDE	
-----------------------------------------------------------------------------------------------------------------------------------------------------------------		
-- AutoReset_for_ODDR: AutoReset 
    -- Port map ( 
			-- CLOCK 	 => clk_0deg,  --clk_0deg and clk_90deg_packet are related since coming from same MMCM
			-- RESET   =>  reset_oddr	
	-- );



	ODDR_clk: ODDR_2b  --forwards the 90deg clock to the other device 
	Port map
	(  
		data_out_from_device=>"10", --"01" is the same of: data_out_from_device(0)=>'0',data_out_from_device(1)=>'1'
		data_out_to_pins_p(0)  => clk_90deg_p, --out STD_LOGIC_VECTOR ( 0 to 0 );
		data_out_to_pins_n(0)  => clk_90deg_n, --out STD_LOGIC_VECTOR ( 0 to 0 );
		clk_in => clk_90deg_packet, 
		clk_en => '1',--CE_oddr,
		io_reset => '0'
	);
	
	ODDR_flag: ODDR_2b   
	Port map
	(  
		data_out_from_device(0)=>flag_out_packet, 
		data_out_from_device(1)=>flag_out_packet, 
		data_out_to_pins_p(0)  => flag_out_p, 
		data_out_to_pins_n(0)  => flag_out_n, 
		clk_in => clk_0deg, 
		clk_en => '1',--CE_oddr, 
		io_reset => '0'
	);
	
	ODDR_data: ODDR_4b 
    port map 
	( 
		data_out_from_device =>data_out_packet,--: in STD_LOGIC_VECTOR ( 29 downto 0 );
		data_out_to_pins_p   =>data_out_p,--: out STD_LOGIC_VECTOR ( 14 downto 0 );
		data_out_to_pins_n   =>data_out_n,--: out STD_LOGIC_VECTOR ( 14 downto 0 );
		clk_in   => clk_0deg,--: in STD_LOGIC;
		clk_en   =>'1',--CE_oddr, --: in STD_LOGIC;
		io_reset => '0'--: in STD_LOGIC			
	);
	
	
-----------------------------------------------------------------------------------------------------------------------------------------------------------------		
--						RECEIVING SIDE	
-----------------------------------------------------------------------------------------------------------------------------------------------------------------		

   IBUFDS_incoming_clock : IBUFDS
   generic map (
      DQS_BIAS => "FALSE"  -- (FALSE, TRUE)
   )
   port map (
      O => clk_90deg_in_from_fmc,   -- 1-bit output: Buffer output
      I => clk_90deg_in_p,   -- 1-bit input: Diff_p buffer input (connect directly to top-level port)
      IB => clk_90deg_in_n  -- 1-bit input: Diff_n buffer input (connect directly to top-level port)
   );	
	
	
   BUFG_inst : BUFG
   port map (
      O => clk_90deg_in_packet, -- 1-bit output: Clock output
      I => clk_90deg_in_from_fmc  -- 1-bit input: Clock input
   );	
	


	
	IDDR_data: IDDR_4b
	Port map
	(
		data_in_from_pins_p     =>data_in_p,--: in  std_logic_vector(14 downto 0);
		data_in_from_pins_n     =>data_in_n,--: in  std_logic_vector(14 downto 0);
		data_in_to_device   => data_in_packet,--: out std_logic_vector(29 downto 0);
		-- Clock and reset signals
		clk_in                  =>clk_90deg_in,--: in  std_logic;                    -- Fast clock from PLL/MMCM 
		clk_en                  =>'1',--CE_iddr--: in  std_logic;    
		io_reset                =>'0'--: in  std_logic                   -- Reset signal for IO circuit
	);


	
	IDDR_incoming_flag: IDDR_2b
	Port map
	(
		data_in_from_pins_p(0)     =>flag_in_p,-- 1-bit input: Diff_p buffer input 
		data_in_from_pins_n(0)     =>flag_in_n,
		data_in_to_device   => flag_in_packet_vec,--: out 
		-- Clock and reset signals
		clk_in                  =>clk_90deg_in,--: in  std_logic;                    -- Fast clock from PLL/MMCM 
		clk_en                  =>'1',--: in  std_logic;    
		io_reset                =>'0'--: in  std_logic                   -- Reset signal for IO circuit
	);		
	flag_in_packet <= flag_in_packet_vec(0) ;





zeros <= (others=>'0')   ; 
concat_inj_tx <= zeros & din_current_injection_TX;
concat_inj_rx <= zeros & current_inject_from_cdc;

	CDC_PBUS_TO_SIM: Two_Stages_Synchronizer
		Port map ( 
	
				DESTINATION_CLOCK  => sim_clk,     		
				INPUT_DATA   => 	data_in,	
				OUTPUT_DATA =>  concat_inj_rx 			
		);

	-- CDC_SIM_TO_PBUS: Two_Stages_Synchronizer
		-- Port map ( 
	
				-- DESTINATION_CLOCK  => clk_0deg,     		
				-- INPUT_DATA   => concat_inj_tx	,	
				-- OUTPUT_DATA =>  data_out    		
		-- );
		
CDC_SIM_TO_PBUS : FIFO_90BIT
  PORT MAP (
    rst => reset_i,
    wr_clk => sim_clk,
    rd_clk => clk_0deg,
    din => concat_inj_tx,
    wr_en => wr_en_s_p,
    rd_en => rd_en_s_p,
    dout => data_out,
    full => full_s_p,
    empty => empty_s_p,
    valid => valid_s_p,
    wr_rst_busy => open,
    rd_rst_busy => open
  );
		
wr_en_s_p <= ap_ready_sim and not full_s_p;		
rd_en_s_p <= valid_s_p and pbus_tx_fsm_ready;

AutoReset_for_FIFO: AutoReset 
    Port map ( 
			CLOCK 	 => sim_clk,  --clk_0deg and clk_90deg_packet are related since coming from same MMCM
			RESET   =>  reset_i	
	);
	-------------------------------------------------------------------------------------------------
    --   SIMULATION ENGINE
	-------------------------------------------------------------------------------------------------
	

	
	SubsystemB: toplevel_core_B 
    port map ( 
				ap_clk => sim_clk,
				ap_rst => GPIO_SW_C,
				ap_start => USER_SMA_CLOCK_N,
				ap_done => open,
				ap_idle => open,
				ap_ready => ap_ready_sim,			
				
				port_current_injection_from_b_to_a_V  => din_current_injection_TX(71 downto 0), --TX
				port_current_injection_from_b_to_a_V_ap_vld => open,
				i_in_port_from_a_V => current_inject_from_cdc(71 downto 0),--data_in(71 downto 0), --RX							

				V1out_dab1_V => open,
				V2out_dab1_V => open,
				I1out_dab1_V => open,
				I2out_dab1_V => open,
				I3out_dab1_V => open,
				Vpout_dab1_V => open,
				Vsout_dab1_V => open,

				dac_a_V => a_out,
				dac_a_V_ap_vld => open,
				dac_b_V => b_out,
				dac_b_V_ap_vld => open,
				dac_c_V => c_out,
				dac_c_V_ap_vld => open,
				dac_d_V => d_out,		
				dac_d_V_ap_vld => open
			  );			  

	
	-------------------------------------------------------------------------------------------------
    --   TI-DAC
	-------------------------------------------------------------------------------------------------	
dacInterface : DAC34H84Interface
	port map( 
		if_reset             => '0',

		a_from_device        => a_out, --a_from_device, --inputs from user's logic (SimEng-->FIFO--->)
		b_from_device        => b_out, --b_from_device, --inputs from user's logic (SimEng-->FIFO--->)
		c_from_device        => c_out, --c_from_device, --inputs from user's logic (SimEng-->FIFO--->)
		d_from_device        => d_out, --d_from_device, --inputs from user's logic (SimEng-->FIFO--->)

		dac_clk_to_device_p  => FMCP_HSPC_CLK0_M2C_P,--dac_clk_to_device_p, --incoming clock from the TI-DAC device
		dac_clk_to_device_n  => FMCP_HSPC_CLK0_M2C_N,--dac_clk_to_device_n, --incoming clock from the TI-DAC device
		dac_clk_to_device    => dac_clk_to_device,  -- single eneded clock gnerated from the incominc TI-DAC
		data_clk_to_dac_p    => FMCP_HSPC_LA18_CC_P, --data_clk_to_dac_p, --90deg clock sent out to the TI-DAC for input ports signals stabilization: the 90deg phase shift allows some waiting time in order to allow the received signals to stabilize 
		data_clk_to_dac_n    => FMCP_HSPC_LA18_CC_N, --data_clk_to_dac_n, --90deg clock sent out to the TI-DAC for input ports signals stabilization: the 90deg phase shift allows some waiting time in order to allow the received signals to stabilize 
		data_clk_to_dac_e    => open,

		ab_to_dac_p          => ab_to_dac_p, --output going to FMC-->TI-DAC-->oscilloscope
		ab_to_dac_n          => ab_to_dac_n, --output going to FMC-->TI-DAC-->oscilloscope
		cd_to_dac_p          => cd_to_dac_p, --output going to FMC-->TI-DAC-->oscilloscope
		cd_to_dac_n          => cd_to_dac_n  --output going to FMC-->TI-DAC-->oscilloscope
	);
	




	
-- ILA_SIMULATION_ENGINE : ila_0
-- PORT MAP (
	-- clk => sim_clk,



	-- probe0 => USER_SMA_STATE_debug,  --start signal from System Manager
	-- probe1 => data_in_debug, 
	-- probe2 => data_valid_in_debug, -- valid estabilished by the RX FSM
	-- probe3 => data_out_debug, 
	-- probe4 => data_out_past_debug, 
	-- probe5 => ErrorDetector_debug,
	-- probe6 => ErrorCounter_debug,
	-- probe7 => flag_in_packet_debug   --incoming valid flag from the other FPGA
-- );

	-- ILA_SIMULATION_ENGINE_REGISTER : process
									-- (
										-- sim_clk,
										-- USER_SMA_CLOCK_N,  --start signal from System Manager
										-- data_in, 
										-- data_valid_in, 
										-- data_out, 
										-- data_out_past, 
										-- ErrorDetector,
										-- ErrorCounter,
										-- flag_in_packet
									-- ) is
	-- begin	
		-- if(rising_edge(sim_clk)) then

									-- user_sma_state_debug(0) <=	 USER_SMA_CLOCK_N;  --start signal from System Manager
									-- data_in_debug 			<=	 data_in; 
									-- data_valid_in_debug(0)  <=	 data_valid_in; 
									-- data_out_debug 			<= 	 data_out; 
									-- data_out_past_debug 	<= 	 data_out_past; 
									-- ErrorDetector_debug(0)<=	 ErrorDetector;
									-- ErrorCounter_debug	<=	 ErrorCounter;	
									-- flag_in_packet_debug(0)	<=	 flag_in_packet;	
		-- end if;	
	-- end process;

	
	-----------------------------------------------------------------
	--   PARALLEL BUS CONNECTION TO I/O PORTS 
	-----------------------------------------------------------------

	--Output
	FMC_HPC1_LA00_CC_P <= clk_90deg_p;   
	FMC_HPC1_LA01_CC_P <= flag_out_p;	     -- <-- this clock was not adeguate for clock forwarding: read more about it (in the pinout has only acronym "QBC" rather than "GC" (means Global Clock capable pin))
	FMC_HPC1_LA02_P    <= data_out_p(0);	
	FMC_HPC1_LA03_P    <= data_out_p(1);	
	FMC_HPC1_LA04_P    <= data_out_p(2);				
	FMC_HPC1_LA05_P    <= data_out_p(3);				
	FMC_HPC1_LA06_P    <= data_out_p(4);
	FMC_HPC1_LA07_P    <= data_out_p(5);
	FMC_HPC1_LA08_P    <= data_out_p(6);	
	FMC_HPC1_LA09_P    <= data_out_p(7);
	FMC_HPC1_LA10_P    <= data_out_p(8);
	FMC_HPC1_LA11_P    <= data_out_p(9);		
	FMC_HPC1_LA12_P    <= data_out_p(10);
	FMC_HPC1_LA13_P    <= data_out_p(11);
	FMC_HPC1_LA14_P    <= data_out_p(12);
	FMC_HPC1_LA15_P    <= data_out_p(13);
	FMC_HPC1_LA16_P    <= data_out_p(14);
	
	FMC_HPC1_LA00_CC_N <= clk_90deg_n;   
	FMC_HPC1_LA01_CC_N <= flag_out_n;	
	FMC_HPC1_LA02_N    <= data_out_n(0);	
	FMC_HPC1_LA03_N    <= data_out_n(1);	
	FMC_HPC1_LA04_N    <= data_out_n(2);				
	FMC_HPC1_LA05_N    <= data_out_n(3);				
	FMC_HPC1_LA06_N    <= data_out_n(4);
	FMC_HPC1_LA07_N    <= data_out_n(5);
	FMC_HPC1_LA08_N    <= data_out_n(6);	
	FMC_HPC1_LA09_N    <= data_out_n(7);
	FMC_HPC1_LA10_N    <= data_out_n(8);
	FMC_HPC1_LA11_N    <= data_out_n(9);		
	FMC_HPC1_LA12_N    <= data_out_n(10);
	FMC_HPC1_LA13_N    <= data_out_n(11);
	FMC_HPC1_LA14_N    <= data_out_n(12);
	FMC_HPC1_LA15_N    <= data_out_n(13);
	FMC_HPC1_LA16_N    <= data_out_n(14);
	
	--INPUTS
	clk_90deg_in_p      <= FMC_HPC1_LA17_CC_P ; 
	flag_in_p 	        <= FMC_HPC1_LA18_CC_P ; -- <-- this clock was not adeguate for clock forwarding: read more about it
	data_in_p(0)	    <= FMC_HPC1_LA19_P    ; 
	data_in_p(1)	    <= FMC_HPC1_LA20_P    ;	
	data_in_p(2)	    <= FMC_HPC1_LA21_P    ; 	
	data_in_p(3)	    <= FMC_HPC1_LA22_P    ;
	data_in_p(4)        <= FMC_HPC1_LA23_P    ;
	data_in_p(5)        <= FMC_HPC1_LA24_P    ;
	data_in_p(6)	    <= FMC_HPC1_LA25_P    ;
	data_in_p(7)        <= FMC_HPC1_LA26_P    ;
	data_in_p(8)        <= FMC_HPC1_LA27_P    ;
	data_in_p(9)	    <= FMC_HPC1_LA28_P    ;	
	data_in_p(10)       <= FMC_HPC1_LA29_P    ;
	data_in_p(11)       <= FMC_HPC1_LA30_P	  ;
	data_in_p(12)       <= FMC_HPC1_LA31_P    ;
	data_in_p(13)       <= FMC_HPC1_LA32_P    ;
	data_in_p(14)       <= FMC_HPC1_LA33_P    ;
	   
	clk_90deg_in_n      <= FMC_HPC1_LA17_CC_N ; 
	flag_in_n 	        <= FMC_HPC1_LA18_CC_N ;
	data_in_n(0) 	    <= FMC_HPC1_LA19_N    ; 
	data_in_n(1) 	    <= FMC_HPC1_LA20_N    ;	
	data_in_n(2) 	    <= FMC_HPC1_LA21_N    ; 	
	data_in_n(3) 	    <= FMC_HPC1_LA22_N    ;
	data_in_n(4)        <= FMC_HPC1_LA23_N    ;
	data_in_n(5)        <= FMC_HPC1_LA24_N    ;
	data_in_n(6) 	    <= FMC_HPC1_LA25_N    ;
	data_in_n(7)        <= FMC_HPC1_LA26_N    ;
	data_in_n(8)        <= FMC_HPC1_LA27_N    ;
	data_in_n(9) 	    <= FMC_HPC1_LA28_N    ;	
	data_in_n(10)       <= FMC_HPC1_LA29_N    ;
	data_in_n(11)       <= FMC_HPC1_LA30_N	  ;
	data_in_n(12)       <= FMC_HPC1_LA31_N    ;
	data_in_n(13)       <= FMC_HPC1_LA32_N    ;
	data_in_n(14)       <= FMC_HPC1_LA33_N    ;
	
	
	
	-----------------------------------------------------------------
	--   TI-DAC CONNECTION TO I/O PORTS 
	-----------------------------------------------------------------	
		-- DAC AB
	FMCP_HSPC_LA24_P      <= ab_to_dac_p(0);
	FMCP_HSPC_LA24_N      <= ab_to_dac_n(0);
	FMCP_HSPC_LA21_P      <= ab_to_dac_p(1);
	FMCP_HSPC_LA21_N      <= ab_to_dac_n(1);
	FMCP_HSPC_LA19_P      <= ab_to_dac_p(2);
	FMCP_HSPC_LA19_N      <= ab_to_dac_n(2);
	FMCP_HSPC_LA15_P      <= ab_to_dac_p(3);
	FMCP_HSPC_LA15_N      <= ab_to_dac_n(3);
	FMCP_HSPC_LA11_P      <= ab_to_dac_p(4);
	FMCP_HSPC_LA11_N      <= ab_to_dac_n(4);
	FMCP_HSPC_LA07_P      <= ab_to_dac_p(5);
	FMCP_HSPC_LA07_N      <= ab_to_dac_n(5);
	FMCP_HSPC_LA04_P      <= ab_to_dac_p(6);
	FMCP_HSPC_LA04_N      <= ab_to_dac_n(6);
	FMCP_HSPC_LA02_P      <= ab_to_dac_p(7);
	FMCP_HSPC_LA02_N      <= ab_to_dac_n(7);
	FMCP_HSPC_LA33_P      <= ab_to_dac_p(8);
	FMCP_HSPC_LA33_N      <= ab_to_dac_n(8);
	FMCP_HSPC_LA31_P      <= ab_to_dac_p(9);
	FMCP_HSPC_LA31_N      <= ab_to_dac_n(9);
	FMCP_HSPC_LA29_P      <= ab_to_dac_p(10);
	FMCP_HSPC_LA29_N      <= ab_to_dac_n(10);
	FMCP_HSPC_LA25_P      <= ab_to_dac_p(11);
	FMCP_HSPC_LA25_N      <= ab_to_dac_n(11);
	FMCP_HSPC_LA22_P      <= ab_to_dac_p(12);
	FMCP_HSPC_LA22_N      <= ab_to_dac_n(12);
	FMCP_HSPC_LA20_P      <= ab_to_dac_p(13);
	FMCP_HSPC_LA20_N      <= ab_to_dac_n(13);
	FMCP_HSPC_LA16_P      <= ab_to_dac_p(14);
	FMCP_HSPC_LA16_N      <= ab_to_dac_n(14);
	FMCP_HSPC_LA12_P      <= ab_to_dac_p(15);
	FMCP_HSPC_LA12_N      <= ab_to_dac_n(15);

		-- DAC CD
	-- open 				 <= cd_to_dac_p(0);
	-- open 				 <= cd_to_dac_n(0);
	-- open 				 <= cd_to_dac_p(1);
	-- open 				 <= cd_to_dac_n(1);
	FMCP_HSPC_LA06_P      <= cd_to_dac_p(2);
	FMCP_HSPC_LA06_N      <= cd_to_dac_n(2);
	FMCP_HSPC_LA10_P      <= cd_to_dac_p(3);
	FMCP_HSPC_LA10_N      <= cd_to_dac_n(3);
	FMCP_HSPC_LA14_P      <= cd_to_dac_p(4);
	FMCP_HSPC_LA14_N      <= cd_to_dac_n(4);
	FMCP_HSPC_LA27_P      <= cd_to_dac_p(5);
	FMCP_HSPC_LA27_N      <= cd_to_dac_n(5);
	FMCP_HSPC_LA01_CC_P   <= cd_to_dac_p(6);
	FMCP_HSPC_LA01_CC_N   <= cd_to_dac_n(6);
	FMCP_HSPC_LA05_P      <= cd_to_dac_p(7);
	FMCP_HSPC_LA05_N      <= cd_to_dac_n(7);
	FMCP_HSPC_LA09_P      <= cd_to_dac_p(8);
	FMCP_HSPC_LA09_N      <= cd_to_dac_n(8);
	FMCP_HSPC_LA13_P      <= cd_to_dac_p(9);
	FMCP_HSPC_LA13_N      <= cd_to_dac_n(9);
	FMCP_HSPC_LA17_CC_P   <= cd_to_dac_p(10);
	FMCP_HSPC_LA17_CC_N   <= cd_to_dac_n(10);
	FMCP_HSPC_LA23_P      <= cd_to_dac_p(11);
	FMCP_HSPC_LA23_N      <= cd_to_dac_n(11);
	FMCP_HSPC_LA26_P      <= cd_to_dac_p(12);
	FMCP_HSPC_LA26_N      <= cd_to_dac_n(12);
	FMCP_HSPC_LA00_CC_P   <= cd_to_dac_p(13);
	FMCP_HSPC_LA00_CC_N   <= cd_to_dac_n(13);
	FMCP_HSPC_LA03_P      <= cd_to_dac_p(14);
	FMCP_HSPC_LA03_N      <= cd_to_dac_n(14);
	FMCP_HSPC_LA08_P      <= cd_to_dac_p(15);
	FMCP_HSPC_LA08_N      <= cd_to_dac_n(15);	
	
	
	
	
end Behavioral;
