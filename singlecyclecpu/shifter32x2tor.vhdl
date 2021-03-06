library ieee;
use ieee.std_logic_1164.all;

use work.mux2to1;

entity shifter32x2tor is
	port (S: in std_logic;
	      R: in std_logic_vector(31 downto 0);
	      O: out std_logic_vector(31 downto 0);
	      C: out std_logic);
end shifter32x2tor;

architecture behavior of shifter32x2tor is
	component mux2to1
		port (S: in std_logic;
		      R: in std_logic_vector(1 downto 0);
		      O: out std_logic);
	end component;
begin

	cons: for i in 31 downto 0 generate
		rightmost: if i=31 or i=30 generate
			mux_r: mux2to1 port map (S=>S, R(0)=>R(i), R(1)=>'0', O=>O(i));
		end generate;

		otherwise: if i/=31 and i/=30 generate
			mux_x: mux2to1 port map (S=>S, R(0)=>R(i), R(1)=>R(i+2), O=>O(i));
		end generate;
	end generate;

	C <= R(31);
end behavior;
