----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/23/2021 05:00:19 PM
-- Design Name: 
-- Module Name: Product_basic_generator - Behavioral
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
use IEEE.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Product_basic_generator is
    generic(n:integer:=32; nr_shiftari:in integer);
    Port (X:in std_logic_vector(n-1 downto 0);
          Y:in std_logic;
          P:out std_logic_vector(2*n-1 downto 0) );
end Product_basic_generator;

architecture Behavioral of Product_basic_generator is


signal tmp:std_logic_vector(2*n -1 downto 0):=x"0000000000000000";
signal shift:std_logic_vector(nr_shiftari-1 downto 0);

begin

shift<=conv_std_logic_vector(0,nr_shiftari);
tmp(n+nr_shiftari-1 downto 0) <=X & shift when nr_shiftari >0 else
                                X ;


P<=tmp when Y='1' else
   x"0000000000000000" when Y='0';
 
end Behavioral;

