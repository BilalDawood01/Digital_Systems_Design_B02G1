library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Wave_Incrementer is
   Port    ( reset      : in STD_LOGIC;
             clk        : in STD_LOGIC;
             delta_x : in STD_LOGIC_VECTOR (4 downto 0);
				 x_fin : out STD_LOGIC_VECTOR (11 downto 0)
			  );
end Wave_Incrementer;

architecture Behavioral of Wave_Incrementer is
   signal counter : unsigned (8 downto 0);
	signal rising : std_logic := '1'; 
	signal x_val : unsigned (11 downto 0) := "000000000000";
begin

-- Function of the triangulator is to vary the duty cycle
-- so that it becomes like a triangle

   count : process(clk,reset)
   begin
       if( reset = '1') then
				-- If reset, duty cycle = 0
           counter <= (others => '0');
			  x_val <= (others => '0');
			  x_fin <= (others => '0');
		 elsif (delta_x = "00000") then
				-- If distance = 0 i.e. error, duty cycle = 0
			  counter <= (others => '0');
			  x_val <= (others => '0');
			  x_fin <= (others => '0');
       elsif (rising_edge(clk)) then 
			  counter <= counter + 1;
			  
			  if (counter = 0) then
			  	  -- counter = 0 when one duty cycle has just ended
				  -- so this is the time to change the duty cycle amount if we want.
				  x_val <= x_val + NOT unsigned(delta_x);
				  x_fin <= std_logic_vector(x_val);
				end if;
				
		 end if;
   end process;

  
end Behavioral;

