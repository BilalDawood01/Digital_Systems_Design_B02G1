library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Mux_for_Averager is
port (
	Mux_Switch   : in  std_logic;
	Pre_Ave   : in  std_logic_vector(11 downto 0); 
	Post_Ave     : in std_logic_vector(11 downto 0);
	Final_Out   : out std_logic_vector(11 downto 0)
);
end Mux_for_Averager;

architecture Mux_Behaviour of Mux_for_Averager is
	begin
		process (Mux_Switch,Pre_Ave,Post_Ave)
		begin
			case Mux_Switch is
				when '0' => Final_Out <= Pre_Ave;
				when '1' => Final_Out <= Post_Ave;
			end case;
	end process;
end Mux_Behaviour;