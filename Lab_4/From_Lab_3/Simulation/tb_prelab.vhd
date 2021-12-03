library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY tb_prelab IS
END tb_prelab;

ARCHITECTURE behavior OF tb_prelab IS

-- Component Declaration
	 
    COMPONENT Voltmeter
    PORT(
           clk                           	: in  STD_LOGIC;
           reset                         	: in  STD_LOGIC;
           Switch									: in  STD_LOGIC;
			  test_input						   : in  STD_LOGIC_VECTOR(11 downto 0);
			  -- This input is to simulate different distance values to verify the 
			  -- correct PWM output.
			  LEDR                          	: out STD_LOGIC_VECTOR (9 downto 0);
			  buzzer_out 						  	: out  STD_LOGIC;		
           HEX0,HEX1,HEX2,HEX3,HEX4,HEX5 	: out STD_LOGIC_VECTOR (7 downto 0)
    );
    END COMPONENT;
    
    --Inputs
    signal clk : STD_LOGIC;
	 
	 signal switch: STD_LOGIC;
    
	
    --Clock
    signal LEDR : STD_LOGIC_VECTOR (9 downto 0);
    --Reset
    signal reset : std_logic;
	 
	 Signal test_input: STD_LOGIC_VECTOR(11 downto 0);
	 
	 signal buzzer_out : STD_LOGIC;	
	 
	 --HEXes
	 signal HEX0,HEX1,HEX2,HEX3,HEX4,HEX5 : STD_LOGIC_VECTOR (7 downto 0);
	
	-- Clock period definitions
	constant clk_period:time:=25ns;
    
    BEGIN
    -- Instantiate the Unit Under Test (UUT)
    uut: Voltmeter PORT MAP (
        clk => clk,
        reset => reset,
		  test_input => test_input,
		  Switch => switch,
		  LEDR => LEDR,
		  HEX0 => HEX0,
		  HEX1 => HEX1,
		  HEX2 => HEX2,
		  HEX3 => HEX3,
		  HEX4 => HEX4,
		  HEX5 => HEX5,
		  buzzer_out => buzzer_out
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
		switch<='1';
		wait for 2.5ms;
		
		reset<= '0';
		switch<='1';
		wait for 2.5ms;
		
		reset<= '0';
		switch<='1';
		wait for 2.5ms;
		
		reset<= '0';
		switch<='1';
		wait for 2.5ms;
		
		reset<= '1';
		switch<='0';
		wait for 2.5ms;
		
		reset<= '0';
		switch<='1';
		wait for 2.5ms;
		
		reset<= '0';
		switch<='0';
		wait for 2.5ms;
		
		reset<= '0';
		switch<='1';
		wait for 2.5ms;
		
    end process;
	 
	 -- Test Stimulus Process 
    test_stim_proc: process 
    begin
		test_input<= "000000000000";
		wait for 10ms;
		
		test_input<= "111111111111";
		wait for 10ms;
		
		test_input<= "000111100000";
		wait for 10ms;
		
		test_input<= "111100000000";
		wait for 10ms;
		
		test_input<= "000000011111";
		wait for 10ms;
		
		test_input<= "111000001111";
		wait for 10ms;
		
		test_input<= "101010101010";
		wait for 10ms;
		
		test_input<= "110001100011";
		wait for 10ms;
    end process;

END;