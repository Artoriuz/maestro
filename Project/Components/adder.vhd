library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder is
	port (
		input_0 : in std_logic_vector(31 downto 0);
		input_1 : in std_logic_vector(31 downto 0);
		output_0 : out std_logic_vector(31 downto 0)
	);
end adder;

architecture behavioral of adder is
	signal internal_output : std_logic_vector (32 downto 0) := "000000000000000000000000000000000";
begin
	process (input_0, input_1, internal_output) is
	begin
		internal_output <= std_logic_vector(signed(input_0(31) & input_0) + signed(input_1(31) & input_1));
	end process;

	output_0 <= internal_output(31 downto 0);

end behavioral;