------------------------------------------------------------------------------
-- fsl - entity/architecture pair
------------------------------------------------------------------------------
--
-- ***************************************************************************
-- ** Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.            **
-- **                                                                       **
-- ** Xilinx, Inc.                                                          **
-- ** XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"         **
-- ** AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND       **
-- ** SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,        **
-- ** OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,        **
-- ** APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION           **
-- ** THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,     **
-- ** AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE      **
-- ** FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY              **
-- ** WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE               **
-- ** IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR        **
-- ** REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF       **
-- ** INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS       **
-- ** FOR A PARTICULAR PURPOSE.                                             **
-- **                                                                       **
-- ***************************************************************************
--
------------------------------------------------------------------------------
-- Filename:          fsl
-- Version:           1.00.a
-- Description:       Example FSL core (VHDL).
-- Date:              Tue Jun 23 12:23:46 2015 (by Create and Import Peripheral Wizard)
-- VHDL Standard:     VHDL'93
------------------------------------------------------------------------------
-- Naming Conventions:
--   active low signals:                    "*_n"
--   clock signals:                         "clk", "clk_div#", "clk_#x"
--   reset signals:                         "rst", "rst_n"
--   generics:                              "C_*"
--   user defined types:                    "*_TYPE"
--   state machine next state:              "*_ns"
--   state machine current state:           "*_cs"
--   combinatorial signals:                 "*_com"
--   pipelined or register delay signals:   "*_d#"
--   counter signals:                       "*cnt*"
--   clock enable signals:                  "*_ce"
--   internal version of output port:       "*_i"
--   device pins:                           "*_pin"
--   ports:                                 "- Names begin with Uppercase"
--   processes:                             "*_PROCESS"
--   component instantiations:              "<ENTITY_>I_<#|FUNC>"
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity hem is
port(a,b : in std_logic_vector(3 downto 0);
	  r : out std_logic_vector(7 downto 0));
end hem;
architecture rtl of hem is
	component mul is
	port(a,b : in std_logic_vector(1 downto 0);
		  cout : out std_logic_vector(3 downto 0));
	end component;
	signal in1,in2,in3,in4 : std_logic_vector(1 downto 0);
begin
	in1(0) <= a(0);
	in1(1) <= b(2);
	in2(0) <= a(2);
	in2(1) <= b(0);
	in3(0) <= a(1);
	in3(1) <= b(3);
	in4(0) <= a(3);
	in4(1) <= b(1);
M0: mul port map (in1,in2,r(3 downto 0));
M1: mul port map (in3,in4,r(7 downto 4));
end rtl;
--------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mul is
port(a,b : in std_logic_vector(1 downto 0);
	  cout : out std_logic_vector(3 downto 0));
end mul;

architecture rtl of mul is
	component ha is
		port(a,b : in std_logic;
			  s,c : out std_logic);
	end component;
	signal y : std_logic;
begin 
	cout(0) <= a(0) and b(0);
	L1: ha port map (a(0) and b(1),a(1) and b(0),cout(1),y);
	L2: ha port map (y,a(1) and b(1),cout(2),cout(3));

end rtl;
-------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity hea is
port(a,b : in std_logic_vector(3 downto 0);
	  s : out std_logic_vector(7 downto 0));
end hea;

architecture rtl of hea is
	component ha is
		port(a,b : in std_logic;
			  s,c : out std_logic);
	end component;
begin 
L0: ha port map(b(3),a(0),s(0),s(1));
L1: ha port map(b(2),a(1),s(2),s(3));
L2: ha port map(b(1),a(2),s(4),s(5));
L3: ha port map(b(0),a(3),s(6),s(7));

end rtl;
--------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity ha is
port(a,b : in std_logic;
	  s,c : out std_logic);
end ha;

architecture rtl of ha is
begin
	s <= a xor b;
	c <= a and b;
end rtl;
-----------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--
--
-- Definition of Ports
-- FSL_Clk             : Synchronous clock
-- FSL_Rst           : System reset, should always come from FSL bus
-- FSL_S_Clk       : Slave asynchronous clock
-- FSL_S_Read      : Read signal, requiring next available input to be read
-- FSL_S_Data      : Input data
-- FSL_S_CONTROL   : Control Bit, indicating the input data are control word
-- FSL_S_Exists    : Data Exist Bit, indicating data exist in the input FSL bus
-- FSL_M_Clk       : Master asynchronous clock
-- FSL_M_Write     : Write signal, enabling writing to output FSL bus
-- FSL_M_Data      : Output data
-- FSL_M_Control   : Control Bit, indicating the output data are contol word
-- FSL_M_Full      : Full Bit, indicating output FSL bus is full
--
-------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Entity Section
------------------------------------------------------------------------------

