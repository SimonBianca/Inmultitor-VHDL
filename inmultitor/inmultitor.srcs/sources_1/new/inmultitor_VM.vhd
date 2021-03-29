----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.11.2020 15:27:25
-- Design Name: 
-- Module Name: inmultitor_VM - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity inmultitor_VM is
    Port ( Clk : in STD_LOGIC;
           Rst : in STD_LOGIC;
           Start : in STD_LOGIC;
           X : in STD_LOGIC_VECTOR (31 downto 0);
           Y : in STD_LOGIC_VECTOR (31 downto 0);
           P : out STD_LOGIC_VECTOR (31 downto 0);
           Term : out STD_LOGIC);
end inmultitor_VM;

architecture Behavioral of inmultitor_VM is

signal Load, CE_sum, CE_inm, CE_norm:std_logic:='0';
signal X_aux, Y_aux:std_logic_vector(31 downto 0):=(others=>'0');
signal LessX, LessY, EqualX, EqualY, MoreX, MoreY:std_logic:='0';
signal LessE1, LessE2, EqualE1, EqualE2, MoreE1, MoreE2:std_logic:='0';
signal LessInf1, LessInf2, EqualInf1, EqualInf2, MoreInf1, MoreInf2:std_logic:='0';
signal S_exp:std_logic_vector(9 downto 0):=(others=>'0');
signal Tout_exp:std_logic:='0';
signal ExpX_aux, ExpY_aux:std_logic_vector(9 downto 0):=(others=>'0');
signal MantisaX_aux, MantisaY_aux:std_logic_vector(23 downto 0):=(others=>'0');
signal P_Mantisa:std_logic_vector(47 downto 0):=(others=>'0');
signal Exp_aux, Exp_norm:std_logic_vector(7 downto 0):=(others=>'0');
signal Mantisa_aux:std_logic_vector(47 downto 0):=(others=>'0');
signal Mantisa_norm:std_logic_vector(22 downto 0):=(others=>'0');
signal OVF_aux:std_logic:='0';
signal depi_aux,deps_aux,dep_inf,dep_sup:std_logic:='0';
signal semn:std_logic:='0';
signal numar:std_logic_vector(30 downto 0):=(others=>'0');
signal Term_aux:std_logic:='0';
signal zero:std_logic:='0';
signal infinit:std_logic:='0';
signal NAN:std_logic:='0';

constant valoarea_zero:std_logic_vector(30 downto 0):=(others=>'0');
constant valoarea_infinit:std_logic_vector(30 downto 0):="1111111100000000000000000000000";

begin

    regX: entity WORK.FDN
                generic map(n=>32)
                port map(Clk=>Clk, D=>X, Rst=>Rst, CE=>Load, Q=>X_aux);
                
    regY: entity WORK.FDN
                generic map(n=>32)
                port map(Clk=>Clk, D=>Y, Rst=>Rst, CE=>Load, Q=>Y_aux);
                
    zero_X: entity WORK.comparator
                generic map(n=>31)
                port map(X=>X_aux(30 downto 0), Y=>valoarea_zero, Less=>LessX,
                Equal=>EqualX, More=>MoreX);
                
     zero_Y: entity WORK.comparator
                generic map(n=>31)
                port map(X=>Y_aux(30 downto 0), Y=>valoarea_zero, Less=>LessY,
                Equal=>EqualY, More=>MoreY);           
      
      infinitX: entity WORK.comparator
               generic map(n=>31)
               port map(X=>X_aux(30 downto 0), Y=>valoarea_infinit, Less=>LessInf1,
               Equal=>EqualInf1, More=>MoreInf1);
      
      infinitY: entity WORK.comparator
               generic map(n=>31)
               port map(X=>Y_aux(30 downto 0), Y=>valoarea_infinit, Less=>LessInf2,
               Equal=>EqualInf2, More=>MoreInf2);
               
      infinit<=EqualInf1 or EqualInf2;
               
      ExpX_aux<="00" & X_aux(30 downto 23);
      ExpY_aux<="00" & Y_aux(30 downto 23);
      
      sum_exp: entity WORK.sumator
                port map(X=>ExpX_aux, Y=>ExpY_aux, Tin=>'0', S=>S_exp, Tout=>Tout_exp);
       
      depasire_inf: entity WORK.comparator
               generic map(n=>9)
               port map(X=>S_exp(8 downto 0), Y=>"000000001", Less=>LessE1,
               Equal=>EqualE1, More=>MoreE1);
      
      depasire_sup: entity WORK.comparator
               generic map(n=>9)
               port map(X=>S_exp(8 downto 0), Y=>"011111110", Less=>LessE2,
               Equal=>EqualE2, More=>MoreE2);
       
       depi_aux<=LessE1 or S_exp(9); 
       deps_aux<=MoreE2 and (not S_exp(9));
              
       reg_depi: entity WORK.FD
                port map(Clk=>Clk, D=>depi_aux, CE=>CE_sum, Rst=>Rst, Q=>dep_inf);
             
       reg_deps: entity WORK.FD
                port map(Clk=>Clk, D=>deps_aux, CE=>CE_sum, Rst=>Rst, Q=>dep_sup);
                
       MantisaX_aux<='1' & X_aux(22 downto 0);
       MantisaY_aux<='1' & Y_aux(22 downto 0);
       
       regExp: entity WORK.FDN
                generic map(n=>8)
                port map(Clk=>Clk, D=>S_exp(7 downto 0), Rst=>Rst, CE=>CE_sum, Q=>Exp_aux);

       inmultire: entity WORK.inm
                port map(X=>MantisaX_aux, Y=>MantisaY_aux, P=>P_Mantisa);        
           
       regMantisa: entity WORK.FDN
                generic map(n=>48)
                port map(Clk=>Clk, D=>P_Mantisa, Rst=>Rst, CE=>CE_inm, Q=>Mantisa_aux);
        
       norm: entity WORK.normalizare_rotunjire
                port map(Clk=>Clk, Rst=>Rst, CE=>CE_norm, Exp=>Exp_aux, Mantisa=>Mantisa_aux,
                ExpOut=>Exp_norm, MantisaOut=>Mantisa_norm, OVF=>OVF_aux);    
      
      semn<=X_aux(31) xor Y_aux(31);
      numar<=Exp_norm & Mantisa_norm;
      
      NAN<='1' when ((EqualX and EqualInf2) or (EqualY and EqualInf1))='1' else '0';
      
      rezultat: entity WORK.prelucrareRezultat
                port map(Clk=>Clk, Rst=>Rst, CE=>term_aux, numar=>numar, semn=>semn, zero=>zero, zeroX=>EqualX,
                zeroY=>EqualY, dep_inf=>dep_inf, dep_sup=>dep_sup, infinit=>infinit,NAN=>NAN, rezultat=>P);
      
      UC1: entity WORK.UC
                port map(Clk=>Clk, Rst=>Rst, Start=>Start, zeroX=>EqualX, 
                zeroY=>EqualY, Load=>Load, CE_sum=>CE_sum, CE_inm=>CE_inm,
                CE_norm=>CE_norm, zero=>zero, Term=>term_aux);
            
    Term<=term_aux;    
end Behavioral;
