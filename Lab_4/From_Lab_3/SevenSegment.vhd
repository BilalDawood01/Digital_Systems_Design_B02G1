-- --- Seven segment component
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.typesforsevensegment.all;

entity SevenSegment is

    Port ( bcd : in  STD_LOGIC_VECTOR (15 downto 0);
	 Num_Hex0,Num_Hex1,Num_Hex2,Num_Hex3,Num_Hex4,Num_Hex5 : in  STD_LOGIC_VECTOR (3 downto 0);
           Hex0,Hex1,Hex2,Hex3,Hex4,Hex5                         : out STD_LOGIC_VECTOR (7 downto 0);
           DP_in                                                 : in  STD_LOGIC_VECTOR (5 downto 0);
			  Mux_Switch   : in  std_logic
			  );
end SevenSegment;


architecture Behavioral of SevenSegment is

--Note that component declaration comes after architecture and before begin (common source of error).
Component SevenSegment_decoder is 
	port(  H     : out STD_LOGIC_VECTOR (7 downto 0);
			 input : in  STD_LOGIC_VECTOR (3 downto 0);
			 DP    : in  STD_LOGIC                               
		 );                  
end  Component;   
--
signal Num_Hex : Our_Num_Hex;
signal Hex : Our_HEX;

begin


Num_Hex <= (Num_Hex5,Num_Hex4,Num_Hex3,Num_Hex2,Num_Hex1,Num_Hex0); 


decoder_Instantiator: for I in 0 to 5 generate
	decoder: SevenSegment_decoder port map (H     => Hex(I),
														 input => Num_Hex(I),
														 DP    => DP_in(I)
														 );
end generate decoder_Instantiator;

 

process (Hex(3))
	begin
		
	
end process;



process (Hex)
	begin
	
	Hex4 <= Hex(4); 
	Hex5 <= Hex(5);
	if (Mux_Switch = '0') then
		if (bcd < "0000001110011001" or bcd > "0010011100010000") then --0299
			-- (0-398 or )
			Hex0 <= "10101111"; -- 10001000
			Hex1 <= "10101111"; -- 10
			Hex2 <= "10000110"; -- 10000110
			Hex3 <= "11111111"; -- ABCDEFGH
									 --- 11110101
									 --- 10101111
		else
			Hex0 <= Hex(0); 
			Hex1 <= Hex(1); 
			Hex2 <= Hex(2);
			if (Num_Hex3 = "0000" and DP_in /= "001000") then
				Hex3 <= "11111111";
			else
				Hex3 <= Hex(3); 
			end if;
		end if;
	else
		if (bcd = "0000000000000000") then
			-- (0-398 or )
			Hex0 <= "10101111"; -- 10001000
			Hex1 <= "10101111"; -- 10
			Hex2 <= "10000110"; -- 10000110
			Hex3 <= "11111111";
		else
			Hex0 <= Hex(0); 
			Hex1 <= Hex(1); 
			Hex2 <= Hex(2);
			if (Num_Hex3 = "0000" and DP_in /= "001000") then
				Hex3 <= "11111111";
			else
				Hex3 <= Hex(3); 
			end if;
		end if;
	end if;
	
end process;

--Note that port mapping begins after begin (common source of error).


--decoder0: SevenSegment_decoder  port map 
--                                   (H     => Hex0,
--                                    input => Num_Hex0,
--                                    DP    => DP_in(0)
--                                    );
--decoder1: SevenSegment_decoder  port map 
--                                   (H     => Hex1,
--                                    input => Num_Hex1,
--                                    DP    => DP_in(1)
--                                    );
--decoder2: SevenSegment_decoder  port map 
--                                   (H     => Hex2,
--                                    input => Num_Hex2,
--                                    DP    => DP_in(2)
--                                    );
--decoder3: SevenSegment_decoder port map 
--                                   (H     => Hex3,
--                                    input => Num_Hex3,
--                                    DP    => DP_in(3)
--                                    );
--decoder4: SevenSegment_decoder  port map 
--                                   (H     => Hex4,
--                                    input => Num_Hex4,
--                                    DP    => DP_in(4)
--                                    );
--decoder5: SevenSegment_decoder  port map 
--                                   (H     => Hex5,
--                                    input => Num_Hex5,
--                                    DP    => DP_in(5)
--                                    );                            
end Behavioral;