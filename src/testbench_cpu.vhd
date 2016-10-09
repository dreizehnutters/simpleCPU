library ieee ;
	use ieee.std_logic_1164.all ;
	use ieee.numeric_std.all ;

entity testbench_cpu is
end entity ; -- testbench_cpu

architecture arch of testbench_cpu is


signal resett,clkt,clkk,write_ent,clk_enablet,muxSELt : std_logic;
signal data_int,addresst,data_outt,irt,mart,pct,acct,alut,muxt: std_logic_vector(7 downto 0) ;
signal timert,clIRt,clTimer : std_logic_vector(1 downto 0) ;

begin

process 
    begin
        clkk <= '0';
        wait for 10 ns;
        clkk <= '1';
        wait for 10 ns;
    end process;

trst1 : entity work.CPU
	port map 
	(
		clk => clkt,
		reset =>      resett,
		clk_enable => clk_enablet,
		data_in =>   data_int,
		address =>   addresst,
		data_out =>  data_outt,
		write_en  => write_ent
		--timer => timert,
		--ir => irt,
		--mar =>mart,			
		--pc =>pct,			 
		--acc =>acct,			
		--alu =>alut, 		 
		--mux => muxt, 		 
		--clIR =>clIRt,		 
		--muxSEL => muxSELt,
		--clTimer => clTimer		

		);
clkt <= clkk;
resett <= '1', '0' after 20 ns;
clk_enablet <= '1', '0' after 30 ns, '1' after 40 ns;
data_int <= "00000000";--"00000001" after 50 ns, "11111110" after 70 ns;


end architecture ; -- arch