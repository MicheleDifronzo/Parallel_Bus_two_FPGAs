--=================================================================================================
--! 
--!	\file Parallel Bus Interface
--!
--!	\author  Michele Difronzo
--! \date October 2019
--!
--=================================================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

library xil_defaultlib;

--! \brief defines a duplex parallel bus interface with internal packing and unpacking of data
--!
--! This parallel bus interface sends and receives 1 90-bit data word both ways at same time.
--! Data is sent and received to/from interface through 30-bit buses to/from 30-bit<->15-bit DDR 
--! I/O registers external to the bus interface.
--! Data to/from these I/O registers is done with source-synchronous DDR, LVDS communication.
--!
--! The actual parallel bus the interface connects to consists of a 15-bit wide data channel, 1-bit 
--! incoming flag, and 1-bit forwarded clock, 17-ports total in each direction (34-ports duplex).
--!
--! \author Matthew Milton, Michele Difronzo
--! \date October 2019
--!
entity ParallelBusInterface is
port
(
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
	READY				   : out std_logic; -- from TX FSM clock enable signal
	--receiver side to/from I/O	
	ce_iddr_recv_to_io : out std_logic;                               --! Clock enable going to CE of I/O input register for receiver
	iddr_output_recv_from_io      : in std_logic_vector(29 downto 0);--(29 downto 0); --! received data packet bus from another device, coming from output of an I/O input register for receiver
	incoming_recv_from_io         : in std_logic;                     --! received data incoming flag from another device, coming from output of an I/O input buffer for receiver
	data_clk_forward_recv_from_io : in std_logic;                     --! received forwarded (90deg+delay) data clock from another device, coming from output of an I/O input (clock capable) buffer for receiver
	--receiver side to device
	data_recv_to_device             : out std_logic_vector(89 downto 0);--(89 downto 0); --! data received from another device
	data_valid_recv_to_device       : out std_logic;                     --! data valid flag indicating received data is valid to read
	data_clk_forward_recv_to_device : out std_logic                    --! forwarded data clock (90deg+delay) from another device
	
);
end ParallelBusInterface;

architecture ARCH of ParallelBusInterface is





COMPONENT ila_1

PORT (
	clk : IN STD_LOGIC;



	probe0 : IN STD_LOGIC_VECTOR(0 DOWNTO 0); 
	probe1 : IN STD_LOGIC_VECTOR(0 DOWNTO 0); 
	probe2 : IN STD_LOGIC_VECTOR(15 DOWNTO 0); 
	probe3 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
	probe4 : IN STD_LOGIC_VECTOR(29 downto 0);
	probe5 : IN STD_LOGIC_VECTOR(15 downto 0);
	probe6 : IN STD_LOGIC_VECTOR(0 downto 0);
	probe7 : IN STD_LOGIC_VECTOR(89 downto 0)
);
END COMPONENT  ;


COMPONENT ila_2

PORT (
	clk : IN STD_LOGIC;



	probe0 : IN STD_LOGIC_VECTOR(0 DOWNTO 0); 
	probe1 : IN STD_LOGIC_VECTOR(0 DOWNTO 0); 
	probe2 : IN STD_LOGIC_VECTOR(15 DOWNTO 0); 
	probe3 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
	probe4 : IN STD_LOGIC_VECTOR(89 downto 0);
	probe5 : IN STD_LOGIC_VECTOR(15 downto 0);
	probe6 : IN STD_LOGIC_VECTOR(0 downto 0);
	probe7 : IN STD_LOGIC_VECTOR(29 downto 0)
);
END COMPONENT  ;






	-- data types
type PacketArray is array (integer range <>) of std_logic_vector(29 downto 0);--(29 downto 0); -- array of 30-bit subwords that serve as packet to send/receive

--=================================================================================================

	-- clocks
	
signal data_clk_0 : std_logic := '0';         --! data clock (0deg) for sender side
signal data_clk_90 : std_logic := '0';        --! data clock (90deg) forwarded from sender side to a receiver
signal data_clk_forward : std_logic := '0';   --! data clock (90+delay deg) for receiver side, forwarded from another sender

--=================================================================================================

	-- control
	
