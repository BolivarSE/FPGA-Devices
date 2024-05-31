library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity randomMask8 is
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
           power_consumption : out STD_LOGIC_VECTOR(7 downto 0); -- Added a power consumption signal
           random_mask : in STD_LOGIC_VECTOR(7 downto 0)); -- Added a random mask signal
end randomMask8;

architecture Behavioral of randomMask8 is
    signal result : STD_LOGIC_VECTOR(7 downto 0);
begin
    -- Simulation of a side-channel attack (power consumption)
    process(input1, input2, input3, input4, input5, input6, input7, input8)
    begin
        if (input1 = '1' or input2 = '1') then
            power_consumption <= "11111111";  -- High power consumption
        else
            power_consumption <= "00000000";  -- Low power consumption
        end if;
    end process;

    -- Processing inputs using logic gates
    result(0) <= (input1 AND input2) OR (input3 AND input4);
    result(1) <= NOT (input5 AND input6) OR (input7 AND input8);
    result(2) <= NOT (input1 AND input3) OR (input5 AND input7);
    result(3) <= NOT (input2 AND input4) OR (input6 AND input8);
    result(4) <= NOT (input1 AND input8) OR (input2 AND input7);
    result(5) <= NOT (input3 AND input6) OR (input4 AND input5);
    result(6) <= NOT input1 OR input2 OR input3;
    result(7) <= NOT input4 OR input5 OR input6 OR input7 OR input8;
    
    -- Applying the random masking
    output1 <= result(0) XOR random_mask(0);
    output2 <= result(1) XOR random_mask(1);
    output3 <= result(2) XOR random_mask(2);
    output4 <= result(3) XOR random_mask(3);
    output5 <= result(4) XOR random_mask(4);
    output6 <= result(5) XOR random_mask(5);
    output7 <= result(6) XOR random_mask(6);
    output8 <= result(7) XOR random_mask(7);
end Behavioral;
