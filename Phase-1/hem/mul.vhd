--------------------------------------------------------------------------------
-- Author:        Elahe Jalalpour (el.jalalpour@gmail.com)
--
-- Create Date:   28-08-2015
-- Module Name:   mul.vhd
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity mul is
port(a,b : in std_logic_vector(1 downto 0);
	  cout : out std_logic_vector(3 downto 0));
end mul;

architecture rtl of mul is
	component ha
		port(a, b : in std_logic;
			s, c : out std_logic);
	end component;
	signal y : std_logic;
	signal hell1, hell2, hell3:std_logic;
begin 

	cout(0) <= a(0) and b(0);
	hell1<=a(0) and b(1);
	hell2<=a(1) and b(0);
	hell3<=a(1) and b(1);
	L1: ha port map (hell1, hell2, cout(1), y);
	L2: ha port map (y, hell3, cout(2), cout(3));

end rtl;
