----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.10.2020 20:23:55
-- Design Name: 
-- Module Name: sum_el - Behavioral
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

entity sum_el is
    Port ( X : in STD_LOGIC;
           Y : in STD_LOGIC;
           Tin : in STD_LOGIC;
           S : out STD_LOGIC;
           Tout : out STD_LOGIC);
end sum_el;

architecture Behavioral of sum_el is

begin
    
    S<=X xor Y xor Tin;
    Tout<=(X and Y) or (X and Tin) or (Y and Tin);

end Behavioral;
