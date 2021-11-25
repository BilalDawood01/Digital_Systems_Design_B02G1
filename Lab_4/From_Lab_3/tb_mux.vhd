-- --- from lab instructions pages 9 to 11
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY tb_mux IS
END tb_mux;

ARCHITECTURE behavior OF tb_mux IS

-- Component Declaration for the UUT
	 
    COMPONENT Mux_for_Averager
    PORT(
			Mux_Switch   : in  std_logic;
			Pre_Ave   	: in  std_logic_vector(11 downto 0); 
			Post_Ave     : in std_logic_vector(11 downto 0);
			Final_Out   : out std_logic_vector(11 downto 0)
    );
    END COMPONENT;
    
	 signal switch : std_logic;
	 signal pre : std_logic_vector(11 downto 0); 
	 signal post : std_logic_vector(11 downto 0); 
	 signal final : std_logic_vector(11 downto 0); 
    
    BEGIN
    -- Instantiate the Unit Under Test (UUT)
    mux_ins: Mux_for_Averager PORT MAP (
        Mux_Switch => switch,
        Pre_Ave => pre,
        Post_Ave => post,
        Final_Out => final
    );
	
    -- Modified Stimulus Process 
    modi_stim_proc: process 
    begin
	 
      -- test all the combinations
      pre <= "000000000001";  --pre
      post <= "111111111110";  --post
		switch <= '1';
      wait for 100 ns;
		
      -- test all the combinations
      pre <= "000000000001";  --pre
      post <= "111111111110";  --post
		switch <= '0';
      wait for 100 ns;
		
      -- test all the combinations
      pre <= "000011100001";  --pre
      post <= "111000001110";  --post
		switch <= '1';
      wait for 100 ns;
		
      -- test all the combinations
      pre <= "000011100001";  --pre
      post <= "111000001110";  --post
		switch <= '0';
      wait for 100 ns;
		
		
    end process;


END;