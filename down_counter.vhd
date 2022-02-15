----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/05/2021 10:48:27 PM
-- Design Name: 
-- Module Name: down_counter - Behavioral
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
use ieee.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_STD.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity down_counter is
  Port (
         clk : in STD_LOGIC;
         en : in STD_LOGIC;
         cantitate : out STD_LOGIC_VECTOR(15 downto 0);
         cola_suficienta : out STD_LOGIC
   );
end down_counter;


architecture Behavioral of down_counter is

     signal cola: STD_LOGIC_VECTOR(15 downto 0) := "0000000000000001";
     
begin
     
down_counter: process(clk, en)
        begin 
          if (clk='1' and clk'event) then
            if en = '1' then
               cola <= cola - '1';
            end if;
          end if;
     end process;
     
    cantitate <= cola;
    
destul: process(cola)
            begin 
             if (cola ="0000000000000000") then
                   cola_suficienta <= '0';
             else
                   cola_suficienta <= '1';
             end if;      
         end process;
end Behavioral;
