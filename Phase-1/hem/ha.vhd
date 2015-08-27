--------------------------------------------------------------------------------
-- Author:        Elahe Jalalpour (el.jalalpour@gmail.com)
--
-- Create Date:   28-08-2015
-- Module Name:   ha.vhd
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity ha is
port(a, b : in std_logic;
	  s, c : out std_logic);
end ha;

architecture rtl of ha is
begin
	s <= a xor b;
	c <= a and b;
end rtl;