signal reset : std_logic := '0';  --! reset flag

--=================================================================================================

	-- sender side signals

signal ce_packet_send : std_logic := '0';                           --! clock enable for sender packet array
signal ce_packet_send_debug : std_logic_vector(0 DOWNTO 0);                               --! clock enable for sender packet array
signal packet_address_send : integer range 0 to 2 := 0;             --! address select of sender packet array
signal packet_address_send_debug : std_logic_vector(15 DOWNTO 0);            --! address select of sender packet array
signal packet_address_recv_debug : std_logic_vector(15 DOWNTO 0);            --! address select of sender packet array
signal ce_oddr_send : std_logic := '0';                             --! clock enable for sender ODDR output register
signal incoming_send : std_logic := '0';                            --! data incoming flag from sender to receiver (sender side)
signal incoming_send_debug : std_logic_vector(0 downto 0);                            --! data incoming flag from sender to receiver (sender side)
signal start_send : std_logic := '0';                               --! start flag for sender side
signal start_past_send : std_logic := '0';                          --! start flag for sender side from past clock cycle


signal start_send_debug : std_logic_vector(0 downto 0);                               --! start flag for sender side
signal start_past_send_debug : std_logic_vector(0 downto 0);                          --! start flag for sender side from past clock cycle


signal data_to_send : std_logic_vector(89 downto 0):=(others=>'0');                --! data to send from sender side (input port of || bus interface

--signal packet_send : PacketArray(2 downto 0):= ((others=>'0'), (others=>'0'), (others=>'0'));                      --! packet to send from sender to receiver
signal packet_send : PacketArray(2 downto 0);                      --! packet to send from sender to receiver
signal packet_send_debug: std_logic_vector(89 downto 0);
signal packet_send_vec: std_logic_vector(89 downto 0);
signal oddr_input_send : std_logic_vector(29 downto 0):=(others=>'0');             --! 30-bit input to sender side ODDR output register
signal oddr_input_send_i : std_logic_vector(29 downto 0):=(others=>'0');             --! 30-bit input to sender side ODDR output register
signal oddr_input_send_debug : std_logic_vector(29 downto 0):=(others=>'0');             --! 30-bit input to sender side ODDR output register

--=================================================================================================

	-- receiver side signals
	
signal ce_packet_recv : std_logic := '0';                           --! clock enable for receiver packet array
signal ce_packet_recv_debug : std_logic_vector(0 downto 0);                          --! clock enable for receiver packet array
signal packet_address_recv : integer range 0 to 2 := 0;             --! address select of receiver packet array
signal ce_iddr_recv : std_logic := '0';                             --! clock enable for receiver IDDR input register
signal ce_iddr_state_recv : std_logic := '0';                       --! clock enable for receiver IDDR input register, from the state machine
signal packet_valid_recv : std_logic := '0';                        --! valid flag of receiver side indicating packet array is valid to read
signal packet_valid_recv_debug : std_logic_vector(0 downto 0);                        --! valid flag of receiver side indicating packet array is valid to read
signal incoming_recv : std_logic := '0';                            --! data incoming flag from sender to receiver (receiver side)
signal incoming_recv_debug : std_logic_vector(0 downto 0);                            --! data incoming flag from sender to receiver (receiver side)
signal incoming_past_recv : std_logic := '0';                       --! data incoming flag from sender to receiver (Receiver side), from past clock cycle
signal incoming_past_recv_debug : std_logic_vector(0 downto 0);                       --! data incoming flag from sender to receiver (Receiver side), from past clock cycle

signal data_recv : std_logic_vector(29 downto 0):=(others=>'0');                   --! data to receive from another sender (output port of || bus interface)

signal packet_recv : PacketArray(2 downto 0):=((others=>'0'),(others=>'0'),(others=>'0'));                       --! packet received from sender to receiver
signal packet_recv_debug : std_logic_vector(89 downto 0);                          --! packet received from sender to receiver
signal iddr_output_recv : std_logic_vector(29 downto 0):=(others=>'0');            --! 30-bit output from receiver side IDDR input register
signal iddr_output_recv_i : std_logic_vector(29 downto 0):=(others=>'0');            --! 30-bit output from receiver side IDDR input register
signal iddr_output_recv_ii : std_logic_vector(29 downto 0):=(others=>'0');            --! 30-bit output from receiver side IDDR input register
signal iddr_output_recv_debug : std_logic_vector(29 downto 0):=(others=>'0'); 


signal data_in             :  std_logic_vector(89 downto 0); 
signal data_in_inverted             :  std_logic_vector(89 downto 0); 


  signal state_of_RX_FSM: std_logic_vector(15 DOWNTO 0);
  signal state_of_RX_FSM_debug: std_logic_vector(15 DOWNTO 0);

  signal state_of_TX_FSM: std_logic_vector(15 DOWNTO 0);
  signal state_of_TX_FSM_debug: std_logic_vector(15 DOWNTO 0);
--=================================================================================================

begin

--=================================================================================================

-- SENDER SIDE: TX-FSM

--! process that handles state machine for sender side
ParallelBusInterfaceSenderFSM : process
									(
										data_clk_0, 
										reset, 
										start_send, 
										start_past_send,
										state_of_TX_FSM
										
										
									)
	
	variable state : integer range 0 to 20 := 0;
	variable ce_packet : std_logic := '0';
	variable package_address : integer range 0 to 2 := 0;
	variable packet_address : integer range 0 to 2 := 0;
	variable ce_oddr : std_logic := '0';
	variable incoming : std_logic := '0';
	
begin
	
	if (rising_edge(data_clk_0)) then
	
		if (reset = '1') then
		
			state := 0;
			ce_packet := '0';
			package_address := 0;
			ce_oddr := '0';
			incoming := '0';   -- valid flag
		
		elsif( (start_send = '1' and start_past_send = '0') or state /= 0 ) then
		


			case state is
			
				when 0 =>      --sending 2nd valid 2bit subword
					state := 1;
					ce_packet := '1';
					package_address := 1;
					incoming := '1'; 

				when 1 =>   --sending 1st valid 2bit subword
					state := 2;       
					ce_packet := '1';
					package_address := 0;
					incoming := '1'; 

				when 2 =>         
					state := 3;   
					ce_packet := '0';
					package_address := 0;
					incoming := '0'; 

				when 3 =>       
					state := 4;   
					ce_packet := '0';
					package_address := 0;
					incoming := '0'; 

				when 4 =>    
					state := 5;   
					ce_packet := '0';
					package_address := 0;
					incoming := '0'; 
					
				when 5 =>
					state := 6;   
					ce_packet := '0';
					package_address := 0;		
					incoming := '0'; 					
					
				when 6 =>
					state := 7;   
					ce_packet := '0';
					package_address := 0;
					incoming := '0'; 
					
				when 7 =>
					state := 8;   
					ce_packet := '0';
					package_address := 0;	
					incoming := '0'; 

				when 8 =>
					state := 9;   
					ce_packet := '0';
					package_address := 0;		
					incoming := '0'; 					

				when 9 =>
					state := 10;   
					ce_packet := '0';
					package_address := 0;		
					incoming := '0'; 

				when 10 =>
					state := 11;   
					ce_packet := '0';
					package_address := 0;		
					incoming := '0'; 

				when 11 =>
					state := 12;   
					ce_packet := '0';
					package_address := 0;		
					incoming := '0'; 

				when 12 =>
					state := 13;   
					ce_packet := '0';
					package_address := 0;		
					incoming := '0'; 
				
				when 13 =>
					state := 14;       
					ce_packet := '0'; 
					package_address := 0;		
					incoming := '0'; 

				when 14 =>
					state := 15;       
					ce_packet := '0'; 
					package_address := 0;		
					incoming := '0'; 					

				when 15 =>
					state := 16;       
					ce_packet := '0'; 
					package_address := 0;		
					incoming := '0'; 

				when 16 =>
					state := 17;       
					ce_packet := '0'; 
					package_address := 0;		
					incoming := '0'; 

				when 17 =>
					state := 18;       
					ce_packet := '0'; 
					package_address := 0;		
					incoming := '0'; 

				when 18 =>
					state := 19;       
					ce_packet := '0'; 
					package_address := 0;		
					incoming := '0'; 
					
				when 19 =>
					state := 0;     --sending 3rd valid 2bit subword  
					ce_packet := '1';     
					package_address := 2;
					incoming := '1'; 
					
				 when others =>
					 state := 0;
					 ce_packet := '0';
					 package_address := 0;		
					 incoming := '0'; 				
			end case;			
			
			
			
			
		end if;
		
		start_past_send <= start_send;
		ce_packet_send <= ce_packet;
		--packet_address_send <= packet_address;
		packet_address_send <= package_address;
		ce_oddr_send <= ce_oddr;
		incoming_send <= incoming;
		
		--ce_packet_send <= start_send and not(start_past_send)  ;
		state_of_TX_FSM <=  std_logic_vector(to_unsigned(state, state_of_TX_FSM'length));
	end if;

end process;


start_send <= start_send_from_device;


READY <= ce_packet_send;






RegisterSenderPacket : process
							(
								data_clk_0, 
								reset, 
								ce_packet_send, 
								data_to_send,
								packet_address_send
							)

variable packet_send_i : PacketArray(2 downto 0);							
							
BEGIN
	
	if( rising_edge(data_clk_0) ) then
	
		if(reset = '1') 
			then
				packet_send_i(0) := (others=>'0');
				packet_send_i(1) := (others=>'0');
				packet_send_i(2) := (others=>'0');
			elsif(ce_packet_send='1') 
				then
					packet_send_i(0) := data_to_send(29 downto 0 );
					packet_send_i(1) := data_to_send(59 downto 30);
					packet_send_i(2) := data_to_send(89 downto 60);							
			else
				packet_send_i(0) := packet_send_i(0);
				packet_send_i(1) := packet_send_i(1);
				packet_send_i(2) := packet_send_i(2);	
		end if;
	   
	   oddr_input_send <= packet_send_i(packet_address_send);
	   packet_send <= packet_send_i;
	end if;
	
END PROCESS;



--=================================================================================================

-- RECEIVER SIDE: RX-FSM

--! process that handles state machine for receiver side
ParallelBusInterfaceRecieverFSM : process
									(
										data_clk_forward, 
										reset, 
										incoming_recv, 
										incoming_past_recv,
										state_of_RX_FSM--,
										
										--iddr_output_recv
										--data_in
										
									)

	variable state : integer range 0 to 20 := 0;
	variable ce_packet : std_logic := '0';
	variable packet_address : integer range 0 to 2 := 0;
    variable package_address : integer range 0 to 2 := 0;
	variable ce_iddr : std_logic := '0';
	variable packet_valid : std_logic := '0';
	
	

begin

	if (rising_edge(data_clk_forward)) then
	
		if (reset = '1') then
		
			state := 0;
			ce_packet := '0';
			package_address := 0;
			ce_iddr := '0';
			packet_valid := '0';
		
		elsif( (incoming_recv = '1' and incoming_past_recv = '0') or state /= 0 ) then
		

		
			case state is
			
				when 0 =>      --receving the 2nd subword
					state := 1;
					ce_packet := '1';  
					package_address := 1;

				when 1 =>   --receving the 1st subword
					state := 2; 
					ce_packet := '1';  
					package_address := 0;

				when 2 =>    
					state := 3;    
					ce_packet := '0';
					package_address := 0;

				when 3 => 
					state := 4;    
					ce_packet := '0';
					package_address := 0;

				when 4 =>   
					state := 5;    
					ce_packet := '0';
					package_address := 0;
					
				when 5 =>
					state := 6;   
					ce_packet := '0';
					package_address := 0;					
					
				when 6 =>
					state := 7;   
					ce_packet := '0';
					package_address := 0;
					
				when 7 =>
					state := 8;   
					ce_packet := '0';
					package_address := 0;	

				when 8 =>
					state := 9;   
					ce_packet := '0';
					package_address := 0;					
					
				when 9 =>
					state := 10;   
					ce_packet := '0';
					package_address := 0;		


				when 10 =>
					state := 11;   
					ce_packet := '0';
					package_address := 0;		


				when 11 =>
					state := 12;   
					ce_packet := '0';
					package_address := 0;		


				when 12 =>
					state := 13;   
					ce_packet := '0';
					package_address := 0;		

				
				when 13 =>
					state := 14;       
					ce_packet := '0'; 
					package_address := 0;		


				when 14 =>
					state := 15;       
					ce_packet := '0'; 
					package_address := 0;		
					

				when 15 =>
					state := 16;       
					ce_packet := '0'; 
					package_address := 0;		


				when 16 =>
					state := 17;       
					ce_packet := '0'; 
					package_address := 0;		


				when 17 =>
					state := 18;       
					ce_packet := '0'; 
					package_address := 0;		


				when 18 =>
					state := 19;       
					ce_packet := '0'; 
					package_address := 0;		

					
				when 19 =>  
					state := 0;     --receving the 3rd subword  
					ce_packet := '1'; 
					package_address := 2;		


				 when others =>
					 state := 0;
					 ce_packet := '0';
					 package_address := 0;						
			end case;	
			
		end if;
		
		--incoming_past_recv <= incoming_recv;
		ce_packet_recv <= ce_packet;
		--packet_address_recv <= packet_address;
		packet_address_recv <= package_address;
		ce_iddr_state_recv <= ce_iddr;
		packet_valid_recv <= packet_valid;
		state_of_RX_FSM <=  std_logic_vector(to_unsigned(state, state_of_RX_FSM'length));
	end if;

end process;






RegisterReceiverPacket : PROCESS(
									data_clk_forward, 
									reset, 
									iddr_output_recv, 
									ce_packet_recv, 
									packet_address_recv
								)

variable packet_recv_i : PacketArray(2 downto 0);										
									
BEGIN

	if(rising_edge(data_clk_forward)) then
	
		if(reset = '1') 
			then
				packet_recv_i(0) := (others=>'0');
				packet_recv_i(1) := (others=>'0');
				packet_recv_i(2) := (others=>'0');
				
			elsif(ce_packet_recv='1') 
				then
					packet_recv_i(packet_address_recv) := iddr_output_recv;	--ORIGINAL			
		end if;
		
		packet_recv <= packet_recv_i;
		
	end if;	 	 
END PROCESS;	



		--- to SIMULATION ENGINE
		data_recv_to_device(29 downto 0 ) <= packet_recv(0);
		data_recv_to_device(59 downto 30) <= packet_recv(1);
		data_recv_to_device(89 downto 60) <= packet_recv(2);

		---to ILA  CORE REGISTER
		data_in(29 downto 0 ) <= packet_recv(0);
		data_in(59 downto 30) <= packet_recv(1);
		data_in(89 downto 60) <= packet_recv(2);

					
		--- to SIMULATION ENGINE
		-- data_recv_to_device(1 downto  0) <= packet_recv(0);
		-- data_recv_to_device(3 downto  2) <= packet_recv(1);
		-- data_recv_to_device(5 downto  4) <= packet_recv(2);

		---to ILA  CORE REGISTER
		-- data_in(1 downto  0) <= packet_recv(0);
		-- data_in(3 downto  2) <= packet_recv(1);
		-- data_in(5 downto  4) <= packet_recv(2);	



		


	
	
RegisterIncoming : process(data_clk_forward, incoming_recv)
begin	
	if( rising_edge(data_clk_forward) ) then
	
		incoming_recv  <= incoming_recv_from_io;
		incoming_past_recv <= incoming_recv;
	end if;	
end process;	
	


	
	



--=================================================================================================

-- SIGNAL-PORT CONNECTIONS

	
	reset <= reset_from_device;
	
	-- sender side from device
	
data_clk_0   <= data_clk_0_from_device;
data_clk_90  <= data_clk_90_from_device;
data_to_send <= data_to_send_from_device;
--start_send   <= start_send;

	-- sender side to I/O

oddr_input_send_to_io  <= oddr_input_send;
ce_oddr_send_to_io     <= ce_oddr_send;
data_clk_90_send_to_io <= data_clk_90;
incoming_send_to_io    <= incoming_send;

	-- receiver side to/from I/O

ce_iddr_recv_to_io <= ce_iddr_recv;
iddr_output_recv   <= iddr_output_recv_from_io;
--incoming_recv      <= incoming_recv_from_io;
data_clk_forward   <= data_clk_forward_recv_from_io;

	-- receiver side to device

--data_recv_to_device             <= data_recv;
data_valid_recv_to_device       <= packet_valid_recv;
data_clk_forward_recv_to_device <= data_clk_forward;


--=================================================================================================


-- ILA_TX_SIDE: ila_1
-- Port map
-- (
	-- clk => data_clk_0,
	
	-- probe0 => start_send_debug,
	-- probe1 => start_past_send_debug,
	-- probe2 => packet_address_send_debug,--16bit
	-- probe3 => incoming_send_debug,    
	-- probe4 => oddr_input_send_debug, --30bit
	-- probe5 => state_of_TX_FSM_debug, --16bit
	-- probe6 => ce_packet_send_debug, --16bit
	-- probe7 => packet_send_debug --6bit
	
-- );


	-- ILA_TX_SIDE_REGISTER : process
									-- (
										-- data_clk_0,
										-- start_send,
										-- start_past_send,
										-- packet_address_send,
										-- incoming_send,
										-- oddr_input_send,
										-- state_of_TX_FSM,
										-- ce_packet_send,
										-- packet_send
									-- ) is
	-- begin	
		-- if(rising_edge(data_clk_0)) 
			-- then

				-- start_send_debug(0)			<= start_send		;
				-- start_past_send_debug(0)	<= start_past_send  ;
				-- packet_address_send_debug <=  std_logic_vector(to_unsigned(packet_address_send, packet_address_send_debug'length)); --from integer to std_logic_vector
				-- incoming_send_debug(0)		<= incoming_send    ;
				-- oddr_input_send_debug		<= oddr_input_send  ;
				-- state_of_TX_FSM_debug <=  state_of_TX_FSM; 
				-- ce_packet_send_debug(0) <=  ce_packet_send; 
				
				-- packet_send_debug(29 downto 0 ) <= packet_send(0);
				-- packet_send_debug(59 downto 30) <= packet_send(1);
				-- packet_send_debug(89 downto 60) <= packet_send(2);
				

		-- end if;	
	-- end process;
	-- ---------------


	
	
	
-- ILA_RX_SIDE: ila_2
-- Port map
-- (
	-- clk => data_clk_forward,
	
	-- probe0 => incoming_recv_debug,
	-- probe1 => incoming_past_recv_debug,
	-- probe2 => packet_address_recv_debug,--16bit
	-- probe3 => packet_valid_recv_debug,    
	-- probe4 => packet_recv_debug, --90bit  data_in
	-- probe5 => state_of_RX_FSM_debug, --16bit	
	-- probe6 => ce_packet_recv_debug, --16bit	
	-- probe7 => iddr_output_recv_debug --16bit	
-- );


	-- ILA_RX_SIDE_REGISTER : process
									-- (
										-- data_clk_forward,
										
										-- incoming_recv,
										-- incoming_past_recv,
										-- packet_address_recv,--16bit
										-- packet_valid_recv,    
										-- iddr_output_recv,
										-- data_in, --90b
										-- state_of_RX_FSM,
										-- ce_packet_recv
									-- ) is
	-- begin	
		-- if(rising_edge(data_clk_forward)) 
			-- then

				-- incoming_recv_debug(0)       <= incoming_recv; 
				-- incoming_past_recv_debug(0)  <= incoming_past_recv; 
				-- --packet_address_recv_debug <= packet_address_recv,--16bit 
				-- packet_address_recv_debug <=  std_logic_vector(to_unsigned(packet_address_recv, packet_address_recv_debug'length)); --from integer to std_logic_vector				
				-- packet_valid_recv_debug(0)   <= packet_valid_recv;    
				-- iddr_output_recv_debug 		  <= iddr_output_recv;	
				-- packet_recv_debug 		  <= data_in;	--90bit  data_in	
				-- state_of_RX_FSM_debug <=  state_of_RX_FSM; 
				-- ce_packet_recv_debug(0) <=  ce_packet_recv; 
				
		-- end if;	
	-- end process;

end ARCH;

--=================================================================================================