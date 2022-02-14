----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/29/2021 01:15:43 PM
-- Design Name: 
-- Module Name: multiplier - Behavioral
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
use ieee.numeric_std.all;
library work;
use work.pkg.all;



entity multiplier is
    Port (X:in std_logic_vector(31 downto 0 );
          Y:in std_logic_vector(31 downto 0);
          Clk:in std_logic;
          Rst:in std_logic;
          P: out std_logic_vector(63 downto 0));
end multiplier;

architecture Behavioral of multiplier is

component SST is
    generic(n:INTEGER);
    Port (X:in std_logic_vector(n-1 downto 0);
          Y:in std_logic_vector(n-1 downto 0);
          Z:in std_logic_vector(n-1 downto 0);
          S:out std_logic_vector(n-1 downto 0);
          T:out std_logic_vector(n-1 downto 0));
end component;

component product_generator is
    generic(n:integer:=32);
    Port (X:in std_logic_vector(n-1 downto 0);
          Y:in std_logic_vector(n-1 downto 0);
          P:out my_array(n-1 downto 0) );
end component;

component register_n is
    generic(n:INTEGER);
    Port (D:in std_logic_vector(n-1 downto 0);
          Clk:in std_logic;
          Rst:in std_logic;
          Q:out std_logic_vector(n-1 downto 0) );
end component;

component SPT is
    generic(n:INTEGER:=32);
    Port (X:in std_logic_vector(n-1 downto 0);
          Y:in std_logic_vector(n-1 downto 0);
          Cin:in std_logic;
          S:out std_logic_vector(n-1 downto 0);
          Cout: out std_logic );
end component;

component twoscompliment is
    generic(n:integer);
    Port (X:in std_logic_vector(n-1 downto 0);
          Y:out std_logic_vector(n-1 downto 0) );
end component;

component mpg is
 Port ( en:out STD_LOGIC;
        input:in STD_LOGIC;
        clock: in STD_LOGIC);
end component;


constant n:integer:=32;
constant n_sign:integer:=2;
signal R11,R12:std_logic_vector(n-1 downto 0);

signal M: my_array(n-1 downto 0) ;

type R2_type is array(31 downto 0) of std_logic_vector(2*n-1 downto 0);
signal R2 : R2_type;

type R3_type is array(21 downto 0) of std_logic_vector(2*n-1 downto 0);
signal R3: R3_type;
signal ST1:R3_type;

type R4_type is array(14 downto 0) of std_logic_vector(2*n-1 downto 0);
signal R4: R4_type;
signal ST2:R4_type;

type R5_type is array(9 downto 0) of std_logic_vector(2*n-1 downto 0);
signal R5:R5_type;
signal ST3:R5_type;

type R6_type is array(6 downto 0) of std_logic_vector(2*n-1 downto 0);
signal R6:R6_type;
signal ST4:R6_type;

type R7_type is array(4 downto 0) of std_logic_vector(2*n-1 downto 0);
signal R7:R7_type;
signal ST5:R7_type;

type R8_type is array(3 downto 0) of std_logic_vector(2*n-1 downto 0);
signal R8:R8_type;
signal ST6:R8_type;

type R9_type is array(2 downto 0) of std_logic_vector(2*n-1 downto 0);
signal R9:R9_type;
signal ST7:R9_type;

type R10_type is array(1 downto 0) of std_logic_vector(2*n-1 downto 0);
signal R10:R10_type;
signal ST8:R10_type;

signal SPT_Tout:std_logic;

signal X_in:std_logic_vector(31 downto 0);
signal Y_in:std_logic_vector(31 downto 0);
signal X_complemented:std_logic_vector(31 downto 0);
signal Y_complemented:std_logic_vector(31 downto 0);
signal complemented_x:std_logic:='0';
signal complemented_y:std_logic:='0';
signal complemented:std_logic:='0';
signal P_out:std_logic_vector(63 downto 0);
signal P_complemented:std_logic_vector(63 downto 0);

begin

twoc1:twoscompliment generic map(32) port map(X,X_complemented);
twoc2:twoscompliment generic map(32) port map(Y,Y_complemented);

complemented_x <= '1' when X(31)='1' else '0';
                
complemented_y <= '1' when Y(31)='1' else '0';
                
with complemented_x select X_in<= X when '0', X_complemented when others;
    
with complemented_y select Y_in<=Y when '0', Y_complemented when others;
    

