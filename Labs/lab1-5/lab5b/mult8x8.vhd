--******************************************************************************
--                                                                             *
--                  Copyright (C) 2014 Altera Corporation                      *
--                                                                             *
-- ALTERA, ARRIA, CYCLONE, HARDCOPY, MAX, MEGACORE, NIOS, QUARTUS & STRATIX    *
-- are Reg. U.S. Pat. & Tm. Off. and Altera marks in and outside the U.S.      *
--                                                                             *
-- All information provided herein is provided on an "as is" basis,            *
-- without warranty of any kind.                                               *
--                                                                             *
-- Module Name: mult8x8                        File Name: mult8x8.vhd          *
--                                                                             *
-- Module Function: This file contains the top level module for the            *
--                  8x8 multiplier                                             *
--                                                                             *
-- REVISION HISTORY:                                                           *
--******************************************************************************

-- Insert library and use clauses
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;



-- begin entity declaration for top-level "mult8x8"
entity mult8x8 is
    -- begin port declaration
    port (
        -- declare control inputs "clk", "start" and "reset_a"
        clk, start, reset_a : in std_logic;
        
        -- declare data inputs "dataa" and "datab"
        dataa, datab : in unsigned(7 downto 0);

        -- declare multiplier output "product8x8_out"
        product8x8_out : out unsigned(15 downto 0);
        
        -- declare seven segment display outputs
        seg_a, seg_b, seg_c, seg_d, seg_e, seg_f, seg_g, done_flag : out std_logic
    );
-- end entity
end entity mult8x8;

--  begin architecture 
architecture logic of mult8x8 is


    -- declare internal signals to use as wires to connect blocks
    -- used these signals to connect up all the components
    -- you should not need anymore signals
    
    signal aout, bout : unsigned(3 downto 0);
    signal product : unsigned(7 downto 0);
    signal shift_out, sum, product8x8 : unsigned(15 downto 0);
    signal count, shift : unsigned(1 downto 0);
    signal state_out : unsigned(2 downto 0);
    signal clk_ena, sclr_n, start_n : std_logic;
    signal sel : unsigned(1 downto 0);



begin
    -- start signal requires inversion before connecting to counter
    start_n <= not start;

    -- connect blocks per schematic in the lab manual
    -- this port map is completed
    u1: entity work.mux4 port map (mux_in_a => dataa(3 downto 0), 
                       mux_in_b => dataa(7 downto 4), 
                       mux_sel => sel(1),
                       mux_out => aout);

                       
    u2: entity work.mux4 port map (
--- ##################### ----
--- complete the port map ----
--- your logic here       ----
--- ##################### ----
			mux_in_a => datab(3 downto 0),
			mux_in_b => datab(7 downto 4),
			mux_sel => sel(0),
			mux_out => bout
);

    u3: entity work.mult4x4 port map (
--- ##################### ----
--- complete the port map ----
--- your logic here       ----
--- ##################### ----
			dataa => aout,
			datab => bout,
			product => product
);

    u4: entity work.shifter port map (
--- ##################### ----
--- complete the port map ----
--- your logic here       ----
--- ##################### ----
			input => product,
			shift_cntrl => shift,
			shift_out => shift_out
);

    u5: entity work.counter port map (
--- ##################### ----
--- complete the port map ----
--- your logic here       ----
--- ##################### ----
			clk => clk,
			aclr_n => not start,
			count_out => count
);

    u6: entity work.mult_control port map (
--- ##################### ----
--- complete the port map ----
--- your logic here       ----
--- ##################### ----
			clk => clk,
			reset_a => reset_a,
			start => start,
			count => count,
			
			input_sel => sel,
			shift_sel => shift,
			state_out => state_out,
			done => done_flag,
			clk_ena => clk_ena,
			sclr_n => sclr_n
);

    u7: entity work.reg16 port map (
--- ##################### ----
--- complete the port map ----
--- your logic here       ----
--- ##################### ----
			clk => clk,
			sclr_n => sclr_n,
			clk_ena => clk_ena,
			datain => sum,
			
			reg_out => product8x8
);

    u8: entity work.adder port map (
--- ##################### ----
--- complete the port map ----
--- your logic here       ----
--- ##################### ----
			dataa => shift_out,
			datab => product8x8,
			
			sum => sum
);

    u9: entity work.seven_segment_cntrl port map (
--- ##################### ----
--- complete the port map ----
--- your logic here       ----
--- ##################### ----
			input => state_out,
			
			seg_a => seg_a,
			seg_b => seg_b,
			seg_c => seg_c,
			seg_d => seg_d,
			seg_e => seg_e,
			seg_f => seg_f,
			seg_g => seg_g
);
                            
    product8x8_out <= product8x8;

-- end architecture
end architecture logic;