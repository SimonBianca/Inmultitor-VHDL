----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.11.2020 15:12:10
-- Design Name: 
-- Module Name: prelucareRezultat - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity prelucrareRezultat is
    Port ( Clk : in STD_LOGIC;
           Rst : in STD_LOGIC;
           CE : in STD_LOGIC;
           numar : in STD_LOGIC_VECTOR (30 downto 0);
           semn : in STD_LOGIC;
           zero : in STD_LOGIC;
           zeroX : in STD_LOGIC;
           zeroY : in STD_LOGIC;
           dep_inf : in STD_LOGIC;
           dep_sup : in STD_LOGIC;
           infinit : in STD_LOGIC;
           NAN : in STD_LOGIC;
           rezultat : out STD_LOGIC_VECTOR (31 downto 0));
end prelucrareRezultat;

architecture Behavioral of prelucrareRezultat is

signal rezultat_aux:std_logic_vector(31 downto 0):=(others=>'0');
constant valoarea_NAN:std_logic_vector(31 downto 0):=(others=>'1');

begin

    process(Clk)
    begin
        if(rising_edge(Clk)) then
            if(Rst='1') then 
                rezultat_aux<=(others=>'0');
            end if;
            if(CE='1') then 
                if(NAN='1' and (zeroX and zeroY)='0') then
                    rezultat_aux<=valoarea_NAN;
                elsif(zero='1') then
                    rezultat_aux(30 downto 0)<=(others=>'0');
                    rezultat_aux(31)<=semn;
                elsif(dep_inf='1' or dep_sup='1' or infinit='1') then
                    rezultat_aux<=semn & "1111111100000000000000000000000";
                else
                     rezultat_aux<=semn & numar;
                end if;
            end if;
        end if;
    end process;
    
    rezultat<=rezultat_aux;

end Behavioral;
