library ieee ;
	use ieee.std_logic_1164.all ;
	use ieee.numeric_std.all ;

entity MUX is
  port 
  (
  PCout,MARout : in std_logic_vector(7 downto 0);
  sel : in std_logic;
  address : out std_logic_vector(7 downto 0)
  );

end entity ; -- MUX

architecture arch of MUX is

begin

WITH sel SELECT
	address <= PCout when '1',
			   MARout when '0',
			   "00000000" when others;

end architecture ; -- arch