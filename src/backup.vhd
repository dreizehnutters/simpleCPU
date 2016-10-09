library ieee ;
use ieee.std_logic_1164.all ;
use ieee.numeric_std.all ;

entity CL is
  port 
  (
  IRout : in std_logic_vector(7 downto 0);
  TIMERout,FLAGout : in std_logic_vector(1 downto 0);
  ALU_OP : out std_logic_vector(3 downto 0);
  mux,cl_wirte_en : out std_logic;
  pc : out std_logic_vector(2 downto 0);
  mar,acc,ir,flag,timer : out std_logic_vector(1 downto 0)
  --reset : in std_logic
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
 
mux <= '1' when (ins = LDA and TIMERout = "10") or --LDA T10 
				(ins = STA and TIMERout = "10") or
				((not(ins = LDA) and (not(ins = STA))) and TIMERout = "01") or
				(reset = '1') or
				(TIMERout = "00") else
	   '0' when (ins = LDA and TIMERout = "01") or --LDA T01
	   			(ins = STA and TIMERout = "01") else --??
	   'Z'; 

--inc,rst,sel
pc <= "101" when (TIMERout = "00") or
		    	 (ins = LDA and TIMERout = "01") or --LDA T01 pc <= addr+1
		    	 (ins = STA and TIMERout = "01") or --STA T01 
		    	 (ins = MAND and TIMERout = "01") or --AND T01
		    	 (ins = MOR and TIMERout = "01") or
		    	 (ins = BRA_Z and FLAGout(1) = '0') or
	  			 (ins = BRA_NZ and FLAGout(1) = '1') or 
	  			 (ins = BRA_C and FLAGout(0) = '0') or
	  			 (ins = BRA_NC and FLAGout(0) = '1') or
	  			 ((not(ins = LDA) and (not(ins = STA))) and TIMERout = "01")else
	  "011" when (reset = '1') else
	  "001" when (TIMERout = "10") else
	  "000" when (ins = BRA_Z and FLAGout(1) = '1') or
	  			 (ins = BRA_NZ and FLAGout(1) = '0') or 
	  			 (ins = BRA_C and FLAGout(0) = '1') or
	  			 (ins = BRA_NC and FLAGout(0) = '0') else
	  "ZZZ";
--"rst,sel" | "rst,inc"
mar <= "01" when (ins = LDA and TIMERout = "01") or --LDA T01
				 (ins = STA and TIMERout = "01") else --STA T01 mar <= datain
	   "00" when others;
	   --((not(ins = LDA) and (not(ins = STA))) and TIMERout = "01") else
	   --"ZZ";

acc <= "01" when (ins = LDA and TIMERout = "10") or --LDA T10
				 (ins = STA and TIMERout = "10") or --STA T10
				 (ins = MAND ) or
				 (ins = MOR ) or
				 (ins = MXOR ) or
				 (ins = ADD ) or
				 (ins = SUB ) else
				 

				 --(not(ins = LDA) and (not(ins = STA))) and 
	   --"10" when (reset = '1') else
	   			"00" when others;
	   --(TIMERout = "00") or
	   --			 (ins = LDA and TIMERout = "01") or
	   --			 (ins = STA and TIMERout = "01") else
	   --"ZZ";
--rst/sel
ir <= "01" when (TIMERout = "00") else --IR fetch := ir<=datain ^= ir<=case(xyz)
	  "00" when (TIMERout = "01") or 
	  			(TIMERout = "10") else
	  "10" when (reset = '1') else
	  "ZZ";	

flag <= "10" when (reset = '1') else
		"01";
 
ALU_OP <= "0110" when (ins = LDA and TIMERout = "10") else --LDA T10 acc<=datain
		  "0111" when (ins = STA and TIMERout = "10") else --STA T10 acc<=dataout
		  "0000" when (ins = MAND and TIMERout = "01") else --AND T01 acc and datain
		  "0001" when (ins = MOR and TIMERout = "01") else
		  "0010" when (ins = MXOR and TIMERout = "01") else
		  "0100" when (ins = ADD and TIMERout = "01") else
		  "0011" when (ins = SUB and TIMERout = "01") else
		  "1011" when (ins = CMA and TIMERout = "01") else
		  "0101" when (ins = ASL and TIMERout = "01") else
		  "1101" when (ins = ASR and TIMERout = "01") else
		  "1010" when (ins = CMC and TIMERout = "01") else
		  "1001" when (ins = CMZ and TIMERout = "01") else
		  "1111" when (reset = '1') or
		  			  (ins = CLA and TIMERout = "01") else
		  "1111" when (TIMERout = "00") or
		  			  (ins = LDA and TIMERout = "01") or
		  			  (ins = NOP and TIMERout = "01") or
		  			  (ins = STA and TIMERout = "01") else
	      "ZZZZ";

timer <= "10" when (TIMERout = "10") or --T10
				   ((not(ins = LDA) and (not(ins = STA))) and TIMERout = "01") or --IROUT alles auszer LDA oder STA => timer <= 00
				   (reset = '1') else
	     "01" when (TIMERout = "00") or
	     		   ((ins = LDA or ins = STA) and TIMERout = "01") else --LDA T01
	     "ZZ";
cl_wirte_en <= '1' when (ins = STA and TIMERout = "10") else --STA T10 ram(addr) <= acc
			'0';

end architecture ; -- arc