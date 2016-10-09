library ieee ;
	use ieee.std_logic_1164.all ;
	use ieee.numeric_std.all ;

entity MAR is
  port (clk_enable,sel,rst,clk : in std_logic;
 	    data_in : in std_logic_vector(7 downto 0);
 	    MARout : out std_logic_vector(7 downto 0));
end entity ; -- MAR

architecture arch of MAR is


signal reg_val,tmp : std_logic_vector(7 downto 0);

begin
	reg_val <= data_in when sel = '1' else
		   	   tmp;
	process(clk,rst)
	begin
	  	if (rst = '1') then
			tmp <= (others => '0'); --00001101; ??
		elsif (CLK'event and CLK ='1') then
			if (clk_enable = '1') then
				tmp <=	reg_val;	
			end if ;
		end if ;
	end process ; -- 
MARout <= tmp;


end architecture ; -- arch