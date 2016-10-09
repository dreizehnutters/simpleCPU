library ieee ;
	use ieee.std_logic_1164.all ;
	use ieee.numeric_std.all ;

entity bitAdder8 is
  port (
	zweibx,zweiby : in std_logic_vector(7 downto 0);
	cin : in std_logic;
	sum : out std_logic_vector(7 downto 0); 
	Cout: out std_logic
  ) ;
end entity ; -- 8bitAdder

architecture arch of bitAdder8 is

signal tmp_cout0 : std_logic;
signal tmp_cout1 : std_logic;
signal tmp_cout2 : std_logic;
signal tmp_cout3 : std_logic;
signal tmp_cout4 : std_logic;
signal tmp_cout5 : std_logic;
signal tmp_cout6 : std_logic;
signal tmp_cout7 : std_logic;

begin
V0:entity work.voll(one)
 port map
	(
	x1 => zweibx(0),
	y1 => zweiby(0),
	sum => sum(0),
	cin => cin,
	cout => tmp_cout0
	);
V1:entity work.voll(one)
 port map
	(
	x1 => zweibx(1),
	y1 => zweiby(1),
	sum => sum(1),
	cin => tmp_cout0,
	cout => tmp_cout1
	);
V2:entity work.voll(one)
port map
	(
	x1 => zweibx(2),
	y1 => zweiby(2),
	sum => sum(2),
	cin => tmp_cout1,
	cout => tmp_cout2
	);
V3:entity work.voll(one)
 port map
	(
	x1 => zweibx(3),
	y1 => zweiby(3),
	sum => sum(3),
	cin => tmp_cout2,
	cout => tmp_cout3
	);
V4:entity work.voll(one)
port map
	(
	x1 => zweibx(4),
	y1 => zweiby(4),
	sum => sum(4),
	cin => tmp_cout3,
	cout => tmp_cout4
	);
V5:entity work.voll(one)
 port map
	(
	x1 => zweibx(5),
	y1 => zweiby(5),
	sum => sum(5),
	cin => tmp_cout4,
	cout => tmp_cout5
	);
V6:entity work.voll(one)
port map
	(
	x1 => zweibx(6),
	y1 => zweiby(6),
	sum => sum(6),
	cin => tmp_cout5,
	cout => tmp_cout6
	);
V7:entity work.voll(one)
 port map
	(
	x1 => zweibx(7),
	y1 => zweiby(7),
	sum => sum(7),
	cin => tmp_cout6,
	cout => Cout
	);

end architecture ; -- arch