----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.11.2019 17:56:24
-- Design Name: 
-- Module Name: SPT_tb - Behavioral
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

entity SPT_tb is
--  Port ( );
end SPT_tb;

architecture Behavioral of SPT_tb is

component SPT is
      generic(n:integer:=32);
      Port (X:in std_logic_vector(n-1 downto 0);
            Y:in std_logic_vector(n-1 downto 0);
            Tin:in std_logic;
            Tout:out std_logic;
            S:out std_logic_vector(n-1 downto 0) );
end component;


signal n:integer:=32;
signal X :std_logic_vector(n-1 downto 0):=x"00000000";
signal Y :std_logic_vector(n-1 downto 0):=x"00000000";
signal Tin :std_logic:='0';
signal Tout:std_logic;
signal S:std_logic_vector(n-1 downto 0);

begin

inst: SPT port map(
      X=>X,
      Y=>Y,
      Tin=>Tin,
      Tout=>Tout,
      S=>S );
      
sim_proc: process
begin
    X<=x"00000004";
    Y<=x"00000004";
    wait for 10ns;
    
    X<=x"00000029";
    Y<=x"00000064";
    wait for 10ns;
    
    X<=x"000000FF";
    Y<=x"000000FF";
    wait for 10ns;
    
    X<=x"FFFFFFF0";
    Y<=x"FFFFFFFF";
    wait for 10ns;
    
    X<=x"00000001";
    Y<=x"00000004";
    wait for 10ns;   

end process;

end Behavioral;
