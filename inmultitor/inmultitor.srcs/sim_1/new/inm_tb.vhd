----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.10.2020 20:32:18
-- Design Name: 
-- Module Name: inm_tb - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity inm_tb is
--  Port ( );
end inm_tb;

architecture Behavioral of inm_tb is

signal X:std_logic_vector(23 downto 0);
signal Y:std_logic_vector(23 downto 0);
signal P:std_logic_vector(47 downto 0);

component inm is
  Port ( X : in STD_LOGIC_VECTOR (23 downto 0);
         Y : in STD_LOGIC_VECTOR (23 downto 0);
         P : out STD_LOGIC_VECTOR (47 downto 0));
end component;

begin

    inm_tb: inm port map(X=>X, Y=>Y, P=>P);
    process 
    variable nr_erori:Integer:=0;
    begin 
        X<=x"000000";
        Y<=x"000004";
        wait for 10 ns;
        if(P/=x"000000") then
            nr_erori:=nr_erori+1;
        end if;
        
        X<=x"000007";
        Y<=x"000006";
        wait for 10 ns;
        if(P/=x"2A") then
            nr_erori:=nr_erori+1;
        end if;
        
        X<=x"000C67";
        Y<=x"0014F0";
        wait for 10 ns;
        if(P/=x"103AC90") then
            nr_erori:=nr_erori+1;
        end if;
        
        X<=x"FF54FF";
        Y<=x"FF0DD4";
        wait for 10 ns;
        if(P/=x"FE6374C4562C") then
            nr_erori:=nr_erori+1;
        end if;
        
    report "Testare terminata cu " & INTEGER'image(nr_erori) & " erori";     
    end process;


end Behavioral;
