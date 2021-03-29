----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.11.2020 19:54:55
-- Design Name: 
-- Module Name: normalizare - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity normalizare_rotunjire is
    Port ( Clk : in STD_LOGIC;
           Rst : in STD_LOGIC;
           CE : in STD_LOGIC;
           Exp : in STD_LOGIC_VECTOR (7 downto 0);
           Mantisa : in STD_LOGIC_VECTOR (47 downto 0);
           ExpOut : out STD_LOGIC_VECTOR (7 downto 0);
           MantisaOut : out STD_LOGIC_VECTOR (22 downto 0);
           OVF : out STD_LOGIC);
end normalizare_rotunjire;

architecture Behavioral of normalizare_rotunjire is
signal exponent_n:std_logic_vector(7 downto 0):=x"00";
signal mantisa_n:std_logic_vector(22 downto 0):=(others=>'0');
signal grs_aux: std_logic := '0';
signal dep:std_logic:='0';
begin

    process(Mantisa,Clk,CE,Rst,Exp)
    begin
        if(rising_edge(Clk)) then
            if(Rst='1') then
                exponent_n<=(others =>'0');
                mantisa_n<=(others =>'0');
                grs_aux<='0';
                dep<='0';
            elsif(CE='1') then
                if(Exp=x"FF") then
                    dep<='1';
                    exponent_n<=Exp;
                    mantisa_n<=(others=>'0');
                else
                    case(Mantisa(47 downto 46)) is
                        when "01"=> mantisa_n<=Mantisa(45 downto 23);
                                    exponent_n<=Exp; 
                                    for i in 22 downto 0 loop
                                        grs_aux <= grs_aux or Mantisa(i);
                                    end loop;
                        when "10"=> mantisa_n<='0' & Mantisa(45 downto 24);
                                    exponent_n<=Exp+1; 
                                    for i in 23 downto 0 loop
                                        grs_aux <= grs_aux or Mantisa(i);
                                    end loop;
                        when "11"=> mantisa_n<='1' & Mantisa(45 downto 24);
                                    exponent_n<=Exp+1; 
                                    for i in 23 downto 0 loop
                                        grs_aux <= grs_aux or Mantisa(i);
                                    end loop;
                        when others=> mantisa_n<=Mantisa(45 downto 23);
                                    exponent_n<=Exp; 
                                    grs_aux<='0';
                    end case;   
                    if(Exp=x"FF") then
                        dep<='1';
                        exponent_n<=Exp;
                        mantisa_n<=(others=>'0');
                    end if;
                end if;
            end if;
        end if;
    end process;
    
      OVF<=dep;
      MantisaOut<=(mantisa_n + 1) when grs_aux='1' else mantisa_n;
      ExpOut<=exponent_n;

end Behavioral;