i11:register_n generic map(n) port map(X_in,Clk,Rst,R11);
i12:register_n generic map(n) port map(Y_in,Clk,Rst,R12);

i1: product_generator generic map(n) port map(X=>R11,Y=>R12,P=>M);

i2: for i in 0 to n-1 generate
      et_i:register_n generic map(2*n) port map(M(i),Clk,Rst,R2(i));
end generate;



i21: for i in 0 to 9 generate
    et_i:SST generic map(2*n) port map(X=>R2(3*i),Y=>R2(3*i+1),Z=>R2(3*i+2),S=>ST1(2*i),T=>ST1(2*i+1)); 
end generate;

i3: for i in 0 to 19 generate
    et_i: register_n generic map(2*n) port map(ST1(i),Clk,Rst,R3(i));
end generate;



 i301: register_n generic map(2*n) port map(R2(30),Clk,Rst,R3(20));
 i302: register_n generic map(2*n) port map(R2(31),Clk,Rst,R3(21));


i31: for i in 0 to 6 generate
    et_i: SST generic map(2*n) port map(X=>R3(3*i),Y=>R3(3*i+1),Z=>R3(3*i+2),S=>ST2(2*i),T=>ST2(2*i+1));
end generate;

i4: for i in 0 to 13 generate
    et_i:register_n generic map(2*n) port map(ST2(i),Clk,Rst,R4(i));
end generate;



i401:register_n generic map(2*n) port map(R3(21),Clk,Rst,R4(14));


i41: for i in 0 to 4 generate
    et_i:SST generic map(2*n) port map(X=>R4(3*i),Y=>R4(3*i+1),Z=>R4(3*i+2),S=>ST3(2*i),T=>ST3(2*i+1));
end generate;

i5: for i in 0 to 9 generate
    et_i:register_n generic map(2*n) port map(ST3(i),Clk,Rst,R5(i));
end generate;



i51: for i in 0 to 2 generate
    et_i:SST generic map(2*n) port map(X=>R5(3*i),Y=>R5(3*i+1),Z=>R5(3*i+2),S=>ST4(2*i),T=>ST4(2*i+1));
end generate;

i6: for i in 0 to 5 generate
    et_i:register_n generic map(2*n) port map(ST4(i),Clk,Rst,R6(i));
end generate;



i601:register_n generic map(2*n) port map(R5(9),Clk,Rst,R6(6));

inst61: for i in 0 to 1 generate
    et_i:SST generic map(2*n) port map(X=>R6(3*i),Y=>R6(3*i+1),Z=>R6(3*i+2),S=>ST5(2*i),T=>ST5(2*i+1));
end generate;

i7: for i in 0 to 3 generate
    et_i:register_n generic map(2*n) port map(ST5(i),Clk,Rst,R7(i));
end generate;


i701:register_n generic map(2*n) port map(R6(6),Clk,Rst,R7(4));


i71:SST generic map(2*n) port map(X=>R7(0),Y=>R7(1),Z=>R7(2),S=>ST6(0),T=>ST6(1));


i801:register_n generic map(2*n) port map(ST6(0),Clk,Rst,R8(0));
i802:register_n generic map(2*n) port map(ST6(1),Clk,Rst,R8(1));
i803:register_n generic map(2*n) port map(R7(3),Clk,Rst,R8(2));
i804:register_n generic map(2*n) port map(R7(4),Clk,Rst,R8(3));


i81:SST generic map(2*n) port map(X=>R8(0),Y=>R8(1),Z=>R8(2),S=>ST7(0),T=>ST7(1));


i901:register_n generic map(2*n) port map(ST7(0),Clk,Rst,R9(0));
i902:register_n generic map(2*n) port map(ST7(1),Clk,Rst,R9(1));
i903:register_n generic map(2*n) port map(R8(3),Clk,Rst,R9(2));



i91:SST generic map(2*n) port map(X=>R9(0),Y=>R9(1),Z=>R9(2),S=>ST8(0),T=>ST8(1));


i101:register_n generic map(2*n) port map(ST8(0),Clk,Rst,R10(0));
i102:register_n generic map(2*n) port map(ST8(1),Clk,Rst,R10(1));



i10:SPT generic map(2*n) port map(X=>R10(0),Y=>R10(1),Cin=>'0',S=>P_out,Cout=>SPT_Tout);


twoc3:twoscompliment generic map(64) port map(P_out,P_complemented);


end Behavioral;