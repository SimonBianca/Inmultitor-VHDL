----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.11.2020 18:53:30
-- Design Name: 
-- Module Name: FDN - Behavioral
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

entity FDN is
    generic(n:natural);
    port(Clk:in std_logic;
        D:in std_logic_vector(n-1 downto 0);
        Rst:in std_logic;
        CE:in std_logic;
        Q:out std_logic_vector(n-1 downto 0));
end FDN;

architecture Behavioral of FDN is

begin
    process(Clk,Rst)
    begin
        if(rising_edge(Clk)) then
            if(Rst='1') then
                Q<=(others=>'0');   
            else 
                if(CE='1') then
                    Q<=D;
                end if;
            end if;
        end if;     
    end process;

end Behavioral;
