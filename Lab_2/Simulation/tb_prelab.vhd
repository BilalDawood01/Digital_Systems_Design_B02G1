library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY tb_prelab IS
END tb_prelab;

ARCHITECTURE behavior OF tb_prelab IS

-- Component Declaration
	 
    COMPONENT Voltmeter
    PORT(
           clk                           : in  STD_LOGIC;
           reset                         : in  STD_LOGIC;
           LEDR                          : out STD_LOGIC_VECTOR (9 downto 0);
           HEX0,HEX1,HEX2,HEX3,HEX4,HEX5 : out STD_LOGIC_VECTOR (7 downto 0)
    );
    END COMPONENT;
    
    --Inputs
    signal clk : STD_LOGIC;
    
    --Outputs
    signal reset : STD_LOGIC;
	
    --Clock
    signal LEDR : STD_LOGIC_VECTOR (9 downto 0);
    --Reset
    signal reset : std_logic;
	
	-- Clock period definitions
	constant clk_period:time:=25ns;
    
    BEGIN
    -- Instantiate the Unit Under Test (UUT)
    uut: switch_logic PORT MAP (
        switches_inputs => switches_inputs,
        outputs => outputs,
        clk => clk,
        reset => reset
    );
    
	 
	 --Clock process definitions
	 clk_process : process
	 begin
		clk<= '0';
		wait for clk_period/2;
		clk<='1';
		wait for clk_period/2;
	end process;
	
    -- Modified Stimulus Process 
    modi_stim_proc: process 
    begin
		reset <= '0';
      -- test all the combinations
      switches_inputs <= "000";  --ABC
      wait for 100 ns;
		
		switches_inputs <= "001";  --ABC
      wait for 100 ns;
		
		switches_inputs <= "010";  --ABC
      wait for 100 ns;
		
		switches_inputs <= "011";  --ABC
      wait for 100 ns;
		
		switches_inputs <= "100";  --ABC
		reset <= '1';
      wait for 100 ns;
		
		switches_inputs <= "011";  --ABC Second 011
      wait for 100 ns;
		reset <= '0';
		
		switches_inputs <= "101";  --ABC
      wait for 100 ns;
		
		switches_inputs <= "110";  --ABC
      wait for 100 ns;
		
		switches_inputs <= "111";  --ABC
      wait for 100 ns;
		
    end process;


END;