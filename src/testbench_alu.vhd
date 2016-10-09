library ieee ;
	use ieee.std_logic_1164.all ;
	use ieee.numeric_std.all ;

entity testbench_alu is
end entity ; -- testbench_alu

architecture arch of testbench_alu is

signal op : std_logic_vector(3 downto 0);
signal ACCout,data_in,ALUout : std_logic_vector(7 downto 0) ;
signal FLAGout,ALUFlag : std_logic_vector(1 downto 0);

begin

test : entity work.ALU

port map 
	(
	OP => op,
 	ACCout => ACCout,
  	data_in => data_in,
  	FLAGout => FLAGout,
  	ALUout => ALUout,
  	ALUFlag => ALUFlag
	);


op <= "1000";
ACCout <= "00000000";
data_in <= "00000001";
FLAGout <= "00";
end architecture ; -- arch