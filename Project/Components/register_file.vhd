library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity register_file is
	port (
		write_data : in std_logic_vector(31 downto 0);
		write_address : in std_logic_vector(4 downto 0);
		read_address_0 : in std_logic_vector(4 downto 0);
		read_address_1 : in std_logic_vector(4 downto 0);
		write_control, clock, clear : in std_logic;
		output_data_0 : out std_logic_vector(31 downto 0);
		output_data_1 : out std_logic_vector(31 downto 0);
		debug_x31_output : out std_logic_vector(31 downto 0);
		debug_x1_output : out std_logic_vector(31 downto 0);
		debug_x2_output : out std_logic_vector(31 downto 0)
	);
end entity register_file;

architecture Behavioral of register_file is

	signal internal_reg_load : std_logic_vector(31 downto 0) := X"00000000";

	signal x0_to_muxes : std_logic_vector(31 downto 0);
	signal x1_to_muxes : std_logic_vector(31 downto 0);
	signal x2_to_muxes : std_logic_vector(31 downto 0);
	signal x3_to_muxes : std_logic_vector(31 downto 0);
	signal x4_to_muxes : std_logic_vector(31 downto 0);
	signal x5_to_muxes : std_logic_vector(31 downto 0);
	signal x6_to_muxes : std_logic_vector(31 downto 0);
	signal x7_to_muxes : std_logic_vector(31 downto 0);
	signal x8_to_muxes : std_logic_vector(31 downto 0);
	signal x9_to_muxes : std_logic_vector(31 downto 0);
	signal x10_to_muxes : std_logic_vector(31 downto 0);
	signal x11_to_muxes : std_logic_vector(31 downto 0);
	signal x12_to_muxes : std_logic_vector(31 downto 0);
	signal x13_to_muxes : std_logic_vector(31 downto 0);
	signal x14_to_muxes : std_logic_vector(31 downto 0);
	signal x15_to_muxes : std_logic_vector(31 downto 0);
	signal x16_to_muxes : std_logic_vector(31 downto 0);
	signal x17_to_muxes : std_logic_vector(31 downto 0);
	signal x18_to_muxes : std_logic_vector(31 downto 0);
	signal x19_to_muxes : std_logic_vector(31 downto 0);
	signal x20_to_muxes : std_logic_vector(31 downto 0);
	signal x21_to_muxes : std_logic_vector(31 downto 0);
	signal x22_to_muxes : std_logic_vector(31 downto 0);
	signal x23_to_muxes : std_logic_vector(31 downto 0);
	signal x24_to_muxes : std_logic_vector(31 downto 0);
	signal x25_to_muxes : std_logic_vector(31 downto 0);
	signal x26_to_muxes : std_logic_vector(31 downto 0);
	signal x27_to_muxes : std_logic_vector(31 downto 0);
	signal x28_to_muxes : std_logic_vector(31 downto 0);
	signal x29_to_muxes : std_logic_vector(31 downto 0);
	signal x30_to_muxes : std_logic_vector(31 downto 0);
	signal x31_to_muxes : std_logic_vector(31 downto 0);

