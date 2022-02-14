----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/29/2021 01:22:47 PM
-- Design Name: 
-- Module Name: register_n - Behavioral
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

entity register_n is
    generic(n:INTEGER);
    Port (D:in std_logic_vector(n-1 downto 0);
          Clk:in std_logic;
          Rst:in std_logic;
          Q:out std_logic_vector(n-1 downto 0) );
end register_n;

architecture Behavioral of register_n is

begin

process(Clk,Rst)
begin
    if Rst='1' then Q<=(others=>'0');
    elsif Clk'event and Clk='1' then
        Q<=D;
    end if;

end process;
end Behavioral;