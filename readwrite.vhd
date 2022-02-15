----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/19/2021 04:38:24 PM
-- Design Name: 
-- Module Name: readwrite - Behavioral
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

entity readwrite is
  Port (
        clk : in STD_LOGIC;
        en : in STD_LOGIC;
        add : in STD_LOGIC_VECTOR(15 downto 0);
        read : out STD_LOGIC_VECTOR(15 downto 0);
        change : out STD_LOGIC_VECTOR(15 downto 0)  :=  "0000000000000000";
        reset : in STD_LOGIC
         );
end readwrite;

architecture Behavioral of readwrite is


signal write_temp: STD_LOGIC_VECTOR(15 downto 0);
signal mem: STD_LOGIC_VECTOR(15 downto 0) :=  "0000000000000000";



begin

write_temp <= add + mem;
process(clk, en, write_temp, mem)
    begin
        if (clk='1' and clk'event) then
            if(en = '1') then
                mem<=write_temp;
            end if;
            if(reset = '1') then
                change<=mem;
                mem <= "0000000000000000";
            end if;  
        end if;

    end process;
       read <= mem;

end Behavioral;
