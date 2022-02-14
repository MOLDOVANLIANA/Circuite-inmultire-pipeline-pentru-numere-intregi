----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/29/2021 01:30:03 PM
-- Design Name: 
-- Module Name: SST - Behavioral
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

entity SST is
    generic(n:INTEGER);
    Port (X:in std_logic_vector(n-1 downto 0);
          Y:in std_logic_vector(n-1 downto 0);
          Z:in std_logic_vector(n-1 downto 0);
          S:out std_logic_vector(n-1 downto 0);
          T:out std_logic_vector(n-1 downto 0));
end SST;

architecture Behavioral of SST is

component SE is
    Port (X:in std_logic;
          Y:in std_logic;
          Tin:in std_logic;
          Tout:out std_logic;
          S:out std_logic );
end component;

signal C:std_logic_vector(n downto 0);

signal tmp:std_logic_vector(n-1 downto 0):=(others=>'0');

begin

C(0)<='0';

g0: for i in 0 to n-1 generate
    SE_i: SE port map(X=>X(i),Y=>Y(i),Tin=>Z(i),Tout=>C(i+1),S=>S(i));
    tmp(i)<=C(i+1);
  end generate;

g2: for i in 0 to n-2 generate
    T(i+1) <=tmp(i);
end generate; 
    T(0)<='0';
end Behavioral;
