library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity period_changer is
   Port    ( reset      : in STD_LOGIC;
             clk        : in STD_LOGIC;
             period : in STD_LOGIC_VECTOR (11 downto 0);
             buzzer    : out STD_LOGIC
           );
end period_changer;

architecture Behavioral of period_changer is
   signal counter : unsigned (15 downto 0);
       
begin
   count : process(clk,reset)
   begin
       if( reset = '1') then
           counter <= (others => '0');
       elsif (rising_edge(clk)) then 
           counter <= counter + 1; 
			  
			 if (counter = unsigned(period)*2*2*2*2) then
					counter <= (others => '0');
				end if;
		 end if;
   end process;
 
   compare : process(counter, period)
   begin
       if (counter < unsigned(period(11 downto 1))*2*2*2*2) then
           buzzer <= '0';
       else 
			  buzzer <= '1';
       end if;
   end process;
  
end Behavioral;

