library ieee ;
	use ieee.std_logic_1164.all ;
	use ieee.numeric_std.all ;

entity PC is
  port 
  (
  inc,sel,rst,clk,clk_enable : in std_logic;
  data_in : in std_logic_vector(7 downto 0);
  PCout : out std_logic_vector(7 downto 0)
  );

end entity ; -- PC

architecture arch of PC is

signal reg_val,next_val,tmp : std_logic_vector(7 downto 0);

begin

 	next_val <= (std_logic_vector(unsigned(tmp)+1)) when inc = '1' else
 				tmp; 	        

	reg_val <= data_in when sel = '0' else
		   	   next_val;

	process(CLK,rst,clk_enable)
	begin
	  	if (rst = '1') then
			tmp <= (others => '0');
		elsif (clk_enable = '1') then
			if (CLK'event and CLK ='1') then
				tmp <=	reg_val;		
			end if ;
		end if ;
	end process ; -- 

PCout <= tmp;



--signal tmp : std_logic_vector(7 downto 0);

--begin

--WITH sel SELECT
--		PCout <= tmp when '1',
--				 data_in when '0',
--				 "ZZZZZZZZ" when others;


--process( rst,clk,inc )
--begin
--	if (rst = '1') then
--		tmp <= (others => '0');
--	elsif (rising_edge(clk)) then
--		if (clk_enable = '1') then
--			if (inc = '1') then
--				tmp <= (std_logic_vector(unsigned(tmp)+1));
--			else
--				tmp <= tmp;
--			end if ;
--		end if ;
--	end if;
--end process ; -- 


-- signal	tmp : std_logic_vector(7 downto 0);

--begin
 
--	WITH sel SELECT
--		PCout <= data_in when '0',
--				 tmp when '1',
--				 "ZZZZZZZZ" when others;

--process(sel,rst,clk,clk_enable,data_in,inc)
--begin
--	if (rst = '1') then
--		tmp <= (others => '0');
--	else
--		if (clk_enable = '1') then
--			if (rising_edge(clk)) then
--				if (inc = '1') then
--					tmp <= (std_logic_vector(unsigned(tmp)+1));
--				end if ;
--			end if;
--		end if ;
--	end if ;
	
--end process ; -- identifier

end architecture ; -- arch