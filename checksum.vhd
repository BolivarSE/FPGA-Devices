library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity checksumMitigation is
    Port ( input1 : in STD_LOGIC;
           input2 : in STD_LOGIC;
           input3 : in STD_LOGIC;
           input4 : in STD_LOGIC;
           input5 : in STD_LOGIC;
           input6 : in STD_LOGIC;
           input7 : in STD_LOGIC;
           input8 : in STD_LOGIC;
           checksum_in : in STD_LOGIC;
           faultCondition : in STD_LOGIC;
           output1 : out STD_LOGIC;
           output2 : out STD_LOGIC;
           output3 : out STD_LOGIC;
           output4 : out STD_LOGIC;
           output5 : out STD_LOGIC;
           output6 : out STD_LOGIC;
           output7 : out STD_LOGIC;
           output8 : out STD_LOGIC;
           checksum_out : out STD_LOGIC);
end checksumMitigation;

architecture Behavioral of checksumMitigation is
    signal injected_input : STD_LOGIC := '0'; -- Fault injection in input 1
    signal calc_checksum : STD_LOGIC;
    signal stored_checksum : STD_LOGIC := '0'; -- Stored checksum value
begin
    -- Fault injection in input 1 (input1)
    process(faultCondition)
    begin
        if faultCondition = '0' then
            injected_input <= not input1; -- Change the value of input 1
        else
            injected_input <= input1; -- Keep the original value of input 1
        end if;
    end process;

    -- Calculate the checksum
    calc_checksum <= (injected_input XOR input2) XOR input3;
    stored_checksum <= checksum_in when rising_edge(calc_checksum);

    -- Processing inputs using logic gates
    output1 <= (injected_input AND input2) OR (input3 AND input4);
    output2 <= NOT (input5 AND input6) OR (input7 AND input8);
    output3 <= NOT (injected_input AND input3) OR (input5 AND input7);
    output4 <= NOT (input2 AND input4) OR (input6 AND input8);
    output5 <= NOT (injected_input AND input8) OR (input2 AND input7);
    output6 <= NOT (input3 AND input6) OR (input4 AND input5);
    output7 <= NOT injected_input OR input2 OR input3;
    output8 <= NOT input4 OR input5 OR input6 OR input7 OR input8;

    -- Compare the calculated checksum with the stored one
    checksum_out <= '1' when calc_checksum = stored_checksum else '0';
end Behavioral;
