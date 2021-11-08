library ieee;
use ieee.std_logic_1164.all;

package typesforsevensegment is

type Our_HEX is array (5 downto 0) of STD_LOGIC_VECTOR (7 downto 0);
type Our_Num_Hex is array (5 downto 0) of STD_LOGIC_VECTOR (3 downto 0);

end package typesforsevensegment;