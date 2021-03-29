----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.11.2020 21:26:08
-- Design Name: 
-- Module Name: normalizare_tb - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity normalizare_tb is
--  Port ( );
end normalizare_tb;

architecture Behavioral of normalizare_tb is

signal Clk,Rst,CE:std_logic:='0';
signal Exp,ExpOut:std_logic_vector(7 downto 0):=(others => '0');
signal Mantisa:std_logic_vector(47 downto 0):=(others => '0');
signal MantisaOut:std_logic_vector(22 downto 0):=(others => '0');
signal OVF:std_logic:='0';

begin
    
    norm: entity WORK.normalizare_rotunjire
        port map(Clk=>Clk, Rst=>Rst, CE=>CE, Exp=>Exp, Mantisa=>Mantisa, 
            ExpOut=>ExpOut, MantisaOut=>MantisaOut, OVF=>OVF);
    
     gen_clk: process
        begin
            Clk <= '0';
            wait for 5 ns;
            Clk <= '1';
            wait for 5 ns;
    end process gen_clk; 
    
    process          
    begin 
        
        wait for 10 ns;
        Rst<='1';
        wait for 10 ns;
        Rst<='0';
        wait for 10 ns;
        
        CE<='1';
        wait for 10 ns;
        
        Exp<="00000001";
        Mantisa<="11000001" & x"0000001111";
        wait for 100 ns;
        
        wait;
         
    end process;  

end Behavioral;
