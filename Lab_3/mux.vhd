library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Mux_for_Averager is
port (
	Mux_Switch   : in  std_logic;
	Voltage_v2d   : in  std_logic_vector(11 downto 0); 
	Distance_v2d     : in std_logic_vector(11 downto 0);
	Final_Out   : out std_logic_vector(11 downto 0)
);
end Mux_for_Averager;

architecture Mux_Behaviour of Mux_for_Averager is
	begin
		process (Mux_Switch,Voltage_v2d,Distance_v2d)
		begin
			case Mux_Switch is
				when '0' => Final_Out <= Voltage_v2d;
				when '1' => Final_Out <= Distance_v2d;
				when others => Final_Out <= Distance_v2d;
			end case;
	end process;
end Mux_Behaviour;