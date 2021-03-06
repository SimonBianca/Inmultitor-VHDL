----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.11.2020 23:11:29
-- Design Name: 
-- Module Name: FD - Behavioral
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

entity FD is
    Port ( Clk : in STD_LOGIC;
           D : in STD_LOGIC;
           CE : in STD_LOGIC;
           Rst : in STD_LOGIC;
           Q : out STD_LOGIC);
end FD;

architecture Behavioral of FD is

begin
    process(Clk,Rst)
    begin
        if rising_edge(Clk) then
            if(Rst='1') then
                Q<='0';
            else
                if(CE='1') then
                    Q<=D;
                end if;    
            end if;
         end if;     
    end process;

end Behavioral;
