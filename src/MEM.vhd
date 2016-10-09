library IEEE;
use IEEE.std_logic_1164.all; -- import std_logic types
--use IEEE.std_logic_arith.all; -- import add/sub of std_logic_vector
--use IEEE.std_logic_unsigned.all;
--use IEEE.math_real.all; -- import floor for real 
use IEEE.numeric_std.all; -- for type conversion to_unsigned

--library STD;
--use STD.textio.all;

--------------------------------------------------------------------------------
--!@file: MEM.vhd
--!@brief:  this is a simple synchronous RAM with 8 bit addresses and 8 bit data
--
--!@author: Tobias Koal(TK)
--!@revision info :
-- last modification by tkoal(TK)
-- Tue Dec 13 10:19:12 CET 2011
--------------------------------------------------------------------------------

-- entity description

entity MEM is
port(
		clk, reset      :       in      std_logic;
		clk_enable      :       in      std_logic;
		data_from_mem   :       out     std_logic_vector(7 downto 0);
		data_to_mem     :       in      std_logic_vector(7 downto 0);
		address         :       in      std_logic_vector(7 downto 0);
		write_en        :       in      std_logic;
		MS_byte         :       out     std_logic_vector(7 downto 0)
);
end entity;

-- architecture description

architecture behave of MEM is

	-- TYPES
	type memory is array (integer range 0 to 255) of std_logic_vector(7 downto 0);

	-- CONSTANTS (upper case only!)


	-- SIGNALS (lower case only!)
	signal ram : memory;

	-- COMPONENTS

begin


	mem : process (clk,reset)

	begin
		if reset = '1' then
			--start "data_in <= ram(0000000)"
			ram(0) <= "00000001";       -- LDA 
			ram(1) <= "11111110";       -- address
			--load ACC <= ram(254) = "00000000"
			ram(2) <= "00000010";       -- STA
			ram(3) <= "00000111";       -- address
			--ram(7) <= ACC; (ram(7) <= "00000000")
			ram(4) <= "00000001";       -- LDA
			ram(5) <= "11111111";       -- address
			--load ACC <= ramm(0) = "00000001" 
			ram(6) <= "00000110";       -- ADD
			--acc <= acc+datin = 1+0
			ram(7) <= "00000000";       -- data
			ram(8) <= "00000010";       -- STA
			ram(9) <= "11111100";       -- address
			--ram(252) <= acc+ datain = 1+0 = 1
			ram(10)<= "00000001";       -- LDA
			ram(11)<= "11111111";       -- address
			--load acc <= ram(0) = ACC = "00000001"
			ram(12)<= "00000010";       -- STA
			ram(13)<= "11111110";       -- address
			--ram(254) <= acc = 00000001
			ram(14)<= "00000001";       -- LDA
			ram(15)<= "11111100";       -- address
			--acc <= ram(252)
			ram(16)<= "00000010";       -- STA
			ram(17)<= "11111111";       -- address
			--ram(0) <= acc =000000001 --clear acc ???
			ram(18)<= "00000111";       -- SUB
			ram(19)<= "11101001";       -- data
			--acc = acc-datin =  00000001 - 11101001 = -232/24
			ram(20)<= "00001001";       -- BRA_Z
			--zero flag  = 0 => no jump
			--zero falg = 1 (acc = "00000000") => datain <= ram(20) ?
 			ram(21)<= "00010100";       -- address
			ram(22)<= "00001000";       -- JMP
			ram(23)<= "00000000";       -- address
			--datain <= ram(0)
			--output = 1 ?
			for i in 24 to 255 loop
				ram(i) <= (others => '0');
			end loop;
			ram(255) <= "00000001";
		elsif clk'event and clk = '1' then
		if clk_enable = '1' then
			-- memory write behavior
			if write_en = '1' then
				ram(to_integer(unsigned(address))) <= data_to_mem;
			end if;
		end if;
		end if;
	end process ;

	-- memory read behavior
	data_from_mem <= ram(to_integer(unsigned(address)));	

	-- to observe the highest byte of the memory
	MS_byte <= ram(255);


end behave;

