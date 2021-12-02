library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
 
entity Voltmeter is
    Port ( clk                           : in  STD_LOGIC;
           reset                         : in  STD_LOGIC;
			  Switch								  : in  STD_LOGIC;
           LEDR                          : out STD_LOGIC_VECTOR (9 downto 0);
			  buzzer_out 						  : out  STD_LOGIC;		
           HEX0,HEX1,HEX2,HEX3,HEX4,HEX5 : out STD_LOGIC_VECTOR (7 downto 0)
          );
           
end Voltmeter;

architecture Behavioral of Voltmeter is

Signal A, Num_Hex0, Num_Hex1, Num_Hex2, Num_Hex3, Num_Hex4, Num_Hex5 :   STD_LOGIC_VECTOR (3 downto 0):= (others=>'0');   
Signal DP_in:   STD_LOGIC_VECTOR (5 downto 0);
Signal ADC_read,rsp_data,q_outputs_1,q_outputs_2 : STD_LOGIC_VECTOR (11 downto 0);
Signal voltage: STD_LOGIC_VECTOR (12 downto 0);
Signal busy: STD_LOGIC;
signal response_valid_out_i1,response_valid_out_i2,response_valid_out_i3 : STD_LOGIC_VECTOR(0 downto 0);
Signal bcd: STD_LOGIC_VECTOR(15 DOWNTO 0);
Signal Q_temp1 : std_logic_vector(11 downto 0);
Signal Mux_Output : std_logic_vector(12 downto 0);
Signal v2d_output : STD_LOGIC_VECTOR(12 DOWNTO 0); 
Signal wave_x : STD_LOGIC_VECTOR(11 DOWNTO 0);
Signal wave_sin_x : STD_LOGIC_VECTOR(8 DOWNTO 0);

Component SevenSegment is
    Port( bcd : in  STD_LOGIC_VECTOR (15 downto 0);
				Num_Hex0,Num_Hex1,Num_Hex2,Num_Hex3,Num_Hex4,Num_Hex5 : in  STD_LOGIC_VECTOR (3 downto 0);
          Hex0,Hex1,Hex2,Hex3,Hex4,Hex5                         : out STD_LOGIC_VECTOR (7 downto 0);
          DP_in                                                 : in  STD_LOGIC_VECTOR (5 downto 0);
			Mux_Switch   : in  std_logic		 
			 );
End Component ;

Component ADC_Conversion is
    Port( MAX10_CLK1_50      : in STD_LOGIC;
          response_valid_out : out STD_LOGIC;
          ADC_out            : out STD_LOGIC_VECTOR (11 downto 0)
         );
End Component ;

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

Component registers is
   generic(bits : integer);
   port
     ( 
      clk       : in  std_logic;
      reset     : in  std_logic;
      enable    : in  std_logic;
      d_inputs  : in  std_logic_vector(bits-1 downto 0);
      q_outputs : out std_logic_vector(bits-1 downto 0)  
     );
END Component;

Component averager is
  port(
    clk, reset : in std_logic;
    Din : in  std_logic_vector(11 downto 0);
    EN  : in  std_logic; -- response_valid_out
    Q   : out std_logic_vector(11 downto 0)
    );
  end Component;

Component Mux_for_Averager is
port(
	Mux_Switch  	 : in  std_logic;
	Voltage_v2d     : in  std_logic_vector(12 downto 0); 
	Distance_v2d    : in std_logic_vector(12 downto 0);
	Final_Out   	 : out std_logic_vector(12 downto 0);
	DP_in           : out  STD_LOGIC_VECTOR (5 downto 0)	);
end Component;

Component voltage2distance is
port(
	  clk            :  IN    STD_LOGIC;                                
     reset          :  IN    STD_LOGIC;                                
     voltage        :  IN    STD_LOGIC_VECTOR(12 DOWNTO 0);                           
     distance       :  OUT   STD_LOGIC_VECTOR(12 DOWNTO 0)
	);
end Component;


Component PWM_DAC is
Generic ( width : integer := 9);
port(
	  reset      : in STD_LOGIC;
     clk        : in STD_LOGIC;
     duty_cycle : in STD_LOGIC_VECTOR (width-1 downto 0);
     pwm_out    : out STD_LOGIC
	);
end Component;

Component Wave_Incrementer is
Port    ( 	reset      		: in STD_LOGIC;
             clk       		: in STD_LOGIC;
             delta_x 			: in STD_LOGIC_VECTOR (4 downto 0);
				 x_fin 	: out STD_LOGIC_VECTOR (11 downto 0)
			  );
end Component;

Component x2square is
PORT(
			clk            :  IN    STD_LOGIC;                                
			reset          :  IN    STD_LOGIC;                                
			x        		:  IN    STD_LOGIC_VECTOR(11 DOWNTO 0);                           
			sinx       		:  OUT   STD_LOGIC_VECTOR(8 DOWNTO 0)
			  );
