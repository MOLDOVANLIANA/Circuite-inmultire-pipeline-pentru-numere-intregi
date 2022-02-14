----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/02/2022 12:38:29 PM
-- Design Name: 
-- Module Name: generator+_sim - Behavioral
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

entity generator_sim is
--  Port ( );
end generator_sim;

architecture Behavioral of generator_sim is

component product_generator is
    generic(n:integer:=32);
    Port (X:in std_logic_vector(n-1 downto 0);
          Y:in std_logic_vector(n-1 downto 0);
          P:out my_array(n-1 downto 0) );
end component;

signal n:integer:=32;

signal X: std_logic_vector(n-1 downto 0):=(others =>'0');
signal Y: std_logic_vector(n-1 downto 0):=(others =>'0');

signal P:my_array(n-1 downto 0);

begin

inst0: product_generator generic map(n) port map(X,Y,P);

sim: process
begin
    X<=x"0000000B";
    Y<=x"B000000F";
    wait for 50ns;

end process;

end Behavioral;
