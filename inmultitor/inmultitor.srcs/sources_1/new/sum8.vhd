----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.11.2020 17:03:15
-- Design Name: 
-- Module Name: sum8 - Behavioral
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

entity sum8 is
    Port ( X : in STD_LOGIC_VECTOR (9 downto 0);
           Y : in STD_LOGIC_VECTOR (9 downto 0);
           Tin : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (9 downto 0);
           Tout : out STD_LOGIC);
end sum8;

architecture Behavioral of sum8 is
signal G0,G2,G4,G6,G8,P0,P2,P4,P6,P8:std_logic:='0';
signal T2,T4,T6,T8:std_logic:='0';
begin

sum2_0: entity Work.sum2 port map(
            X => X(1 downto 0),
            Y => Y(1 downto 0),
            Tin => Tin,
            S => S(1 downto 0),
            P => P0,
            G => G0);
    
    T2<= G0 or (P0 and Tin);
    
sum2_2: entity WORK.sum2 port map(
            X => X(3 downto 2),
            Y => Y(3 downto 2),
            Tin => T2,
            S => S(3 downto 2),
            P => P2,
            G => G2);
    
    T4 <= G2 or (P2 and T2);
    
sum2_4: entity WORK.sum2 port map(
            X => X(5 downto 4),
            Y => Y(5 downto 4),
            Tin => T4,
            S => S(5 downto 4),
            P => P4,
            G => G4);
            
    T6 <= G4 or (P4 and T4);

sum2_6: entity WORK.sum2 port map(
            X => X(7 downto 6),
            Y => Y(7 downto 6),
            Tin => T6,
            S => S(7 downto 6),
            P => P6,
            G => G6);
            
    T8 <= G6 or (P6 and T6);
    
 sum2_8: entity WORK.sum2 port map(
            X => X(9 downto 8),
            Y => Y(9 downto 8),
            Tin => T8,
            S => S(9 downto 8),
            P => P8,
            G => G8);
            
    Tout <= G8 or (P8 and T8);
end Behavioral;
