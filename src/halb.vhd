library ieee;
use ieee.std_logic_1164.all;
 
entity halb is
  port (
	x, y : in std_logic;
	sum, carry : out std_logic
  ) ;
end entity ; -- halb

architecture one of halb is

begin

sum <= x xor y; --(not x and y ) or (x and not y)
carry <= x and y; --uebertrag

end architecture ; -- onehalb