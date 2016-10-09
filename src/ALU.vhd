library ieee ;
use ieee.std_logic_1164.all ;
use ieee.numeric_std.all ;
--use ieee.std_logic_arith.all;  

--TODO SUBBER,SUBCARRY,TESTING,JIZZ
entity ALU is
  port 
  (
  OP : in std_logic_vector(3 downto 0);
  ACCout,data_in : in std_logic_vector(7 downto 0);
  FLAGout : in std_logic_vector(1 downto 0);
  ALUout : out std_logic_vector(7 downto 0);
  ALUFlag : out std_logic_vector(1 downto 0)
  );
  --ALUFlag = ZERO,CARRAY
  --Flag lesen 
end entity ; -- ALU

architecture arch of ALU is
	signal ergA,ergS : std_logic_vector(7 downto 0) ;
	signal kompb : std_logic_vector(7 downto 0) ;
	signal addOut,subOut,tmpFlag1,trash : std_logic;
	signal tmp : std_logic_vector(7 downto 0);

begin
	--sub mittels 2erkomp
	kompb <= std_logic_vector(unsigned(not data_in)+1);

adder : entity work.bitAdder8
	port map
	(
		zweibx => ACCout,
		zweiby => data_in,
		cin => FLAGout(0),
		sum => ergA, 
		Cout => addOut
	);

subber : entity work.bitAdder8
	port map
	(
		zweibx => ACCout,
		zweiby => kompb,
		cin => '0', --FLAGout(0),
		sum => ergS, 
		Cout => trash
	);

 --flag setzten
with tmp select
	tmpFlag1 <= '1' when "00000000",
				'0' when others	; 

with OP select
	ALUFlag(1) <= not FLAGout(1) when "1001",
				  tmpFlag1 when others;
with OP select
	ALUFlag(0) <= not FLAGout(0) when "1010",
				  addOut when "0100",
				  '0' when others;

with OP select
tmp <=    (ACCout and data_in)  when "0000",
		  (ACCout or data_in)   when "0001" ,
		  (ACCout xor data_in)  when "0010" ,
		  ergA 				    when "0100" ,
		  std_logic_vector(unsigned(not ergS)+1)   		    when "0011" ,
		  std_logic_vector(shift_left(unsigned(ACCout),1))  when "0101" ,
		  std_logic_vector(shift_right(unsigned(ACCout),1)) when "1101" ,
		  ACCout 				when "0111" ,
		  data_in 				when "0110" ,
		  not ACCout 			when "1011" ,
		  "00000000" when others;
ALUout <= tmp;

end architecture ; -- arch