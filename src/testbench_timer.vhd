library ieee ;
	use ieee.std_logic_1164.all ;
	use ieee.numeric_std.all ;

entity testbench_timer is

end entity ; -- testbench_timer

architecture arch of testbench_timer is

signal clk_enablet, inct, rstt, clkt,clkk : std_logic;
signal TIMERoutt : std_logic_vector(1 downto 0) ;



begin
process 
    begin
        clkk <= '0';
        wait for 10 ns;
        clkk <= '1';
        wait for 10 ns;
    end process;

test : entity work.TIMER
	port map 
	(
		clk_enable => clk_enablet, 
		inc => inct,
		rst => rstt,
		clk => clkt,
  		TIMERout => TIMERoutt
	);


clkt <= clkk;
clk_enablet <= '1';
inct <= '0';
rstt <= '1', '0' after 10 ns;
end architecture ; -- arch