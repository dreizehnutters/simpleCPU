library ieee ;
	use ieee.std_logic_1164.all ;
	use ieee.numeric_std.all ;

entity testbench_cl is
end entity ; -- testbench_cl

architecture arch of testbench_cl is


signal  IRout :  std_logic_vector(7 downto 0);
signal  TIMERout,FLAGout :  std_logic_vector(1 downto 0);
signal  ALU_OP :std_logic_vector(3 downto 0);
signal  mux,cl_wirte_en,mar,acc,ir,flag,timer : std_logic;
signal  pc :std_logic_vector(1 downto 0);
 
begin

test : entity work.CL

port map 
	(
	IRout =>IRout,
  	TIMERout =>TIMERout,
  	FLAGout =>FLAGout,
  	ALU_OP =>ALU_OP,
  	mux => mux,
  	cl_wirte_en =>cl_wirte_en,
    mar =>mar,
    acc =>acc,
    ir =>ir,
    flag =>flag,
    timer =>timer,
  	pc =>pc	

	);


IRout <= "00000000";
TIMERout <= "00";
FLAGout <= "00";
end architecture ; -- arch