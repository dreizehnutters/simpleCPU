library ieee ;
	use ieee.std_logic_1164.all ;
	use ieee.numeric_std.all ;

entity testbench_top_cpu is
end entity ; -- testbench_top_cpu

architecture arch of testbench_top_cpu is


signal rst,clkk,clkkk : std_logic;
signal seg100,seg10,seg1: std_logic_vector(7 downto 0) ;

begin

process 
    begin
        clkk <= '0';
        wait for 10 ns;
        clkk <= '1';
        wait for 10 ns;
    end process;

trst1 : entity work.TOP_CPU
	port map 
	(
		clk => clkkk,
		reset => rst,
		seg100 => seg100,
		seg10 => seg10,
		seg1 => seg1
		--MS_BYTE => MS_BYTET
		);
clkkk <= clkk;
rst <= '1', '0' after 20 ns;

end architecture ; -- arch