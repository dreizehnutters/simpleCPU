library ieee ;
	use ieee.std_logic_1164.all ;
	use ieee.numeric_std.all ;

entity FLAG is
  port 
  (
  clk_enable,sel,rst,clk : in std_logic;
  ALUFlag : in std_logic_vector(1 downto 0);
  FLAGout : out std_logic_vector(1 downto 0)
  );

end entity ; -- FLAG

architecture arch of FLAG is



signal reg_val,tmp : std_logic_vector(1 downto 0);

begin
	reg_val <= ALUFlag when sel = '1' else
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
FLAGout <= tmp;



--signal tmp : std_logic_vector(1 downto 0);

--begin

--process( rst,clk )
--begin
--	if (rst = '1') then
--		tmp <= (others => '0');
--	elsif (rising_edge(clk)) then
--		if (clk_enable = '1') then
--			if (sel = '1') then
--				tmp <= ALUFlag;
--			else
--				tmp <= tmp;
--			end if ;
--		end if ;
--	end if;
--	FLAGout <= tmp;
--end process ; -- 
end architecture ; -- arch