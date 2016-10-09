library ieee;
use ieee.std_logic_1164.all;

entity voll is
  port (
	x1,y1,cin : in std_logic;
	sum, cout: out std_logic
  ) ;
end entity ; -- voll


architecture one of voll is

signal tmpSum,cout1,cout2:std_logic;

begin
H1:entity work.halb(one)
 port map
	(
	x =>x1,
	y =>y1,
	sum =>tmpSum,
	carry =>cout1
	);
H2:entity work.halb(one)
port map
	(
	x =>tmpSum,
	y =>cin,
	sum =>sum,
	carry =>cout2
	);
cout <= cout1 or cout2;
 
end architecture ; -- onevoll