begin
	register_load_decouple : process (write_address)
	begin
		if (write_control = '1') then
			case write_address is
				when "00000" =>
					internal_reg_load(31 downto 0) <= "00000000000000000000000000000001";
				when "00001" =>
					internal_reg_load(31 downto 0) <= "00000000000000000000000000000010";
				when "00010" =>
					internal_reg_load(31 downto 0) <= "00000000000000000000000000000100";
				when "00011" =>
					internal_reg_load(31 downto 0) <= "00000000000000000000000000001000";
				when "00100" =>
					internal_reg_load(31 downto 0) <= "00000000000000000000000000010000";
				when "00101" =>
					internal_reg_load(31 downto 0) <= "00000000000000000000000000100000";
				when "00110" =>
					internal_reg_load(31 downto 0) <= "00000000000000000000000001000000";
				when "00111" =>
					internal_reg_load(31 downto 0) <= "00000000000000000000000010000000";
				when "01000" =>
					internal_reg_load(31 downto 0) <= "00000000000000000000000100000000";
				when "01001" =>
					internal_reg_load(31 downto 0) <= "00000000000000000000001000000000";
				when "01010" =>
					internal_reg_load(31 downto 0) <= "00000000000000000000010000000000";
				when "01011" =>
					internal_reg_load(31 downto 0) <= "00000000000000000000100000000000";
				when "01100" =>
					internal_reg_load(31 downto 0) <= "00000000000000000001000000000000";
				when "01101" =>
					internal_reg_load(31 downto 0) <= "00000000000000000010000000000000";
				when "01110" =>
					internal_reg_load(31 downto 0) <= "00000000000000000100000000000000";
				when "01111" =>
					internal_reg_load(31 downto 0) <= "00000000000000001000000000000000";
				when "10000" =>
					internal_reg_load(31 downto 0) <= "00000000000000010000000000000000";
				when "10001" =>
					internal_reg_load(31 downto 0) <= "00000000000000100000000000000000";
				when "10010" =>
					internal_reg_load(31 downto 0) <= "00000000000001000000000000000000";
				when "10011" =>
					internal_reg_load(31 downto 0) <= "00000000000010000000000000000000";
				when "10100" =>
					internal_reg_load(31 downto 0) <= "00000000000100000000000000000000";
				when "10101" =>
					internal_reg_load(31 downto 0) <= "00000000001000000000000000000000";
				when "10110" =>
					internal_reg_load(31 downto 0) <= "00000000010000000000000000000000";
				when "10111" =>
					internal_reg_load(31 downto 0) <= "00000000100000000000000000000000";
				when "11000" =>
					internal_reg_load(31 downto 0) <= "00000001000000000000000000000000";
				when "11001" =>
					internal_reg_load(31 downto 0) <= "00000010000000000000000000000000";
				when "11010" =>
					internal_reg_load(31 downto 0) <= "00000100000000000000000000000000";
				when "11011" =>
					internal_reg_load(31 downto 0) <= "00001000000000000000000000000000";
				when "11100" =>
					internal_reg_load(31 downto 0) <= "00010000000000000000000000000000";
				when "11101" =>
					internal_reg_load(31 downto 0) <= "00100000000000000000000000000000";
				when "11110" =>
					internal_reg_load(31 downto 0) <= "01000000000000000000000000000000";
				when "11111" =>
					internal_reg_load(31 downto 0) <= "10000000000000000000000000000000";
			end case;
		else
			internal_reg_load(31 downto 0) <= "00000000000000000000000000000000";
		end if;
	end process;

	reg_x0 : reg32b_falling_edge port map(X"00000000", '1', clock, clear, x0_to_muxes);
	reg_x1 : reg32b_falling_edge port map(write_data, internal_reg_load(1), clock, clear, x1_to_muxes);
	reg_x2 : reg32b_falling_edge port map(write_data, internal_reg_load(2), clock, clear, x2_to_muxes);
	reg_x3 : reg32b_falling_edge port map(write_data, internal_reg_load(3), clock, clear, x3_to_muxes);
	reg_x4 : reg32b_falling_edge port map(write_data, internal_reg_load(4), clock, clear, x4_to_muxes);
	reg_x5 : reg32b_falling_edge port map(write_data, internal_reg_load(5), clock, clear, x5_to_muxes);
	reg_x6 : reg32b_falling_edge port map(write_data, internal_reg_load(6), clock, clear, x6_to_muxes);
	reg_x7 : reg32b_falling_edge port map(write_data, internal_reg_load(7), clock, clear, x7_to_muxes);
	reg_x8 : reg32b_falling_edge port map(write_data, internal_reg_load(8), clock, clear, x8_to_muxes);
	reg_x9 : reg32b_falling_edge port map(write_data, internal_reg_load(9), clock, clear, x9_to_muxes);
	reg_x10 : reg32b_falling_edge port map(write_data, internal_reg_load(10), clock, clear, x10_to_muxes);
	reg_x11 : reg32b_falling_edge port map(write_data, internal_reg_load(11), clock, clear, x11_to_muxes);
	reg_x12 : reg32b_falling_edge port map(write_data, internal_reg_load(12), clock, clear, x12_to_muxes);
	reg_x13 : reg32b_falling_edge port map(write_data, internal_reg_load(13), clock, clear, x13_to_muxes);
	reg_x14 : reg32b_falling_edge port map(write_data, internal_reg_load(14), clock, clear, x14_to_muxes);
	reg_x15 : reg32b_falling_edge port map(write_data, internal_reg_load(15), clock, clear, x15_to_muxes);
	reg_x16 : reg32b_falling_edge port map(write_data, internal_reg_load(16), clock, clear, x16_to_muxes);
	reg_x17 : reg32b_falling_edge port map(write_data, internal_reg_load(17), clock, clear, x17_to_muxes);
	reg_x18 : reg32b_falling_edge port map(write_data, internal_reg_load(18), clock, clear, x18_to_muxes);
	reg_x19 : reg32b_falling_edge port map(write_data, internal_reg_load(19), clock, clear, x19_to_muxes);
	reg_x20 : reg32b_falling_edge port map(write_data, internal_reg_load(20), clock, clear, x20_to_muxes);
	reg_x21 : reg32b_falling_edge port map(write_data, internal_reg_load(21), clock, clear, x21_to_muxes);
	reg_x22 : reg32b_falling_edge port map(write_data, internal_reg_load(22), clock, clear, x22_to_muxes);
	reg_x23 : reg32b_falling_edge port map(write_data, internal_reg_load(23), clock, clear, x23_to_muxes);
	reg_x24 : reg32b_falling_edge port map(write_data, internal_reg_load(24), clock, clear, x24_to_muxes);
	reg_x25 : reg32b_falling_edge port map(write_data, internal_reg_load(25), clock, clear, x25_to_muxes);
	reg_x26 : reg32b_falling_edge port map(write_data, internal_reg_load(26), clock, clear, x26_to_muxes);
	reg_x27 : reg32b_falling_edge port map(write_data, internal_reg_load(27), clock, clear, x27_to_muxes);
	reg_x28 : reg32b_falling_edge port map(write_data, internal_reg_load(28), clock, clear, x28_to_muxes);
	reg_x29 : reg32b_falling_edge port map(write_data, internal_reg_load(29), clock, clear, x29_to_muxes);
	reg_x30 : reg32b_falling_edge port map(write_data, internal_reg_load(30), clock, clear, x30_to_muxes);
	reg_x31 : reg32b_falling_edge port map(write_data, internal_reg_load(31), clock, clear, x31_to_muxes);

	output_1_mux : mux_32_1 port map(
		read_address_0, x0_to_muxes, x1_to_muxes, x2_to_muxes, x3_to_muxes, x4_to_muxes, x5_to_muxes, x6_to_muxes, x7_to_muxes,
		x8_to_muxes, x9_to_muxes, x10_to_muxes, x11_to_muxes, x12_to_muxes, x13_to_muxes, x14_to_muxes, x15_to_muxes, x16_to_muxes,
		x17_to_muxes, x18_to_muxes, x19_to_muxes, x20_to_muxes, x21_to_muxes, x22_to_muxes, x23_to_muxes, x24_to_muxes, x25_to_muxes,
		x26_to_muxes, x27_to_muxes, x28_to_muxes, x29_to_muxes, x30_to_muxes, x31_to_muxes, output_data_0);

	output_2_mux : mux_32_1 port map(
		read_address_1, x0_to_muxes, x1_to_muxes, x2_to_muxes, x3_to_muxes, x4_to_muxes, x5_to_muxes, x6_to_muxes, x7_to_muxes,
		x8_to_muxes, x9_to_muxes, x10_to_muxes, x11_to_muxes, x12_to_muxes, x13_to_muxes, x14_to_muxes, x15_to_muxes, x16_to_muxes,
		x17_to_muxes, x18_to_muxes, x19_to_muxes, x20_to_muxes, x21_to_muxes, x22_to_muxes, x23_to_muxes, x24_to_muxes, x25_to_muxes,
		x26_to_muxes, x27_to_muxes, x28_to_muxes, x29_to_muxes, x30_to_muxes, x31_to_muxes, output_data_1);

	debug_x31_output <= x31_to_muxes;
	debug_x1_output <= x1_to_muxes;
	debug_x2_output <= x2_to_muxes;
end architecture Behavioral;