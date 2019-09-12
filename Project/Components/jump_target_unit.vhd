library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity jump_target_unit is
	port (
		mux_sel : in std_logic;
		current_instruction_address : in std_logic_vector(31 downto 0);
		regfile_address : in std_logic_vector(31 downto 0);
		immediate : in std_logic_vector(31 downto 0);
		target_address : out std_logic_vector(31 downto 0)
	);
end jump_target_unit;

architecture behavioral of jump_target_unit is
	signal mux_output : std_logic_vector (31 downto 0) := X"00000000";
begin
	internal_mux : mux_2_1 port map(mux_sel, current_instruction_address, regfile_address, mux_output);
	internal_adder : adder port map(mux_output, immediate, target_address);
end behavioral;