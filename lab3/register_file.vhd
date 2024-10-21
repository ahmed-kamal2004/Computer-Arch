LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ram IS
    PORT (
        clk : IN STD_LOGIC;
        write_enable, reset_signal : IN STD_LOGIC;
        read_address_first, read_address_second, write_address : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        datain : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        dataout_first, dataout_second : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END ENTITY ram;
ARCHITECTURE ram_arch OF ram IS
    TYPE ram_type IS ARRAY(0 TO 7) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL ram : ram_type;
BEGIN
    PROCESS (clk, reset_signal) IS
    BEGIN
        IF reset_signal = '1' THEN

            ram(to_integer(unsigned(write_address))) <= (OTHERS => '0');

        ELSIF rising_edge(clk) THEN
            IF write_enable = '1' THEN

                ram(to_integer(unsigned((write_address)))) <= datain;

            END IF;
        END IF;
    END PROCESS;

    dataout_first <= ram(to_integer(unsigned((read_address_first))));
    dataout_second <= ram(to_integer(unsigned((read_address_second))));
END ram_arch;