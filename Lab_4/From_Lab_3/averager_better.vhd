-- averages 16 samples
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity averager is
	port (
		  clk   : in  std_logic;
		  EN    : in  std_logic;
		  reset : in  std_logic;
		  Din   : in  std_logic_vector(11 downto 0);
		  Q     : out std_logic_vector(11 downto 0));
		  Times_to_Average : in  std_logic(7 downto 0)
	end averager;

architecture rtl of averager is

signal reg1,reg2 : std_logic_vector(11 downto 0);
signal tmp1 : integer;
signal tmp2 : std_logic_vector(12 downto 0);
signal Times_Averaged : integer;

begin


shift_reg : process(clk, reset)
	begin
		if(reset = '1') then
			reg1  <= (others => '0');
			reg2  <= (others => '0');
			Q     <= (others => '0');
		elsif rising_edge(clk) then
			if EN = '1' then
				Times_Averaged <= Times_Averaged + 1;
				reg1  <= Din;
				reg2  <= reg1;	
				if Times_Averaged == Times_to_Average then
					Q     <= tmp2(12 downto 1); -- reg1; -- for testing
					Times_Averaged <= 0;
				end if;
			end if;
		end if;
	end process shift_reg;

tmp1 <= to_integer(unsigned(reg1))  + to_integer(unsigned(reg2));

		  
tmp2 <= std_logic_vector(to_unsigned(tmp1, tmp2'length)); 	
	
end rtl;
