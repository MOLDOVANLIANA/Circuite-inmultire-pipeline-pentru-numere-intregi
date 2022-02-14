----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.10.2019 16:17:59
-- Design Name: 
-- Module Name: SE_tb - Behavioral
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

entity SE_tb is
--  Port ( );
end SE_tb;

architecture Behavioral of SE_tb is

component SE is
    Port (X:in std_logic;
          Y:in std_logic;
          Tin:in std_logic;
          Tout:out std_logic;
          S:out std_logic );
end component;

signal X:std_logic:='0';
signal Y:std_logic:='0';
signal Tin:std_logic:='0';

signal Tout:std_logic;
signal S:std_logic;

begin

inst1: SE port map(
    X=>X,
    Y=>Y,
    Tin=>Tin,
    Tout=>Tout,
    S=>S);
    
 test:process
 begin
  X<='0';
 Y<='0';
 Tin<='0';
 wait for 10ns;
 
 X<='0';
 Y<='0';
 Tin<='1';
 wait for 10ns;
 
  X<='0';
 Y<='1';
 Tin<='0';
 wait for 10ns;
 
  X<='0';
 Y<='1';
 Tin<='1';
 wait for 10ns;
 
  X<='1';
 Y<='0';
 Tin<='0';
 wait for 10ns;
 
  X<='1';
 Y<='0';
 Tin<='1';
 wait for 10ns;
 
  X<='1';
 Y<='1';
 Tin<='0';
 wait for 10ns;
 
  X<='1';
 Y<='1';
 Tin<='1';
 wait for 10ns;
 
 wait;
 end process test;

end Behavioral;
