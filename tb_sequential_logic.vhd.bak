-- --- from lab instructions pages 9 to 11
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY tb_switch_logic IS
END tb_switch_logic;

ARCHITECTURE behavior OF tb_switch_logic IS

-- Component Declaration for the UUT

    COMPONENT switch_logic
    PORT(
        switches_inputs : IN std_logic_vector(2 downto 0);
        outputs : OUT std_logic_vector(2 downto 0) -- ;
        -- clk : IN std_logic;
        -- reset : in std_logic
    );
    END COMPONENT;
    
    --Inputs
    signal switches_inputs : std_logic_vector(2 downto 0) := (others => '0');
    
    --Outputs
    signal outputs : std_logic_vector(2 downto 0);
    
    BEGIN
    -- Instantiate the Unit Under Test (UUT)
    uut: switch_logic PORT MAP (
        switches_inputs => switches_inputs,
        outputs => outputs --,
        -- clk => clk,
        -- reset => reset
    );
    
	
    -- Modified Stimulus Process 
    modi_stim_proc: process 
    begin

      -- test all the combinations
      switches_inputs <= "000";  --ABC
      wait for 1 ns;
		
		switches_inputs <= "001";  --ABC
      wait for 1 ns;
		
		switches_inputs <= "010";  --ABC
      wait for 1 ns;
		
		switches_inputs <= "011";  --ABC
      wait for 1 ns;
		
		switches_inputs <= "100";  --ABC
      wait for 1 ns;
		
		switches_inputs <= "101";  --ABC
      wait for 1 ns;
		
		switches_inputs <= "110";  --ABC
      wait for 1 ns;
		
		switches_inputs <= "111";  --ABC
      wait for 1 ns;
		
    end process;


END;