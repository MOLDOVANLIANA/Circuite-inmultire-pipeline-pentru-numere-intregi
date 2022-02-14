----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/29/2021 01:18:02 PM
-- Design Name: 
-- Module Name: multiplier_ssd - Behavioral
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

entity multiplier_ssd is
    Port (Sw:in std_logic_vector(15 downto 0);
          clock:in std_logic; --for basys's clock
          Clk:in std_logic; -- for multiplier clock
          Button:in std_logic;
          Button2:in std_logic; -- for introducing and outputing numbers
          Button3: in std_logic;        
          Rst:in std_logic;
          cat:out STD_LOGIC_VECTOR(6 downto 0);
          an: out STD_LOGIC_VECTOR(3 downto 0);
          led:out std_logic_vector(15 downto 0));
end multiplier_ssd;

architecture Behavioral of multiplier_ssd is

component ssd is
   Port (digit: in STD_LOGIC_VECTOR(15 downto 0);
         clock: in STD_LOGIC;
         cat:out STD_LOGIC_VECTOR(6 downto 0);
         an: out STD_LOGIC_VECTOR(3 downto 0) );
end component;

component mpg is
 Port ( en:out STD_LOGIC;
        input:in STD_LOGIC;
        clock: in STD_LOGIC);
end component;

component UC is
   Port (clock:in std_logic;
         Rst:in std_logic;
         Button:in std_logic;
         Button2:in std_logic;
         Button3:in std_logic;
         input_enable:out std_logic;
         output_enable:out std_logic;
         XYen:out std_logic_vector(1 downto 0);
         Pen:out std_logic_vector(7 downto 0));
end component;

component multiplier is
    Port (X:in std_logic_vector(31 downto 0 );
          Y:in std_logic_vector(31 downto 0);
          Clk:in std_logic;
          Rst:in std_logic;
          P: out std_logic_vector(63 downto 0));
end component;

component register_n_ce is
    generic(n:INTEGER);
    Port (D:in std_logic_vector(n-1 downto 0);
          Clk:in std_logic;
          Rst:in std_logic;
          CE:in std_logic;
          Q:out std_logic_vector(n-1 downto 0) );
end component;


signal X:std_logic_vector(31 downto 0);
signal Y:std_logic_vector(31 downto 0);
signal P: std_logic_vector(63 downto 0):=x"FFFFFFFFFFFFFFFF";

signal digit: std_logic_vector(15 downto 0);

signal Clk_mpg:std_logic;
constant n:integer:=16;

signal input_enable:std_logic;
signal output_enable:std_logic;
signal XYen:std_logic_vector(1 downto 0);
signal Pen: std_logic_vector(7 downto 0);

signal Button_mpg:std_logic;

signal inputs:std_logic_vector(1 downto 0);

begin

et1: mpg port map(en=>Clk_mpg,input=>Clk,clock=>clock);

et2: UC port map(clock=>clock,Rst=>Rst,Button=>Button,Button2=>Button2,Button3=>Button3,input_enable=>input_enable,output_enable=>output_enable,XYen=>XYen,Pen=>Pen);

et4: mpg port map(en=>Button_mpg,input=>Button,clock=>clock);

   


et_5: register_n_ce generic map(n) port map(D=>Sw(15 downto 0), Clk=>Button_mpg,Rst=>Rst,CE=> Pen(4),Q=>X(15 downto 0));
et_6:register_n_ce generic map(n) port map(D=>Sw(15 downto 0), Clk=>Button_mpg,Rst=>Rst,CE=> Pen(5),Q=>X(31 downto 16));
et_7: register_n_ce generic map(n) port map(D=>Sw(15 downto 0), Clk=>Button_mpg,Rst=>Rst,CE=> Pen(6),Q=>Y(15 downto 0));
et_8:register_n_ce generic map(n) port map(D=>Sw(15 downto 0), Clk=>Button_mpg,Rst=>Rst,CE=> Pen(7),Q=>Y(31 downto 16));
         
process(Pen)
begin
  
        if Pen(0)='1' then 
                    digit<=P(15 downto 0);
                    led<=x"4010";
        elsif Pen(1)='1' then 
                    digit<=P(31 downto 16);
                    led<=x"4020";
        elsif Pen(2)='1' then 
                    digit<=P(47 downto 32);
                    led<=x"4040";
        elsif Pen(3)='1' then 
                    digit<=P(63 downto 48);
                    led<=x"4080";
         elsif Pen(4)='1' then 
                    digit<=X(15 downto 0);
                    led<=x"8001";
         elsif Pen(5)='1' then 
                    digit<=X(31 downto 16);
                    led<=x"8002";
         elsif Pen(6)='1' then 
                    digit<=Y(15 downto 0);
                    led<=x"8004";
          elsif Pen(7)='1' then 
                    digit<=Y(31 downto 16);
                      led<=x"8008";
        end if;
  --   end if;

end process;
         



et_3: multiplier port map(X=>X,Y=>Y,Clk=>Clk_mpg,Rst=>Rst,P=>P);
et_n: ssd port map(digit=>digit ,clock=>clock,cat=>cat,an=>an);
end Behavioral;

