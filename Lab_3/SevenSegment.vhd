-- --- Seven segment component
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.typesforsevensegment.all;

entity SevenSegment is
    Port ( Num_Hex0,Num_Hex1,Num_Hex2,Num_Hex3,Num_Hex4,Num_Hex5 : in  STD_LOGIC_VECTOR (3 downto 0);
           Hex0,Hex1,Hex2,Hex3,Hex4,Hex5                         : out STD_LOGIC_VECTOR (7 downto 0);
           DP_in                                                 : in  STD_LOGIC_VECTOR (5 downto 0)
          );
end SevenSegment;


architecture Behavioral of SevenSegment is

--Note that component declaration comes after architecture and before begin (common source of error).
--Component SevenSegment_decoder is 
--	port(  H     : out STD_LOGIC_VECTOR (7 downto 0);
--			 input : in  STD_LOGIC_VECTOR (3 downto 0);
--			 DP    : in  STD_LOGIC                               
--		 );                  
--end  Component;   
--
--signal Num_Hex : Our_Num_Hex;
--signal Hex : Our_HEX;

begin

--Num_Hex <= (Num_Hex0,Num_Hex1,Num_Hex2,Num_Hex3,Num_Hex4,Num_Hex5); 
--
--decoder_Instantiator: for I in 0 to 5 generate
--	decoder: SevenSegment_decoder port map (H     => Hex(I),
--														 input => Num_Hex(I),
--														 DP    => DP_in(I)
--														 );
--end generate decoder_Instantiator;
--
--Hex0 <= Hex(0); 
--Hex1 <= Hex(1); 
--Hex2 <= Hex(2); 
--Hex3 <= Hex(3); 
--Hex4 <= Hex(4); 
--Hex5 <= Hex(5); 

--Note that port mapping begins after begin (common source of error).


decoder0: SevenSegment_decoder  port map 
                                   (H     => Hex0,
                                    input => Num_Hex0,
                                    DP    => DP_in(0)
                                    );
decoder1: SevenSegment_decoder  port map 
                                   (H     => Hex1,
                                    input => Num_Hex1,
                                    DP    => DP_in(1)
                                    );
decoder2: SevenSegment_decoder  port map 
                                   (H     => Hex2,
                                    input => Num_Hex2,
                                    DP    => DP_in(2)
                                    );
decoder3: SevenSegment_decoder port map 
                                   (H     => Hex3,
                                    input => Num_Hex3,
                                    DP    => DP_in(3)
                                    );
decoder4: SevenSegment_decoder  port map 
                                   (H     => Hex4,
                                    input => Num_Hex4,
                                    DP    => DP_in(4)
                                    );
decoder5: SevenSegment_decoder  port map 
                                   (H     => Hex5,
                                    input => Num_Hex5,
                                    DP    => DP_in(5)
                                    );                            
end Behavioral;