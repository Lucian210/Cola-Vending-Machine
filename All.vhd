----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/05/2021 10:16:30 PM
-- Design Name: 
-- Module Name: All - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_STD.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.Proiect;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.Proiect;

entity Proiect is
    Port ( clk : in STD_LOGIC;
           add : in STD_LOGIC;
           insert : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR(15 downto 0);
           rest : out STD_LOGIC_VECTOR(15 downto 0);
           verificare : in STD_LOGIC
           );
end Proiect;


architecture Behavioral of Proiect is

component updown_counter is
  Port ( 
          clk : in STD_LOGIC;
          en : in STD_LOGIC;
          bani : out STD_LOGIC_VECTOR(15 downto 0);
          reset : in STD_LOGIC
        );
end component;

component readwrite is
  Port (
        clk : in STD_LOGIC;
        en : in STD_LOGIC;
        add : in STD_LOGIC_VECTOR(15 downto 0);
        read : out STD_LOGIC_VECTOR(15 downto 0);
        change : out STD_LOGIC_VECTOR(15 downto 0);
        reset : in STD_LOGIC
         );
end component;


component down_counter is
  Port (
         clk : in STD_LOGIC;
         en : in STD_LOGIC;
         cantitate : out STD_LOGIC_VECTOR(15 downto 0);
         cola_suficienta : out STD_LOGIC
        );
end component;


signal bani: STD_LOGIC_VECTOR(15 downto 0);     --out COUNT INSERT BANI
signal reset: STD_LOGIC;     
signal rwm_reset: STD_LOGIC;     


signal bani_rwm: STD_LOGIC_VECTOR(15 downto 0) := "0000000000000000"; --out RWM
signal change: STD_LOGIC_VECTOR(15 downto 0) := "0000000000000000"; --out RWM

signal cola: STD_LOGIC_VECTOR(15 downto 0);

signal cola_en: STD_LOGIC := '0';  

 
signal cola_suficienta: STD_LOGIC;   
signal bani_ok: STD_LOGIC;   


signal insert_conditioned: STD_LOGIC;   

begin

insert_conditioned <= insert and cola_suficienta and bani_ok;


P1: updown_counter port map(clk, add, bani, reset);
P2: readwrite port map(clk, insert_conditioned, bani, bani_rwm, change, rwm_reset);
P3: down_counter port map(clk, cola_en, cola, cola_suficienta);



firstcounter: process(clk, reset, insert_conditioned)
begin     
            if(insert_conditioned = '1') then
                reset<='1';
            else
                reset <= '0';
            end if;     
end process;

reset_rwm: process(clk, rwm_reset, verificare, bani_rwm, change, cola_en)
begin                 
            if(verificare = '1') then
                rwm_reset<='1';       
                else
                if (clk='1' and clk'event) then
                    rwm_reset <= '0';
                end if;
            end if;
            
            if(change < "0000000001100100") then
               rest <= change;
                    cola_en <= '0';
             elsif(change = "0000000001100100") then
                    rest <= "0000000000000000";
                    cola_en <= '1';                    
             elsif(change > "0000000001100100") then
                     rest <= change - "0000000001100100";
                     cola_en <= '1';
             else
                     cola_en <= '0';
             end if;                   
end process;


lumini: process(clk, bani, change)
    begin
        if(bani = "0000000000000101") then
            led(15 downto 0) <= "0000000000000001";     --5 bani
            bani_ok <= '1';
        elsif(bani = "0000000000001010") then
            led(15 downto 0) <= "0000000000000010";     --10 bani
            bani_ok <= '1';
        elsif(bani = "0000000000110010") then
            led(15 downto 0) <= "0000000000000100";     --50 bani
            bani_ok <= '1';
        elsif(change >= "0000000001100100") then
            led(15 downto 0) <= "0000000000001000";     --eliberare cola
        else
            led(15 downto 0) <= "0000000000000000";
            bani_ok <= '0';
        end if;
        
    end process;




end Behavioral;
