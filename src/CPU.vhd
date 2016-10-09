library IEEE;
use IEEE.std_logic_1164.all; -- import std_logic types
--use IEEE.std_logic_arith.all; -- import add/sub of std_logic_vector
--use IEEE.std_logic_unsigned.all;
--use IEEE.math_real.all; -- import floor for real 
use IEEE.numeric_std.all; -- for type conversion to_unsigned

--library STD;
--use STD.textio.all;

--------------------------------------------------------------------------------
--!@file: CPU.vhd
--!@brief: this is the entity of a simple accumulator cpu 
--
--!@author:
--!@revision info :
-- 
-- Date
--------------------------------------------------------------------------------

-- entity description

entity cpu is
port(
		clk, reset      :       in      std_logic;
		clk_enable      :       in      std_logic;
		data_in         :       in      std_logic_vector(7 downto 0);
		address         :       out     std_logic_vector(7 downto 0);
		data_out        :       out     std_logic_vector(7 downto 0);
		write_en        :       out     std_logic
		--timer 			: buffer std_logic_vector(1 downto 0);
		--ir				: buffer std_logic_vector(7 downto 0);
		--mar 			: buffer std_logic_vector(7 downto 0) ;
		--pc 				: buffer std_logic_vector(7 downto 0) ;
		--acc 			: buffer std_logic_vector(7 downto 0) ;
		--alu 			: buffer std_logic_vector(7 downto 0) ;
		--mux 			: buffer std_logic_vector(7 downto 0) ;
		
		
		 
);
end entity;

-- architecture description

architecture behave of cpu is
signal mar,pc,acc,alu,mux,ir : std_logic_vector(7 downto 0);
signal clMAR,clACC,clFLAG,clTimer,muxSEL,clIR : std_logic;
signal clPC,flag,aluFlag,timer : std_logic_vector(1 downto 0) ;
signal aluOP : std_logic_vector(3 downto 0) ;
--signal muxSEL : std_logic;

begin
data_out <= alu;
address <= mux;

	 
	 MAREntity : entity work.MAR
	 	port map
	 	(
	 	clk_enable => clk_enable,
	 	sel => clMAR,
	 	rst => reset, 
	 	clk => clk,
 	    data_in => data_in,
 	    MARout => mar
	 	);

	IREntity : entity work.IR
		port map 
		(
		clk_enable => clk_enable,
		sel => clIR,
		rst => reset,
		clk => clk,
		data_in => data_in,
		IRout => ir
 	    );

	ACCEntity : entity work.ACC
		port map
		(
		clk_enable => clk_enable,
		sel => clACC,
		rst => reset, 
		clk => clk,
 	    ALUout => alu,
 	    ACCout => acc
 	    );
		 
	FLAGEntity : entity work.FLAG
		port map 
		(
		clk_enable => clk_enable,
		sel => clFLAG,
		rst => reset, 
		clk => clk,
		ALUFlag => aluFlag,
		FLAGout => flag
 	    );

	PCEntity : entity work.PC
		port map
		( 
		inc => clPC(1),
		sel => clPC(0),
		rst => reset, 
		clk => clk,
		clk_enable => clk_enable,
		data_in => data_in,
		PCout => pc
		);

 	TIMEREntity : entity work.TIMER
		port map
		(
		clk_enable => clk_enable,
		inc => clTimer,
		rst => reset, 
		clk => clk,
		TIMERout => timer
		);

 	ALUEntity : entity work.ALU
		port map
		(
		OP => aluOP, 
		ACCout => acc,
		data_in => data_in,
		FLAGout => flag,
		ALUout => alu,
		ALUFlag => aluFlag
		);

 	MUXEntity : entity work.MUX
		port map
		(
		PCout => pc,
		MARout => mar,
		sel => muxSEL,
		address => mux
		);

 	CLEntity : entity work.CL
 		port map
 		(
 		IRout => ir,
	    TIMERout => timer,
	    FLAGout => flag,
	    ALU_OP => aluOP,
	    mux => muxSEL,
	    cl_wirte_en => write_en,
	    pc => clPC,
	    mar => clMAR,
	    acc => clACC,
	    ir => clIR,
	    flag => clFLAG,
	  	timer => clTimer	    
 		);

end behave;