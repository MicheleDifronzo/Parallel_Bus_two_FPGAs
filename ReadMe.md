# Low Latency Parallel Bus Interface for High Frequency multi-FPGA Communication

Copyright (C) 2019-2021 Michele Difronzo and Others

Point-to-point Paralle Bus (Pbus) communication interface FPGA design for high-speed communication between two Xilinx Ultrascale+ FPGA devices through FMC connection.
 
For more information follow look the literature

## Requirements and features

	*	Target board: Virtex UltraScale+ (US+) VCU118 Evaluation Platform (xcvu9p-flga2104-2L-e) 
	*	System manager design: Virtex VC707
	*	IDE: Xilinx VIVADO versions from 2018.2 for proper US+ IP resources
	*	HDL employed: VHDL
	*	HLS realized with: VIVADO HLS 2018.2 and above
	*	C++ 11 or 14 for HLS


## License

The Pbus FPGA design is licensed under the GNU General Public License (GPL) v3.0 (https://www.gnu.org/licenses/).

## Literature 
  
**The Pbus is presented in:**

M. Difronzo, H. L. Ginn and A. Benigni, "A Low Latency Parallel Bus Interface for High-Speed multi-FPGA RT-Simulations," 2021 IEEE Electric Ship Technologies Symposium (ESTS), 2021, pp. 1-7, doi: 10.1109/ESTS49166.2021.9512344.
url: https://www.sciencedirect.com/science/article/pii/S2352711021000054


## Acknowledgements
* Matthew Milton (University of South Carolina) - ORTiS solver codegen tools creator and lead developer
* Andrea Benigni (FZ-Juelich) - Professor and original creator of the LB-LMC method
* Herber L. Ginn  (University of South Carolina) Director of Energy Routing Lab @University of South Carolina



## Intro

The parallel bus interface is a low latency, point to point DDR based interface for high-speed communication between two FPGA devices.
The communication is realized through FMC flat cable conection and each  communicating US+ devices receives a clock and a state signal
via SM cable from the system manager design running on VC707.


## Status 

The parallel bus interface is complete and working and its operation is demonstrated in the aforementioned IEEE conferece paper.

## Operation principle

A 90bit word is serialized into three 30bit subwords and each one is sent in parallel over the FMC channel through a DDR based interface. The communication is 
full deplex and each package consist in a data word of 30bit, a forwarded clock and a valid flag. The overall system operation is based upon a Leap-Frog FSM
running on the system manager.  

For more detail download the paper. 

## Characteristics

The parallel bus is capable of exchanging a 90bit word once every 70ns where each subword is exchangde every 3.5ns.  Based on the Leap-Frog behavior, during the simulation
engine execution interval, each FPGA design generates its internal data word of 90bit, then during the communication interval of 35ns the words is exchanged in full duplex with the 
external FPGA.
 

## Target Applications

The parallel bus interface can be used for fast commuication applications such  high-frequency trading, high performance simulations etc.


## Source files

Currently the FPGA1 top level design with correlated files has been provided here. The design is the same for each communicating device.  
