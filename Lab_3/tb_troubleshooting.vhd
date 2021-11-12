-- --- from lab instructions pages 9 to 11
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY tb_troubleshooting IS
END tb_troubleshooting;

ARCHITECTURE behavior OF tb_troubleshooting IS

-- Component Declaration for the UUT
	 Component binary_bcd IS
	PORT(
      clk     : IN  STD_LOGIC;                      --system clock
      reset   : IN  STD_LOGIC;                      --active low asynchronus reset
      ena     : IN  STD_LOGIC;                      --latches in new binary number and starts conversion
      binary  : IN  STD_LOGIC_VECTOR(12 DOWNTO 0);  --binary number to convert
      busy    : OUT STD_LOGIC;                      --indicates conversion in progress
      bcd     : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)   --resulting BCD number
		);           
	END Component;
	 
    
	 signal clk : std_logic;
	 signal reset : std_logic;
	 signal Mux_output : std_logic_vector(12 downto 0); 
	 signal busy : std_logic;
	 signal bcd : STD_LOGIC_VECTOR(15 DOWNTO 0); 
    
	 -- Clock period definitions
		constant clk_period:time:=2ns;
	 
    BEGIN
    -- Instantiate the Unit Under Test (UUT)
	 binary_bcd_ins: binary_bcd                               
    PORT MAP(
      clk      => clk,                          
      reset    => reset,                                 
      ena      => '1',                           
      binary   => Mux_output,    
      busy     => busy,                         
      bcd      => bcd         
      );

		
	
		clk_process : process
	 begin
		clk<= '0';
		wait for clk_period/2;
		clk<='1';
		wait for clk_period/2;
	 end process;
	 
    -- Stimulus Process 
    stim_proc: process 
    begin
		reset <= '0';

		Mux_output <= "0101010101011";  --2731
      wait for 10000 ns;
		
      Mux_output <= "0101111111011";  --3067
      wait for 10000 ns;
		
      Mux_output <= "1000100011111";  --4383
      wait for 10000 ns;

		
		
    end process;


END;