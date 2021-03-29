----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.11.2020 17:37:45
-- Design Name: 
-- Module Name: UC - Behavioral
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

entity UC is
    Port ( Clk : in STD_LOGIC;
           Rst : in STD_LOGIC;
           Start : in STD_LOGIC;
           zeroX : in STD_LOGIC;
           zeroY : in STD_LOGIC;
           Load : out STD_LOGIC;
           CE_sum : out STD_LOGIC;
           CE_inm : out STD_LOGIC;
           CE_norm : out STD_LOGIC;
           zero : out STD_LOGIC;
           Term : out STD_LOGIC);
end UC;

architecture Behavioral of UC is

type TIP_STARE is (idle, initializare, adunare, verificare1, inmultire, normalizare_rotunjire,stop);
signal stare: TIP_STARE;

begin

    process(Clk)
    begin
        if(rising_edge(Clk)) then
            if(Rst='1') then
                stare<=idle;
            else
                case stare is
                    when idle=>
                        if(Start='1') then
                            stare<=initializare;
                        else 
                            stare<=idle;
                        end if;
                    when initializare=>
                        stare<=adunare;
                    when adunare=> 
                        stare<=verificare1;
                    when verificare1=>
                        if(zeroX='1' or zeroY='1') then
                            zero<='1';
                        else
                            zero<='0';
                        end if;
                        stare<=inmultire;
                    when inmultire=>
                        stare<=normalizare_rotunjire;
                    when normalizare_rotunjire=>
                        stare<=stop;
                    when stop=>
                        stare<=idle;
                end case;
            end if;
         end if;
    end process;
    
    process(stare)
    begin
        case stare is
            when idle=>
                       Load<='0';
                       CE_sum<='0';
                       CE_inm<='0';
                       CE_norm<='0';
                       Term<='0';
            when initializare=>
                       Load<='1';
                       CE_sum<='0';
                       CE_inm<='0';
                       CE_norm<='0';
                       Term<='0';
            when adunare=>
                       Load<='0';
                       CE_sum<='1';
                       CE_inm<='0';
                       CE_norm<='0';
                       Term<='0'; 
            when verificare1=>
                       Load<='0';
                       CE_sum<='0';
                       CE_inm<='0';
                       CE_norm<='0';
                       Term<='0';        
            when inmultire=>
                       Load<='0';
                       CE_sum<='0';
                       CE_inm<='1';
                       CE_norm<='0';
                       Term<='0';
            when normalizare_rotunjire=>
                       Load<='0';
                       CE_sum<='0';
                       CE_inm<='0';
                       CE_norm<='1';
                       Term<='0';
            when stop=>
                       Load<='0';
                       CE_sum<='0';
                       CE_inm<='0';
                       CE_norm<='0';
                       Term<='1';
        end case;
    end process;

end Behavioral;
