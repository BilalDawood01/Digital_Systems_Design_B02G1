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
    
	
    --Clock
    signal LEDR : STD_LOGIC_VECTOR (9 downto 0);
    --Reset
    signal reset : std_logic;
	 
	 --HEXes
	 signal HEX0,HEX1,HEX2,HEX3,HEX4,HEX5 : STD_LOGIC_VECTOR (7 downto 0);
	
	-- Clock period definitions
	constant clk_period:time:=25ns;
    
    BEGIN
    -- Instantiate the Unit Under Test (UUT)
    uut: Voltmeter PORT MAP (
        clk => clk,
        reset => reset,
		  LEDR => LEDR,
		  HEX0 => HEX0,
		  HEX1 => HEX1,
		  HEX2 => HEX2,
		  HEX3 => HEX3,
		  HEX4 => HEX4,
		  HEX5 => HEX5
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
	 
		reset<= '1';
		wait for 91ns;
		reset<= '0';
		wait for 900000ns;
    end process;


END;