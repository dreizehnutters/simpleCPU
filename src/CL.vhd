library ieee ;
use ieee.std_logic_1164.all ;
use ieee.numeric_std.all ;

entity CL is
  port 
  (
  IRout : in std_logic_vector(7 downto 0);
  TIMERout,FLAGout : in std_logic_vector(1 downto 0);
  ALU_OP : out std_logic_vector(3 downto 0);
  mux,cl_wirte_en,mar,acc,ir,flag,timer : out std_logic;
  pc : out std_logic_vector(1 downto 0)
  );
  --flag(1) =zero,
  --flag(0) =carry
end entity ; -- CL

architecture arch of CL is

type orders is (LDA,STA,MAND,MOR,MXOR,ADD,SUB,JMP,BRA_Z,BRA_NZ,BRA_C,BRA_NC,NOP,CLA,CMA,ASL,ASR,CMC,CMZ,UD);
--UD = undefinded OP/INS ^= data or adr value
signal ins : orders;
--(LDA,STA,MAND,MOR,MXOR,ADD,SUB,JMP,BRA_Z,BRA_NZ,BRA_C,BRA_NC,NOP,CLA,CMA,ASL,ASR,CMC,CMZ);
	
begin
with IRout select
ins <=  LDA when "00000001",	--load acc mit wert aus address
		STA when "00000010",	--speicher mem(addresse) <= acc
		MAND when "00000011",   --acc<= acc and datain
		MOR when "00000100",    --acc<= acc or datain
		MXOR when "00000101",	--acc<= acc xor datain
		ADD when "00000110",	--acc<= acc + datain
		SUB when "00000111",	--acc<= acc - datain
		JMP when "00001000",	--pc<= datain
		BRA_Z when "00001001",	--pc<= datain if z=1
		BRA_NZ when "00001010",	--pc<= datain if z=0
		BRA_C when "00001011",  --pc<= datain if c=1
		BRA_NC when "00001100",	--pc<= datain if c=0
		NOP when "00001101",	--no op
		CLA when "00001110",	--acc<= "00000000"
		CMA when "00001111",	--acc<= not acc
		ASL when "00010000",	--acc<= shiftleft(acc,1)
		ASR when "00010001",	--acc<= shiftright(acc,1)
		CMC when "00010010",	--z <= not z
		CMZ when "00010011",	--c <= not c
		UD when others;			--ud = adr/data wert
 
 --'0' mux MAR
 --'1' mux PC
mux <= '0' when (ins = LDA and TIMERout = "10") or --LDA T01
	   			(ins = STA and TIMERout = "10") else --STA
	   '1';

--inc,sel
--"0,1" pc<=pc
--"1,1" pc<=pc+1
--"(1|0),0" pc<=datain 
----ALUFlag = ZERO,CARRAY
pc <= "11" when (TIMERout = "00") or
		    	(ins = LDA    and TIMERout = "01") or 
		    	(ins = STA    and TIMERout = "01") or --STA T01 
		    	(ins = MAND   and TIMERout = "01") or --AND T01
		    	(ins = MOR    and TIMERout = "01") or
		    	(ins = MXOR   and TIMERout = "01") or
		    	(ins = ADD    and TIMERout = "01") or
		    	(ins = SUB    and TIMERout = "01") or
		    	(ins = BRA_Z  and FLAGout(1) = not '1') or --bedingte jumps else condition
	  			(ins = BRA_NZ and FLAGout(1) = not '0') or 
	  			(ins = BRA_C  and FLAGout(0) = not '1') or
	  			(ins = BRA_NC and FLAGout(0) = not '0') else
	  "00" when (ins = JMP    and TIMERout = "01") or 
	  			(ins = BRA_Z  and FLAGout(1) = '1') or  --bedingete jumps condition = true
	  			(ins = BRA_NZ and FLAGout(1) = '0') or 
	  			(ins = BRA_C  and FLAGout(0) = '1') or
	  			(ins = BRA_NC and FLAGout(0) = '0') else
	  "01";
--'1' =mar <= datain
mar <= '1' when (ins = LDA and TIMERout = "01") or --LDA T01
				(ins = STA and TIMERout = "01") else --STA T01 mar <= datain
	   '0';
 
--'1' =  acc <= aluout
acc <= '1' when (ins = LDA  and TIMERout = "10") or --LDA T10
				(ins = STA  and TIMERout = "10") or --STA T10
				(ins = MAND and TIMERout = "01") or
				(ins = MOR  and TIMERout = "01") or
				(ins = MXOR and TIMERout = "01") or
				(ins = ADD  and TIMERout = "01") or
				(ins = SUB  and TIMERout = "01") else
	   '0';
	  
--'1' = ir <= datain
ir <= '1' when (TIMERout = "00") else --IR fetch := ir<=datain ^= ir<=case(xyz)
	  '0';
--'1' = flag <= aluflag
flag <= '1' when (ins = MAND and TIMERout = "01") or
				 (ins = MOR  and TIMERout = "01") or
				 (ins = MXOR and TIMERout = "01") or
				 (ins = ADD  and TIMERout = "01") or
				 (ins = SUB  and TIMERout = "01") else
		'0';

--"1111" = NOP = aluout = "0000000"
ALU_OP <= "0110" when (ins = LDA  and TIMERout = "10") else --LDA T10 acc<=datain
		  "0111" when (ins = STA  and TIMERout = "10") else --STA T10 dataout<=acc
		  "0000" when (ins = MAND and TIMERout = "01") else --AND T01 acc and datain
		  "0001" when (ins = MOR  and TIMERout = "01") else
		  "0010" when (ins = MXOR and TIMERout = "01") else
		  "0100" when (ins = ADD  and TIMERout = "01") else
		  "0011" when (ins = SUB  and TIMERout = "01") else
		  "1011" when (ins = CMA  and TIMERout = "01") else
		  "0101" when (ins = ASL  and TIMERout = "01") else
		  "1101" when (ins = ASR  and TIMERout = "01") else
		  "1010" when (ins = CMC  and TIMERout = "01") else
		  "1001" when (ins = CMZ  and TIMERout = "01") else
		  "1111";

--'0' = synchrones rst
--'1' = timer++
timer <= '1' when (TIMERout = "00") or
	     		  ((ins = LDA or ins = STA) and TIMERout = "01") else --LDA T01
	     '0';

cl_wirte_en <= '1' when (ins = STA and TIMERout = "10") else --STA T10 ram(addr) <= acc
			   '0';

end architecture ; -- arc