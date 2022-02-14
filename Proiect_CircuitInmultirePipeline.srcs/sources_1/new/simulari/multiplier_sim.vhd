----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/02/2022 02:06:19 PM
-- Design Name: 
-- Module Name: multiplier_sim - Behavioral
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


entity multiplier_sim is
--  Port ( );
end multiplier_sim;

architecture Behavioral of multiplier_sim is

component multiplier is
    Port (X:in std_logic_vector(31 downto 0 );
          Y:in std_logic_vector(31 downto 0);
          Clk:in std_logic;
          Rst:in std_logic;
          P: out std_logic_vector(63 downto 0));
end component;

signal X:std_logic_vector(31 downto 0):=x"00000000";
signal Y:std_logic_vector(31 downto 0):=x"00000000";
signal Clk:std_logic:='0';
signal Rst:std_logic:='0';

signal P:std_logic_vector(63 downto 0);

begin

inst: multiplier port map(X,Y,Clk,Rst,P);

sim_proc:process
begin
    X<=x"00000230";
    Y<=x"00000020";
    wait for 20ns;
   
    Clk<='1';
    wait for 20ns;
     Clk<='0';

end process;

end Behavioral;