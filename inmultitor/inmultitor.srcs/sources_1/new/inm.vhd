----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.10.2020 20:25:00
-- Design Name: 
-- Module Name: inm - Behavioral
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

entity inm is
    Port ( X : in STD_LOGIC_VECTOR (23 downto 0);
           Y : in STD_LOGIC_VECTOR (23 downto 0);
           P : out STD_LOGIC_VECTOR (47 downto 0));
end inm;

architecture Behavioral of inm is
type PP_array is array(0 to 23) of std_logic_vector(23 downto 0);
type S_array is array(0 to 23) of std_logic_vector(24 downto 0);
type T_array is array(0 to 22) of std_logic_vector(24 downto 0);

signal PP:PP_array;
signal S:S_array;
signal T:T_array;

component sum_el is
    Port ( X : in STD_LOGIC;
           Y : in STD_LOGIC;
           Tin : in STD_LOGIC;
           S : out STD_LOGIC;
           Tout : out STD_LOGIC);
end component;
begin

    generarePP1: for index1 in 0 to 23 generate
        generarePP2: for index2 in 0 to 23 generate 
            PP(index1)(index2)<=X(index1) and Y(index2);
        end generate;
    end generate;
    
    generareT: for index in 0 to 22 generate
        T(index)(0)<='0';
    end generate;
    
    generareS: for index in 0 to 23 generate
        S(0)(index)<=PP(0)(index);
    end generate;
    S(0)(24)<='0';
    
    generareSE1:for index1 in 0 to 22 generate
        generareSE2:for index2 in 0 to 23 generate
            sum: sum_el port map(X=>S(index1)(index2+1),
                                Y=>PP(index1+1)(index2),
                                Tin=>T(index1)(index2),
                                Tout=>T(index1)(index2+1),
                                S=>S(index1+1)(index2));
        end generate;
        S(index1+1)(24)<=T(index1)(24);
    end generate;
    
     generareP1:for index in 0 to 22 generate
        P(index)<=S(index)(0);
     end generate;
     
     generareP2: for index in 0 to 24 generate
        P(index+23)<=S(23)(index);
     end generate;

end Behavioral;