library IEEE;
use IEEE.std_logic_1164.all; -- import std_logic types
--use IEEE.std_logic_arith.all; -- import add/sub of std_logic_vector
--use IEEE.std_logic_unsigned.all;
--use IEEE.math_real.all; -- import floor for real 
use IEEE.numeric_std.all; -- for type conversion to_unsigned

--library STD;
--use STD.textio.all;

--------------------------------------------------------------------------------
--!@file: TOP_CPU.vhd
--!@brief: this is the top level of the architecture
--! this entity simply connect CPU and MEMORY
--
--!@author: Tobias Koal(TK)
--!@revision info :
-- last modification by tkoal(TK)
-- Tue Dec 13 10:19:20 CET 2011
--------------------------------------------------------------------------------

-- entity description

entity TOP_CPU is
port(
		clk, reset              :       IN      std_logic;
		seg100, seg10, seg1     :       OUT     std_logic_vector(0 to 7)
		--MS_byte 				: buffer std_logic_vector(7 downto 0)
);
end entity;

-- architecture description

architecture struct of TOP_CPU is


	-- CONSTANTS (upper case only!)


	-- SIGNALS (lower case only!)
	signal address : std_logic_vector(7 downto 0);
	signal data_from_mem : std_logic_vector(7 downto 0);
	signal data_to_mem : std_logic_vector(7 downto 0);
	signal MS_byte : std_logic_vector(7 downto 0);
	signal write_en : std_logic;
	signal clk_enable : std_logic;

begin


	CPU1    : entity work.cpu(behave)
	port map (
				clk     => clk,
				clk_enable => clk_enable,
				reset   => reset,
				address => address,
				data_in => data_from_mem,
				data_out=> data_to_mem,
				write_en=> write_en
		  );

	MEM1    : entity work.mem(behave) 
	port map (
				clk             => clk,
				clk_enable => clk_enable,
				reset           => reset,
				data_from_mem   => data_from_mem,
				data_to_mem     => data_to_mem,
				address         => address,
				write_en        => write_en,
				MS_byte         => MS_byte
		  );

	CLK_DIV1    : entity work.clk_div(behave)
	port map (
				reset           => reset,
				clk_enable => clk_enable,
				clk             => clk
		  );

	SEGMENT_DECODE1 : entity work.segment_decode(behave)
	port map (
				MS_byte     =>  MS_byte,
				seg100      =>  seg100,
				seg10       =>  seg10,
				seg1        =>  seg1
		  );



end struct;

