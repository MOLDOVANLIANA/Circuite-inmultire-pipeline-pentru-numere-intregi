----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/31/2021 01:31:44 PM
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
   Port (clock:in std_logic;
         Rst:in std_logic;
         Button:in std_logic;
         Button2:in std_logic;
         Button3:in std_logic;
         input_enable:out std_logic;
         output_enable:out std_logic;
         XYen:out std_logic_vector(1 downto 0);
         Pen:out std_logic_vector(7 downto 0) );
end UC;

architecture Behavioral of UC is

component mpg is
 Port ( en:out STD_LOGIC;
        input:in STD_LOGIC;
        clock: in STD_LOGIC);
end component;

type state_type is (idle,initx1,initx2,inity1,inity2);
signal state:state_type:=idle;

type state_type2 is (idle,printp1,printp2,printp3,printp4,printp5,printp6,printp7,printp8);
signal state2:state_type2:=idle;

type state_type3 is(input_state,output_state);
signal state3: state_type3:=input_state;

signal Button_mpg:std_logic;
signal Button_mpg2:std_logic;
signal Button_mpg3:std_logic;

begin

et1: mpg port map(en=>Button_mpg,input=>Button,clock=>clock);
et2: mpg port map(en=>Button_mpg2,input=>Button2,clock=>clock);
et3: mpg port map(en=>Button_mpg3,input=>Button3,clock=>clock);




process(Button_mpg2)
begin
  if Rst='1' then   
        state2<=idle;
  elsif Button_mpg2'event and Button_mpg2 = '1' then
    case state2 is
            when idle => state2 <= printp1;
            when printp1 => 
                            state2<= printp2;
            when printp2 => 
                            state2 <= printp3;
            when printp3 => 
                            state2 <= printp4;
            when printp4 => 
                            state2 <=printp5;
            when printp5=> 
                            state2<=printp6;
            when printp6=> 
                            state2<=printp7;
            when printp7=> 
                            state2<=printp8;
            when printp8=> 
                            state2<=printp1;                
            when others => state2<=printp1;
        end case;
    end if;
 end process;
 
 process(state2)
 begin
    case state2 is 
        when idle => Pen<="00000000";
        when printp1 => Pen <= "00000001";
        when printp2 => Pen <= "00000010";
        when printp3 => Pen <= "00000100";
        when printp4 => Pen <= "00001000";
        when printp5 => Pen <= "00010000";
        when printp6 => Pen <= "00100000";
        when printp7 => Pen <= "01000000";
        when printp8 => Pen <= "10000000";
        when others => Pen<= "00000000";
    end case;
 end process;


end Behavioral;
