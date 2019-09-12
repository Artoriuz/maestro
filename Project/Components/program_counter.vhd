library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity program_counter is
	port (
		clear, clock : in std_logic;
		mux_sel : in std_logic;
		address_in_0 : in std_logic_vector(31 downto 0);
		address_in_1 : in std_logic_vector(31 downto 0);
		next_address : out std_logic_vector(31 downto 0); --THIS OUTPUT IS ONLY REQUIRED WHEN USING REGISTERED INPUT ALTERA MEMORY, SO THE INPUT REG CAN MIRROR THE PC'S INTERNAL REG.
		address_out : out std_logic_vector(31 downto 0) --THIS IS THE REAL PC OUTPUT, USE THIS IF YOUR MEMORY DOES NOT HAVE A REGISTER IN ITS INPUT.
	);
end program_counter;

architecture behavioral of program_counter is
	signal internal_address : std_logic_vector (31 downto 0) := X"00000000";
begin
	internal_mux : mux_2_1 port map(mux_sel, address_in_0, address_in_1, internal_address);
	internal_register : reg32b port map(internal_address, '1', clock, clear, address_out);

	next_address <= internal_address;

end behavioral;