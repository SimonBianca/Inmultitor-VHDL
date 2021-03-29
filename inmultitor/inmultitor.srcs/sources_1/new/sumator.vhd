----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.11.2020 17:05:13
-- Design Name: 
-- Module Name: sumator - Behavioral
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

entity sumator is
    Port ( X : in STD_LOGIC_VECTOR (9 downto 0);
           Y : in STD_LOGIC_VECTOR (9 downto 0);
           Tin : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (9 downto 0);
           Tout : out STD_LOGIC);
end sumator;

architecture Behavioral of sumator is

signal S_aux:std_logic_vector(9 downto 0);
signal Tout_aux:std_logic;

begin

    sum: entity WORK.sum8
            port map(X=>X, Y=>Y, Tin=>Tin, S=>S_aux, Tout=>Tout_aux);
    
    sub: entity WORK.sum8
            port map(S_aux, Y=>"1110000001", Tin=>'0', S=>S, Tout=>Tout);

end Behavioral;
