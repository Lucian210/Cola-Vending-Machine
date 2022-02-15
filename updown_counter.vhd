----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/05/2021 11:04:52 PM
-- Design Name: 
-- Module Name: updown_counter - Behavioral
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

entity updown_counter is
  Port ( 
        clk : in STD_LOGIC;
        en : in STD_LOGIC;
        bani : out STD_LOGIC_VECTOR(15 downto 0);
        reset : in STD_LOGIC
  );
end updown_counter;

architecture Behavioral of updown_counter is

signal bani_temp: STD_LOGIC_VECTOR(15 downto 0) := "0000000000000000";

begin    
updown_counter: process(clk, en)
begin 
    if (clk='1' and clk'event) then
        if en = '1' then
            bani_temp <= bani_temp + "101";
        end if;
        if reset = '1' then
            bani_temp<="0000000000000000";
         end if;
    end if;
end process;

    bani <= bani_temp;

end Behavioral;

