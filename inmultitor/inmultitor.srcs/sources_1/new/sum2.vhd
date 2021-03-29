----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.11.2020 17:02:18
-- Design Name: 
-- Module Name: sum2 - Behavioral
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
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sum2 is
    Port ( X : in STD_LOGIC_VECTOR (1 downto 0);
           Y : in STD_LOGIC_VECTOR (1 downto 0);
           Tin : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (1 downto 0);
           P : out STD_LOGIC;
           G : out STD_LOGIC);
end sum2;

architecture Behavioral of sum2 is
signal g0,g1,p0,p1:std_logic;
signal T1:std_logic:='0';
begin

    S(0) <= X(0) xor Y(0) xor Tin;
    T1<=g0 or (p0 and Tin);
    S(1) <= X(1) xor Y(1) xor T1;
    
    g0 <= X(0) and Y(0);
    g1 <= X(1) and Y(1);
    
    p0 <= X(0) or Y(0);
    p1 <= X(1) or Y(1);
    
    G <= g1 or (p1 and g0);
    P <= p1 and p0;
    
end Behavioral;