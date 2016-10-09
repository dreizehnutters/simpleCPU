library IEEE;
use IEEE.std_logic_1164.all; -- import std_logic types
--use IEEE.std_logic_arith.all; -- import add/sub of std_logic_vector
--use IEEE.std_logic_unsigned.all;
--use IEEE.math_real.all; -- import floor for real 
use IEEE.numeric_std.all; -- for type conversion to_unsigned

--library STD;
--use STD.textio.all;

--------------------------------------------------------------------------------
--!@file: SEGMENT_DECODE.vhd
--!@brief: this is a 7 segment decoder
--
--!@author: Tobias Koal(TK)
--!@revision info :
-- last modification by tkoal(TK)
-- Tue Dec 13 10:19:17 CET 2011
--------------------------------------------------------------------------------

-- entity description

entity SEGMENT_DECODE is
port(   
		MS_byte     :   IN  std_logic_vector(7 downto 0);
		seg100      :   OUT std_logic_vector(7 downto 0);
		seg10       :   OUT std_logic_vector(7 downto 0);
		seg1        :   OUT std_logic_vector(7 downto 0)
);
end entity;

-- architecture description

architecture behave of SEGMENT_DECODE is


	-- CONSTANTS (upper case only!)


	-- SIGNALS (lower case only!)
	signal int, int100, int10, int1 : integer;


	-- COMPONENTS

begin

	int <= to_integer(unsigned(MS_byte));
	int1   <= int mod 10;
	int10  <= ((int - int1)/10) mod 10;
	int100 <= ((int - int1 - int10)/100) mod 10;



	-- 100
	WITH int100 SELECT
	   seg100 <= "00000010" WHEN 0, --0
                 "10011110" WHEN 1,
                 "00100100" WHEN 2,
                 "00001100" WHEN 3,
                 "10011000" WHEN 4,
                 "01001000" WHEN 5,
                 "11000000" WHEN 6,
                 "00011110" WHEN 7,
                 "00000000" WHEN 8,
                 "00011000" WHEN 9,
				 "00000010" WHEN others;
	-- 10
	WITH int10 SELECT
	   seg10  <= "00000010" WHEN 0, --0
                 "10011110" WHEN 1,
                 "00100100" WHEN 2,
                 "00001100" WHEN 3,
                 "10011000" WHEN 4,
                 "01001000" WHEN 5,
                 "11000000" WHEN 6,
                 "00011110" WHEN 7,
                 "00000000" WHEN 8,
                 "00011000" WHEN 9,
				 "00000010" WHEN others;

	-- 100
	WITH int1 SELECT
	   seg1   <= "00000010" WHEN 0, --0
                 "10011110" WHEN 1,
                 "00100100" WHEN 2,
                 "00001100" WHEN 3,
                 "10011000" WHEN 4,
                 "01001000" WHEN 5,
                 "11000000" WHEN 6,
                 "00011110" WHEN 7,
                 "00000000" WHEN 8,
                 "00011000" WHEN 9,
				 "00000010" WHEN others;



end behave;

