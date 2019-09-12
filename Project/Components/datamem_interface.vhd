library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity datamem_interface is
	port (
		input_data : in std_logic_vector(31 downto 0);
		byte_address : in std_logic_vector(31 downto 0);
		data_format : in std_logic_vector(2 downto 0);
		clock, load, clear : in std_logic;
		output_data : out std_logic_vector(31 downto 0)
	);
end entity datamem_interface;

architecture behavioural of datamem_interface is

	signal internal_load : std_logic_vector(3 downto 0);

	signal memory_input_0 : std_logic_vector(7 downto 0);
	signal memory_input_1 : std_logic_vector(7 downto 0);
	signal memory_input_2 : std_logic_vector(7 downto 0);
	signal memory_input_3 : std_logic_vector(7 downto 0);

	signal memory_output_0 : std_logic_vector(7 downto 0);
	signal memory_output_1 : std_logic_vector(7 downto 0);
	signal memory_output_2 : std_logic_vector(7 downto 0);
	signal memory_output_3 : std_logic_vector(7 downto 0);

	signal membank_address : std_logic_vector(31 downto 0);
	signal byte_starting_position : std_logic_vector(1 downto 0) := "00";

begin
	membank_address_acquirement : process (input_data, byte_address, data_format, load, byte_starting_position, memory_output_0, memory_output_1, memory_output_2, memory_output_3)
	begin
		membank_address <= std_logic_vector(shift_right(unsigned(byte_address), 2)); --Dividing by 4 while throwing away non-integer information
		byte_starting_position <= byte_address(1 downto 0); --Last 2 bits to know which of the 4 memory banks we should access
		if (load = '1') then --writing to memory, data needs to go to the correct place and stay aligned
			case data_format is
				when "000" => --Word operation, don't do anything to the input
					if (byte_starting_position = "00") then
						internal_load <= "1111";
						memory_input_3 <= input_data(31 downto 24);
						memory_input_2 <= input_data(23 downto 16);
						memory_input_1 <= input_data(15 downto 8);
						memory_input_0 <= input_data(7 downto 0);
					else
						internal_load <= "0000";
						memory_input_3 <= X"00";
						memory_input_2 <= X"00";
						memory_input_1 <= X"00";
						memory_input_0 <= X"00";
					end if;

				when "001" => --Signed halfword
					if (byte_starting_position = "00") then
						internal_load <= "0011";
						memory_input_3 <= X"00";
						memory_input_2 <= X"00";
						memory_input_1 <= input_data(15 downto 8);
						memory_input_0 <= input_data(7 downto 0);
					elsif (byte_starting_position = "10") then
						internal_load <= "1100";
						memory_input_3 <= input_data(15 downto 8);
						memory_input_2 <= input_data(7 downto 0);
						memory_input_1 <= X"00";
						memory_input_0 <= X"00";
					else
						internal_load <= "0000";
						memory_input_3 <= X"00";
						memory_input_2 <= X"00";
						memory_input_1 <= X"00";
						memory_input_0 <= X"00";
					end if;

				when "010" => --Unsigned halfword
					if (byte_starting_position = "00") then
						internal_load <= "0011";
						memory_input_3 <= X"00";
						memory_input_2 <= X"00";
						memory_input_1 <= input_data(15 downto 8);
						memory_input_0 <= input_data(7 downto 0);
					elsif (byte_starting_position = "10") then
						internal_load <= "1100";
						memory_input_3 <= input_data(15 downto 8);
						memory_input_2 <= input_data(7 downto 0);
						memory_input_1 <= X"00";
						memory_input_0 <= X"00";
					else
						internal_load <= "0000";
						memory_input_3 <= X"00";
						memory_input_2 <= X"00";
						memory_input_1 <= X"00";
						memory_input_0 <= X"00";
					end if;

				when "011" => --Signed byte
					if (byte_starting_position = "00") then
						internal_load <= "0001";
						memory_input_3 <= X"00";
						memory_input_2 <= X"00";
						memory_input_1 <= X"00";
						memory_input_0 <= input_data(7 downto 0);
					elsif (byte_starting_position = "01") then
						internal_load <= "0010";
						memory_input_3 <= X"00";
						memory_input_2 <= X"00";
						memory_input_1 <= input_data(7 downto 0);
						memory_input_0 <= X"00";
					elsif (byte_starting_position = "10") then
						internal_load <= "0100";
						memory_input_3 <= X"00";
						memory_input_2 <= input_data(7 downto 0);
						memory_input_1 <= X"00";
						memory_input_0 <= X"00";
					elsif (byte_starting_position = "11") then
						internal_load <= "1000";
						memory_input_3 <= input_data(7 downto 0);
						memory_input_2 <= X"00";
						memory_input_1 <= X"00";
						memory_input_0 <= X"00";
						internal_load <= "0000";
					end if;

				when "100" => --Unsigned byte
					if (byte_starting_position = "00") then
						internal_load <= "0001";
						memory_input_3 <= X"00";
						memory_input_2 <= X"00";
						memory_input_1 <= X"00";
						memory_input_0 <= input_data(7 downto 0);
					elsif (byte_starting_position = "01") then
						internal_load <= "0010";
						memory_input_3 <= X"00";
						memory_input_2 <= X"00";
						memory_input_1 <= input_data(7 downto 0);
						memory_input_0 <= X"00";
					elsif (byte_starting_position = "10") then
						internal_load <= "0100";
						memory_input_3 <= X"00";
						memory_input_2 <= input_data(7 downto 0);
						memory_input_1 <= X"00";
						memory_input_0 <= X"00";
					elsif (byte_starting_position = "11") then
						internal_load <= "1000";
						memory_input_3 <= input_data(7 downto 0);
						memory_input_2 <= X"00";
						memory_input_1 <= X"00";
						memory_input_0 <= X"00";
						internal_load <= "0000";
					end if;
				when others =>
					memory_input_3 <= X"00";
					memory_input_2 <= X"00";
					memory_input_1 <= X"00";
					memory_input_0 <= X"00";
					internal_load <= "0000";
			end case;
		else --reading operation, data needs to be formatted to be sent to internal registers in the registerfile 
			internal_load <= "0000";
			case data_format is
				when "000" => --Word operation, don't do anything to the input
					if (byte_starting_position = "00") then
						output_data <= std_logic_vector(memory_output_3 & memory_output_2 & memory_output_1 & memory_output_0);
					else
						output_data <= X"00000000";
					end if;
				when "001" => --Signed halfword, discard upper half and bit-extend
					if (byte_starting_position = "00") then
						output_data <= std_logic_vector(shift_right(signed(std_logic_vector(memory_output_1 & memory_output_0 & X"0000")), 16));
					elsif (byte_starting_position = "10") then
						output_data <= std_logic_vector(shift_right(signed(std_logic_vector(memory_output_3 & memory_output_2 & X"0000")), 16));
					else
						output_data <= X"00000000";
					end if;
				when "010" => --Unsigned halfword, discard upper half then complete the array with 0s
					if (byte_starting_position = "00") then
						output_data <= std_logic_vector(X"0000" & memory_output_1 & memory_output_0);
					elsif (byte_starting_position = "10") then
						output_data <= std_logic_vector(X"0000" & memory_output_3 & memory_output_2);
					else
						output_data <= X"00000000";
					end if;
				when "011" => --Signed byte, discard upper 24 bits and bit-extend
					if (byte_starting_position = "00") then
						output_data <= std_logic_vector(shift_right(signed(std_logic_vector(memory_output_0 & X"000000")), 24));
					elsif (byte_starting_position = "01") then
						output_data <= std_logic_vector(shift_right(signed(std_logic_vector(memory_output_1 & X"000000")), 24));
					elsif (byte_starting_position = "10") then
						output_data <= std_logic_vector(shift_right(signed(std_logic_vector(memory_output_2 & X"000000")), 24));
					elsif (byte_starting_position = "11") then
						output_data <= std_logic_vector(shift_right(signed(std_logic_vector(memory_output_3 & X"000000")), 24));
					end if;
				when "100" => --Unsigned byte, discard upper 24 bits then complete with 0s
					if (byte_starting_position = "00") then
						output_data <= std_logic_vector(X"000000" & memory_output_0);
					elsif (byte_starting_position = "01") then
						output_data <= std_logic_vector(X"000000" & memory_output_1);
					elsif (byte_starting_position = "10") then
						output_data <= std_logic_vector(X"000000" & memory_output_2);
					elsif (byte_starting_position = "11") then
						output_data <= std_logic_vector(X"000000" & memory_output_3);
					end if;
				when others =>
					output_data <= X"00000000";
			end case;
		end if;
	end process;

	--	datamem_3 : datamem port map(membank_address(7 downto 0), clock, memory_input_3, internal_load(3), memory_output_3); --USE THIS FOR ALTERA MEMORY
	--	datamem_2 : datamem port map(membank_address(7 downto 0), clock, memory_input_2, internal_load(2), memory_output_2);
	--	datamem_1 : datamem port map(membank_address(7 downto 0), clock, memory_input_1, internal_load(1), memory_output_1);
	--	datamem_0 : datamem port map(membank_address(7 downto 0), clock, memory_input_0, internal_load(0), memory_output_0);

	--	datamem_3 : datamem port map(clock, clear, internal_load(3), memory_input_3, membank_address(7 downto 0), memory_output_3); --USE THIS FOR A DATAMEM DERIVED FROM MY REGFILE
	--	datamem_2 : datamem port map(clock, clear, internal_load(2), memory_input_2, membank_address(7 downto 0), memory_output_2);
	--	datamem_1 : datamem port map(clock, clear, internal_load(1), memory_input_1, membank_address(7 downto 0), memory_output_1);
	--	datamem_0 : datamem port map(clock, clear, internal_load(0), memory_input_0, membank_address(7 downto 0), memory_output_0);

	datamem_3 : datamem port map(clock, internal_load(3), membank_address(15 downto 0), memory_input_3, memory_output_3);
	datamem_2 : datamem port map(clock, internal_load(2), membank_address(15 downto 0), memory_input_2, memory_output_2);
	datamem_1 : datamem port map(clock, internal_load(1), membank_address(15 downto 0), memory_input_1, memory_output_1);
	datamem_0 : datamem port map(clock, internal_load(0), membank_address(15 downto 0), memory_input_0, memory_output_0);

end architecture behavioural;