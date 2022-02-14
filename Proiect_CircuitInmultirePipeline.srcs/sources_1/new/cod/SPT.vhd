----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/4/2021 06:26:07 PM
-- Design Name: 
-- Module Name: SPT - Behavioral
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

entity SPT is
    generic(n:INTEGER);
    Port (X:in std_logic_vector(n-1 downto 0);
          Y:in std_logic_vector(n-1 downto 0);
          Cin:in std_logic;
          S:out std_logic_vector(n-1 downto 0);
          Cout: out std_logic );
end SPT;

architecture Behavioral of SPT is

signal C:std_logic_vector(1 to n-1);

component SE is
    Port (X:in std_logic;
          Y:in std_logic;
          Tin:in std_logic;
          Tout:out std_logic;
          S:out std_logic );
end component;

begin

SE_0: SE port map(X(0),Y(0),Cin,C(1),S(0));

G_1: for i in 1 to n-2 generate
    SE_i: SE port map(X(i), Y(i),C(i),C(i+1),S(i));
end generate;

SE_n: SE port map(X(n-1),Y(n-1),C(n-1),Cout,S(n-1));
end Behavioral;