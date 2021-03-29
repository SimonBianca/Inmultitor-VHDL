----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.12.2020 17:39:09
-- Design Name: 
-- Module Name: TB_inmultire - Behavioral
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
use IEEE.STD_LOGIC_SIGNED.ALL;
USE IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TB_inmultire is
--  Port ( );
end TB_inmultire;

architecture Behavioral of TB_inmultire is

signal Clk,Rst,Start:std_logic:='0';
signal X, Y:std_logic_vector(31 downto 0):=(others => '0');
signal P:std_logic_vector(31 downto 0);
signal Term:std_logic;
signal result:std_logic_vector(31 downto 0):=(others => '0');

begin

    inmuultire: entity WORK.inmultitor_VM 
        port map(Clk=>Clk, Rst=>Rst, Start=>Start, X=>X, Y=>Y, P=>P, Term=>Term);
    
    gen_clk: process
    begin
            Clk<='0';
            wait for 5 ns;
            Clk<='1';
            wait for 5 ns;
    end process;
    
    process 
    begin 
    Rst<='1';
    wait for 5 ns;
    Rst<='0';
    Start<='1';
    wait for 5 ns;
    Start<='0';
    x<="10000000000000000000000000000000"; -- X = -0
    Y<="00000000000000000000000000000000"; -- Y = 0
    result<="10000000000000000000000000000000"; --P = -0
    wait for 100 ns;
    
    Rst<='1';
    wait for 5 ns;
    Rst<='0';
    Start<='1';
    wait for 5 ns;
    Start<='0';
    x<="01000000010000000000000000000000"; -- X = +3
    Y<="01000000101000000000000000000000"; -- -Y = +5
    result<="01000001011100000000000000000000"; -- P = +15
    wait for 100 ns;
    
    Rst<='1';
    wait for 5 ns;
    Rst<='0';
    Start<='1';
    wait for 5 ns;
    Start<='0';
    x<="01111111100000000000000000000000"; -- X = infinit
    Y<="10111110100110011001100110011010"; -- Y = -0.3
    result<="11111111100000000000000000000000"; --P = -infinit
    wait for 100 ns;
    
    Rst<='1';
    wait for 5 ns;
    Rst<='0';
    Start<='1';
    wait for 5 ns;
    Start<='0';
    x<="00000000000000000000000000000000"; -- X = 0
    Y<="10111110100110011001100110011010"; -- Y = -0.3
    result<="10000000000000000000000000000000"; --P = -0
    wait for 100 ns;
    
    Rst<='1';
    wait for 5 ns;
    Rst<='0';
    Start<='1';
    wait for 5 ns;
    Start<='0';
    x<="01000011111110100010000000000000"; -- X = 500.25
    Y<="10111110100110011001100110011010"; -- Y = -0.3
    result<="11000011000101100001001100110011"; --P = -150.075
    wait for 100 ns;
    
    Rst<='1';
    wait for 5 ns;
    Rst<='0';
    Start<='1';
    wait for 5 ns;
    Start<='0';
    x<="11000000111000000000000000000000"; -- X = -7
    Y<="11000000100010000000000000000000"; -- Y = -4.25
    result<="01000001111011100000000000000000"; --P = +29.75
    wait for 100 ns;
    
    Rst<='1';
    wait for 5 ns;
    Rst<='0';
    Start<='1';
    wait for 5 ns;
    Start<='0';
    x<="01111111100000000000000000000000"; -- X = +infinit
    Y<="11111111100000000000000000000000"; -- Y = -infinit
    result<="11111111100000000000000000000000"; -- P = -infinit
    wait for 100 ns;
    
    Rst<='1';
    wait for 5 ns;
    Rst<='0';
    Start<='1';
    wait for 5 ns;
    Start<='0';
    x<="01111111100000000000000000000000"; -- X = infinit
    Y<="00000000000000000000000000000000"; -- Y = 0
    result<=(others=>'1'); --P = NAN
    wait for 100 ns;
    
    -- pentru demo
    Rst<='1';
    wait for 5 ns;
    Rst<='0';
    Start<='1';
    wait for 5 ns;
    Start<='0';
    x<="01000001000010000000000000000000"; -- X = 8.5
    Y<="01000001111010110011001100110011"; -- Y = 29.4
    result<="01000011011110011110011001100110"; --P = 249.9
    wait for 100 ns;

    wait;
    end process;

end Behavioral;