entity fsl is
	port 
	(
		-- DO NOT EDIT BELOW THIS LINE ---------------------
		-- Bus protocol ports, do not add or delete. 
		FSL_Clk	: in	std_logic;
		FSL_Rst	: in	std_logic;
		FSL_S_Clk	: in	std_logic;
		FSL_S_Read	: out	std_logic;
		FSL_S_Data	: in	std_logic_vector(0 to 31);
		FSL_S_Control	: in	std_logic;
		FSL_S_Exists	: in	std_logic;
		FSL_M_Clk	: in	std_logic;
		FSL_M_Write	: out	std_logic;
		FSL_M_Data	: out	std_logic_vector(0 to 31);
		FSL_M_Control	: out	std_logic;
		FSL_M_Full	: in	std_logic
		-- DO NOT EDIT ABOVE THIS LINE ---------------------
	);

attribute SIGIS : string; 
attribute SIGIS of FSL_Clk : signal is "Clk"; 
attribute SIGIS of FSL_S_Clk : signal is "Clk"; 
attribute SIGIS of FSL_M_Clk : signal is "Clk"; 

end fsl;

------------------------------------------------------------------------------
-- Architecture Section
------------------------------------------------------------------------------

-- In this section, we povide an example implementation of ENTITY fsl
-- that does the following:
--
-- 1. Read all inputs
-- 2. Add each input to the contents of register 'sum' which
--    acts as an accumulator
-- 3. After all the inputs have been read, write out the
--    content of 'sum' into the output FSL bus NUMBER_OF_OUTPUT_WORDS times
--
-- You will need to modify this example or implement a new architecture for
-- ENTITY fsl to implement your coprocessor

architecture EXAMPLE of fsl is

   -- Total number of input data.
   constant NUMBER_OF_INPUT_WORDS  : natural := 1;

   -- Total number of output data
   constant NUMBER_OF_OUTPUT_WORDS : natural := 1;

   type STATE_TYPE is (Idle, Read_Inputs, Write_Outputs);

   signal state        : STATE_TYPE;

   -- Accumulator to hold sum of inputs read at any point in time
   signal sum          : std_logic_vector(0 to 31);

   -- Counters to store the number inputs read & outputs written
   signal nr_of_reads  : natural range 0 to NUMBER_OF_INPUT_WORDS - 1;
   signal nr_of_writes : natural range 0 to NUMBER_OF_OUTPUT_WORDS - 1;
	
	component hea is
		port(	a,b : in std_logic_vector(3 downto 0);
	 		 s : out std_logic_vector(7 downto 0));
	end component;

	component hem is
		port(	a,b : in std_logic_vector(3 downto 0);
	 		r : out std_logic_vector(7 downto 0));
	end component;
	signal temp : std_logic_vector(0 to 31); 	
	signal tmp_out1,tmp_out2 : std_logic_vector(0 to 15);
	

begin
	adder1 : hea port map(temp(28 to 31),temp(24 to 27),tmp_out1(8 to 15));    
	adder2 : hea port map(temp(20 to 23),temp(16 to 19),tmp_out1(0 to 7));
	mul1 : hem port map(temp(28 to 31),temp(24 to 27),tmp_out2(8 to 15));    
	mul2 : hem port map(temp(20 to 23),temp(16 to 19),tmp_out2(0 to 7));
		
	
		



   -- CAUTION:
   -- The sequence in which data are read in and written out should be
   -- consistent with the sequence they are written and read in the
   -- driver's fsl.c file

   FSL_S_Read  <= FSL_S_Exists   when state = Read_Inputs   else '0';
   FSL_M_Write <= not FSL_M_Full when state = Write_Outputs else '0';

   FSL_M_Data(16 to 31) <= tmp_out1 when temp(15) = '0' else
				   tmp_out2;
	
   FSL_M_Data(0 to 15) <= "0000000000000000";
   The_SW_accelerator : process (FSL_Clk) is
   begin  -- process The_SW_accelerator
    if FSL_Clk'event and FSL_Clk = '1' then     -- Rising clock edge
      if FSL_Rst = '1' then               -- Synchronous reset (active high)
        -- CAUTION: make sure your reset polarity is consistent with the
        -- system reset polarity
        state        <= Idle;
        nr_of_reads  <= 0;
        nr_of_writes <= 0;
        sum          <= (others => '0');
      else
        case state is
          when Idle =>
            if (FSL_S_Exists = '1') then
              state       <= Read_Inputs;
              nr_of_reads <= NUMBER_OF_INPUT_WORDS - 1;
              sum         <= (others => '0');
            end if;

          when Read_Inputs =>
            if (FSL_S_Exists = '1') then
              -- Coprocessor function (Adding) happens here
              -- sum         <= std_logic_vector(unsigned(sum) + unsigned(FSL_S_Data));
	      temp <= FSL_S_Data;
              if (nr_of_reads = 0) then
                state        <= Write_Outputs;
                nr_of_writes <= NUMBER_OF_OUTPUT_WORDS - 1;
              else
                nr_of_reads <= nr_of_reads - 1;
              end if;
            end if;

          when Write_Outputs =>
            if (nr_of_writes = 0) then
              state <= Idle;
            else
              if (FSL_M_Full = '0') then
                nr_of_writes <= nr_of_writes - 1;
              end if;
            end if;
        end case;
      end if;
    end if;
   end process The_SW_accelerator;
end architecture EXAMPLE;









