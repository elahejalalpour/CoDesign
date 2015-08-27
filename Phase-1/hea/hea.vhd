--------------------------------------------------------------------------------
-- Author:        Elahe Jalalpour (el.jalalpour@gmail.com)
--
-- Create Date:   27-08-2015
-- Module Name:   hea.vhd
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity hea is
port(a, b : in std_logic_vector(3 downto 0);
	  s : out std_logic_vector(7 downto 0));
end hea;

architecture rtl of hea is
	component ha
		port(a, b : in std_logic;
			  s, c : out std_logic);
	end component;
begin
L0: ha port map(b(3),a(0),s(0),s(1));
L1: ha port map(b(2),a(1),s(2),s(3));
L2: ha port map(b(1),a(2),s(4),s(5));
L3: ha port map(b(0),a(3),s(6),s(7));

end rtl;