end Component;

begin
   Num_Hex0 <= bcd(3  downto  0); 
   Num_Hex1 <= bcd(7  downto  4);
   Num_Hex2 <= bcd(11 downto  8);
   Num_Hex3 <= bcd(15 downto 12);
   Num_Hex4 <= "1111";  -- blank this display
   Num_Hex5 <= "1111";  -- blank this display 
--	if (Switch = '1') then
--		DP_in    <= "001000"; -- "ABCDEFGH"
--	else
--		DP_in    <= "000100";-- position of the decimal point in the display
--	end if;

                  
   
ave :    averager
         port map(
                  clk       => clk,
                  reset     => reset,
                  Din       => q_outputs_2,
                  EN        => response_valid_out_i3(0),
                  Q         => Q_temp1
                  );
   
sync1 : registers 
        generic map(bits => 12)
        port map(
                 clk       => clk,
                 reset     => reset,
                 enable    => '1',
                 d_inputs  => ADC_read,
                 q_outputs => q_outputs_1
                );

sync2 : registers 
        generic map(bits => 12)
        port map(
                 clk       => clk,
                 reset     => reset,
                 enable    => '1',
                 d_inputs  => q_outputs_1,
                 q_outputs => q_outputs_2
                );
                
sync3 : registers
        generic map(bits => 1)
        port map(
                 clk       => clk,
                 reset     => reset,
                 enable    => '1',
                 d_inputs  => response_valid_out_i1,
                 q_outputs => response_valid_out_i2
                );

sync4 : registers
        generic map(bits => 1)
        port map(
                 clk       => clk,
                 reset     => reset,
                 enable    => '1',
                 d_inputs  => response_valid_out_i2,
                 q_outputs => response_valid_out_i3
                );                
                
SevenSegment_ins: SevenSegment
                  PORT MAP( bcd => bcd,
									Num_Hex0 => Num_Hex0,
                            Num_Hex1 => Num_Hex1,
                            Num_Hex2 => Num_Hex2,
                            Num_Hex3 => Num_Hex3,
                            Num_Hex4 => Num_Hex4,
                            Num_Hex5 => Num_Hex5,
                            Hex0     => HEX0,
                            Hex1     => HEX1,
                            Hex2     => HEX2,
                            Hex3     => HEX3,
                            Hex4     => HEX4,
                            Hex5     => HEX5,
                            DP_in    => DP_in,
									 Mux_Switch 		=> Switch
									 );
                                     
ADC_Conversion_ins:  ADC_Conversion
	PORT MAP(      
                                     MAX10_CLK1_50       => clk,
                                     response_valid_out  => response_valid_out_i1(0),
                                     ADC_out             => ADC_read);

												 
mux_ins: Mux_for_Averager                             
   PORT MAP(
      Mux_Switch 		=> Switch,
		Voltage_v2d    => voltage,
		Distance_v2d   => v2d_output,  
		Final_Out  		=> Mux_Output,
		DP_in => DP_in      );
		

														 
LEDR(9 downto 0) <= Mux_Output(12 downto 3); -- gives visual display of upper binary bits to the LEDs on board
-- LEDR(9 downto 0) <= bcd(9 downto 0); -- gives visual display of upper binary bits to the LEDs on board

-- in line below, can change the scaling factor (i.e. 2500), to calibrate the voltage reading to a reference voltmeter
voltage <= std_logic_vector(resize(unsigned(Q_temp1)*2500*2/4096,voltage'length));  -- Converting ADC_read a 12 bit binary to voltage readable numbers

v2d: voltage2distance
	PORT MAP(
      clk            => clk,                                
		reset          => reset,                                
		voltage        => voltage,        -- originally put q_temp1; changed to voltage (but we want decimal not 12 bit binary?)                   
		distance       => v2d_output		 -- created new signal
      );

binary_bcd_ins: binary_bcd                               
   PORT MAP(
      clk      => clk,                          
      reset    => reset,                                 
      ena      => '1',                           
      binary   => Mux_output,    
      busy     => busy,                         
      bcd      => bcd
      );
		
Wave_Incrementer_ins: Wave_Incrementer                            
   PORT MAP(
      reset 			=> reset,
		clk    			=> clk,
		delta_x   		=> v2d_output(11 downto 7),
		x_fin  			=> wave_x
);
		
x2square_ins: x2square                             
   PORT MAP(
      clk 				=> clk,
		reset   			=> reset,
		x   				=> wave_x,  
		sinx  			=> wave_sin_x
);
		
PWM_DAC_ins: PWM_DAC                              
   PORT MAP(
      reset    		=> reset, 
		clk      		=> clk,                                                         
      duty_cycle     => wave_sin_x,                        
      pwm_out   		=> buzzer_out
      );
		
		
end Behavioral;