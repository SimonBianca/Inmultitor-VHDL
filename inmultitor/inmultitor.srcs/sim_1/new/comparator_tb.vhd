----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.11.2020 16:59:49
-- Design Name: 
-- Module Name: comparator_tb - Behavioral
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

entity comparator_tb is
--  Port ( );
end comparator_tb;

architecture Behavioral of comparator_tb is

signal X,Y:std_logic_vector(7 downto 0);
signal Equal,Less,More:std_logic;

begin
    comp: entity WORK.comparator
        generic map(n=>8)
        port map(X=>X, Y=>Y, Less=>Less, Equal=>Equal, More=>More);
        
    process          
    begin 
    
        X<=x"00"; 
        Y<=x"00"; 
        
        wait for 300 ns;
        
        X<=x"01"; 
        Y<=x"11"; 
 
        wait for 300 ns;
        
        X<=x"A1"; 
        Y<=x"07"; 
    
        wait;  
    end process;  
        
        

end Behavioral;
