--------------------------------------------------------------------------------
-- Author:        Elahe Jalalpour (el.jalalpour@gmail.com)
--
-- Create Date:   28-08-2015
-- Module Name:   hem.vhd
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity hem is
port(a, b : in std_logic_vector(3 downto 0);
	  r : out std_logic_vector(7 downto 0));
end hem;

architecture rtl of hem is
	component mul
	port(a, b : in std_logic_vector(1 downto 0);
		  cout : out std_logic_vector(3 downto 0));
	end component;
	signal in1, in2, in3, in4 : std_logic_vector(1 downto 0);
begin
	in1(0) <= a(0);
	in1(1) <= b(2);
	in2(0) <= a(2);
	in2(1) <= b(0);
	in3(0) <= a(1);
	in3(1) <= b(3);
	in4(0) <= a(3);
	in4(1) <= b(1);
M0: mul port map (in1, in2, r(3 downto 0));
M1: mul port map (in3, in4, r(7 downto 4));
end rtl;
