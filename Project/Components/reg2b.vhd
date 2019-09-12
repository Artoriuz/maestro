library ieee;
use ieee.std_logic_1164.all;

entity reg2b is
	port (
		reg_in : in std_logic_vector(1 downto 0);
		load, clock, clear : in std_logic;
		reg_out : out std_logic_vector(1 downto 0)
	);
end reg2b;

architecture description of reg2b is
	signal internal_value : std_logic_vector(1 downto 0) := "00";
begin
	process (clock, clear, load, internal_value)
	begin
		if (clear = '1') then
			internal_value <= "00";
		elsif rising_edge(clock) then
			if (load = '1') then
				internal_value <= reg_in;
			else
				internal_value <= internal_value;
			end if;
		end if;
		reg_out <= internal_value;
	end process;
end description;