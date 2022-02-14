----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/29/2021 01:30:53 PM
-- Design Name: 
-- Module Name: twoscompliment - Behavioral
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
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity twoscompliment is
    generic(n:integer);
    Port (X:in std_logic_vector(n-1 downto 0);
          Y:out std_logic_vector(n-1 downto 0) );
end twoscompliment;

architecture Behavioral of twoscompliment is

signal temp:std_logic_vector(n-1 downto 0);

begin

  temp <= not X;
  Y    <= std_logic_vector(unsigned(temp + 1));

end Behavioral;
