library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity sideChannel8 is
  Port ( input1 : in STD_LOGIC;
         input2 : in STD_LOGIC;
         input3 : in STD_LOGIC;
         input4 : in STD_LOGIC;
         input5 : in STD_LOGIC;
         input6 : in STD_LOGIC;
         input7 : in STD_LOGIC;
         input8 : in STD_LOGIC;
         output1 : out STD_LOGIC;
         output2 : out STD_LOGIC;
         output3 : out STD_LOGIC;
         output4 : out STD_LOGIC;
         output5 : out STD_LOGIC;
         output6 : out STD_LOGIC;
         output7 : out STD_LOGIC;
         output8 : out STD_LOGIC;
         power_consumption : out STD_LOGIC_VECTOR(7 downto 0)); -- Added a power consumption signal
end sideChannel8;

architecture Behavioral of sideChannel8 is
begin
  -- Processing inputs using logic gates
  output1 <= (input1 AND input2) OR (input3 AND input4);
  output2 <= NOT (input5 AND input6) OR (input7 AND input8);
  output3 <= NOT (input1 AND input3) OR (input5 AND input7);
  output4 <= NOT (input2 AND input4) OR (input6 AND input8);
  output5 <= NOT (input1 AND input8) OR (input2 AND input7);
  output6 <= NOT (input3 AND input6) OR (input4 AND input5);

  -- Simulation of a side-channel attack (power consumption)
  process(input1, input2, input3, input4, input5, input6, input7, input8)
  begin
    if (input1 = '1' or input2 = '1') then
      power_consumption <= "11111111"; -- High power consumption
      output7 <= '0';
      output8 <= '0';
    else
      power_consumption <= "00000000"; -- Low power consumption
      output7 <= '0';
      output8 <= '0';
    end if;
  end process;
end Behavioral;
