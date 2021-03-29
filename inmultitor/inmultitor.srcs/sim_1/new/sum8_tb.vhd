----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.11.2020 17:07:19
-- Design Name: 
-- Module Name: sum8_tb - Behavioral
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
use IEEE.std_logic_unsigned.ALL;
use IEEE.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sum8_tb is
--  Port ( );
end sum8_tb;

architecture Behavioral of sum8_tb is
signal X,Y:std_logic_vector(9 downto 0):="0000000000";
signal S:std_logic_vector(9 downto 0);
signal Tin:std_logic:='0';
signal Tout:std_logic;

begin

sum8_tb: entity WORK.sum8 port map(
        X => X,
        Y => Y,
        Tin => Tin,
        S => S,
        Tout => Tout);
        
gen_vec_test: process
variable nr_erori:Integer:=0;
begin
        X<="00" & x"01";
        Y<= "00" & x"04";
        wait for 10 ns;
        if(S/=("00" & x"05") and Tout/='0') then
            nr_erori:=nr_erori+1;
        end if;
        
        X<="00" & x"0C";
        Y<="00" & x"0D";
        wait for 10 ns;
        if(S/=("00" & x"19") and Tout/='0') then
            nr_erori:=nr_erori+1;
        end if;
        
        X<="00" & x"07";
        Y<="00" & x"06";
        wait for 10 ns;
        if(S/=("00" & x"0D") and Tout/='0') then
            nr_erori:=nr_erori+1;
        end if;
        
        X<="00" & x"FE";
        Y<="00" & x"FD";
        wait for 10 ns;
        if(S/=("00" & x"FB") and Tout/='1') then
            nr_erori:=nr_erori+1;
        end if;
        
        X<="00" & x"F5";
        Y<="00" & x"EE";
        wait for 10 ns;
        if(S/=("00" & x"E3") and Tout/='1') then
            nr_erori:=nr_erori+1;
        end if;
        
        X<="00" & x"1D";
        Y<="00" & x"7F";
        wait for 10 ns;
        if(S/=("00" & x"9C") and Tout/='0') then
            nr_erori:=nr_erori+1;
        end if;
        
    report "Testare terminata cu " & INTEGER'image(nr_erori) & " erori";     
   
    end process gen_vec_test;

end Behavioral;

