library IEEE;
use IEEE.STD_LOGIC_1164.all;
use work.all;

entity flushing_unit is
	port (
		clear, clock : in std_logic;
		flushing_control : in std_logic;
		flushing_output : out std_logic
	);
end flushing_unit;

architecture behavioural of flushing_unit is

	signal internal_flushing_output : std_logic := '0';

begin

	process (clear, clock, flushing_control, internal_flushing_output) is
	begin
		if (clear = '1') then
			internal_flushing_output <= '0';
		elsif (clock = '1' and flushing_control = '1') then
			internal_flushing_output <= '1';
		elsif (clock = '1' and flushing_control = '0') then
			internal_flushing_output <= '0';
		elsif (clock = '0' and flushing_control = '1') then
			internal_flushing_output <= '0';
		elsif (clock = '0' and flushing_control = '0') then
			internal_flushing_output <= '0';
		else
			internal_flushing_output <= internal_flushing_output;
		end if;
	end process;

	flushing_output <= internal_flushing_output;

end architecture behavioural;