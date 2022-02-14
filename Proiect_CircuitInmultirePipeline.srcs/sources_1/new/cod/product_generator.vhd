----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/23/2021 10:16:34 PM
-- Design Name: 
-- Module Name: product_generator - Behavioral
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


package pkg is
  constant n: integer:=32;
  type my_array is array (natural range <>) of std_logic_vector(2*n-1 downto 0);
end package;

package body pkg is
end package body;


library ieee;
use ieee.std_logic_1164.all;
library work;
use work.pkg.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity product_generator is
    generic(n:integer:=32);
    Port (X:in std_logic_vector(n-1 downto 0);
          Y:in std_logic_vector(n-1 downto 0);
          P:out my_array(n-1 downto 0) );
end product_generator;

architecture Behavioral of product_generator is


component Product_basic_generator is
    generic(n:integer:=32; nr_shiftari:in integer);
    Port (X:in std_logic_vector(n-1 downto 0);
          Y:in std_logic;
          P:out std_logic_vector(2*n-1 downto 0) );
end component;

type array32_64 is array(0 to n-1) of std_logic_vector(2*n-1 downto 0);
signal PP:array32_64:=(others=>x"0000000000000000");


begin

g0: for i in 0 to n-1 generate
    pbg_i: Product_basic_generator generic map(n,i) port map(X=>X,Y=>Y(i),P=>PP(i));
end generate;
 
 g1: for i in 0 to n-1 generate
    et_i: P(i)<=PP(i);
 end generate;
 
end Behavioral;

