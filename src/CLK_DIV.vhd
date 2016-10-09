library IEEE;
use IEEE.std_logic_1164.all; -- import std_logic types
--use IEEE.std_logic_arith.all; -- import add/sub of std_logic_vector
--use IEEE.std_logic_unsigned.all;
--use IEEE.math_real.all; -- import floor for real 
use IEEE.numeric_std.all; -- for type conversion to_unsigned

--library STD;
--use STD.textio.all;

--------------------------------------------------------------------------------
--!@file: CLK_DIV.vhd
--!@brief: this is a clk divider from 50MHz to 20Hz
--
--!@author: Tobias Koal(TK)
--!@revision info :
-- last modification by tkoal(TK)
-- Tue Dec 13 10:18:43 CET 2011
--------------------------------------------------------------------------------

-- entity description

entity CLK_DIV is	
port(
		reset         :   IN  std_logic;
		clk             :   IN  std_logic;
		clk_enable         :   OUT std_logic
);
end entity;

-- architecture description

architecture behave of CLK_DIV is


	-- CONSTANTS (upper case only!)


	-- SIGNALS (lower case only!)


	-- COMPONENTS

begin

	clk_div_process : process (clk,reset)
		variable counter    :   integer;
		variable clk_enable_intern :   std_logic;

	begin
		if reset = '1' then
			counter := 0;
			clk_enable_intern := '0';
		elsif clk'event and clk = '1' then
			if counter < 2500000 then
				counter := counter + 1;
				clk_enable_intern := '0';
			else
				counter := 0;
				clk_enable_intern := '1'; 
			end if;
		end if;
		clk_enable <= clk_enable_intern;
	end process ;


end behave;

