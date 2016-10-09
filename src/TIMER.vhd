library ieee ;
use ieee.std_logic_1164.all ;
use ieee.numeric_std.all ;

entity TIMER is
  port 
  (
  clk_enable,inc,rst,clk : in std_logic;
  TIMERout : out std_logic_vector(1 downto 0)
  );

end entity ; -- TIMER

architecture arch of TIMER is

signal reg_val,tmp : std_logic_vector(1 downto 0);

begin

	reg_val <= (std_logic_vector(unsigned(tmp)+1)) when inc = '1' else
 				"00"; 	        
	process(CLK,rst)
	begin
	  	if (rst = '1') then
			tmp <= (others => '0');
		elsif (rising_edge(clk)) then
			if (clk_enable = '1') then
				tmp <= reg_val;		
			end if ;
		end if ;
	end process ; -- 

TIMERout <= tmp;


--signal tmp : std_logic_vector(1 downto 0);
----00 -> 01 t1 
----01 -> 10 t2
----10 -> 11 t3
----11 -> 00 t0
--begin
 
--process(clk,rst,clk_enable,tmp)
--begin
--	if (rst = '1') then
--		tmp <= "00";
--	else
--		if (clk_enable = '1') then
--			if (rising_edge(clk)) then
--				if (inc = '1') then
--					if (tmp = "11") then
--			 			tmp <= "00";
--			 		elsif (tmp = "00") then
--			 			tmp <= "01";
--			 		elsif (tmp = "01") then
--			 			tmp <= "10";
--			 		elsif (tmp = "10") then
--			 			tmp <= "11";
--			 		else
--			 			tmp <= "00";
--					end if ;
--				end if;
--			end if;
--		 end if ;
--	end if ;
--	TIMERout <= tmp;
--end process ; -- 

end architecture ; -- arch