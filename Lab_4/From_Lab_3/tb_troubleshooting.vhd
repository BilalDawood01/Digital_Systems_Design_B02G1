-- --- from lab instructions pages 9 to 11
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY tb_troubleshooting IS
END tb_troubleshooting;

ARCHITECTURE behavior OF tb_troubleshooting IS

-- Component Declaration for the UUT
	 Component SevenSegment is
    Port( Num_Hex0,Num_Hex1,Num_Hex2,Num_Hex3,Num_Hex4,Num_Hex5 : in  STD_LOGIC_VECTOR (3 downto 0);
          Hex0,Hex1,Hex2,Hex3,Hex4,Hex5                         : out STD_LOGIC_VECTOR (7 downto 0);
          DP_in                                                 : in  STD_LOGIC_VECTOR (5 downto 0)
			);
	End Component ;
    
	 
	 signal Num_Hex0,Num_Hex1,Num_Hex2,Num_Hex3,Num_Hex4,Num_Hex5 : STD_LOGIC_VECTOR (3 downto 0);
	 signal Hex0,Hex1,Hex2,Hex3,Hex4,Hex5                         : STD_LOGIC_VECTOR (7 downto 0);
	 signal DP_in                                                 : STD_LOGIC_VECTOR (5 downto 0);
    
	
	 
    BEGIN
    -- Instantiate the Unit Under Test (UUT)
	 SevenSegment_ins: SevenSegment
			PORT MAP( Num_Hex0 => Num_Hex0,
						 Num_Hex1 => Num_Hex1,
						 Num_Hex2 => Num_Hex2,
						 Num_Hex3 => Num_Hex3,
						 Num_Hex4 => Num_Hex4,
						 Num_Hex5 => Num_Hex5,
						 Hex0     => Hex0,
						 Hex1     => Hex1,
						 Hex2     => Hex2,
						 Hex3     => Hex3,
						 Hex4     => Hex4,
						 Hex5     => Hex5,
						 DP_in    => DP_in
					  );

	 
    -- Stimulus Process 
    stim_proc: process 
    begin


	 Num_Hex4 <= "1111";  -- blank this display
   Num_Hex5 <= "1111";  -- blank this display   
   DP_in    <= "010000";-- position of the decimal point in the display

		Num_Hex0 <= "0100"; 
		Num_Hex1 <= "0011"; -- "0000000"
		Num_Hex2 <= "0010";
		Num_Hex3 <= "0001";
      wait for 10000 ns;
		
      Num_Hex0 <= "0100"; 
		Num_Hex1 <= "0111";
		Num_Hex2 <= "0010";
		Num_Hex3 <= "0011";
      wait for 10000 ns;

		
		
    end process;


END;