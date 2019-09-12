library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
	port (
		input_0, input_1 : in std_logic_vector(31 downto 0);
		operation : in std_logic_vector(3 downto 0);
		branch : in std_logic;
		ALU_branch_control : in std_logic_vector(2 downto 0);
		ALU_branch_response : out std_logic;
		ALU_output : out std_logic_vector(31 downto 0)
	);
end entity ALU;

architecture Behavioral of ALU is

	signal result_temp : std_logic_vector(32 downto 0) := "000000000000000000000000000000000";

begin
	process (input_0, input_1, operation, result_temp, branch, ALU_branch_control) is
	begin
		result_temp <= "000000000000000000000000000000000";
		if (branch = '1') then
			case ALU_branch_control is
				when "000" => --BEQ (branch if equal)
					result_temp <= std_logic_vector(signed(input_0(31) & input_0) - signed(input_1(31) & input_1));
					if (result_temp = "000000000000000000000000000000000") then
						ALU_branch_response <= '1';
					else
						ALU_branch_response <= '0';
					end if;

				when "001" => --BNE (branch not equal)
					result_temp <= std_logic_vector(signed(input_0(31) & input_0) - signed(input_1(31) & input_1));
					if (result_temp = "000000000000000000000000000000000") then
						ALU_branch_response <= '0';
					else
						ALU_branch_response <= '1';
					end if;

				when "100" => --BLT (branch less than)
					result_temp <= std_logic_vector(signed(input_0(31) & input_0) - signed(input_1(31) & input_1));
					if (result_temp(32) = '1') then
						ALU_branch_response <= '1';
					else
						ALU_branch_response <= '0';
					end if;

				when "101" => --BGE (branch greater than equal)
					result_temp <= std_logic_vector(signed(input_0(31) & input_0) - signed(input_1(31) & input_1));
					if (result_temp(32) = '0') then
						ALU_branch_response <= '1';
					else
						ALU_branch_response <= '0';
					end if;

				when "110" => --BLTU (branch less than unsigned)
					result_temp <= std_logic_vector(unsigned('0' & input_0) - unsigned('0' & input_1));
					if (result_temp(32) = '1') then
						ALU_branch_response <= '1';
					else
						ALU_branch_response <= '0';
					end if;

				when "111" => --BGEU (branch greater than equal unsigned)
					result_temp <= std_logic_vector(unsigned('0' & input_0) - unsigned('0' & input_1));
					if (result_temp(32) = '0') then
						ALU_branch_response <= '1';
					else
						ALU_branch_response <= '0';
					end if;

				when others =>
					ALU_branch_response <= '0';
			end case;
		else
			ALU_branch_response <= '0';
			case operation is
				when "0000" => -- ALU_output = input_0 + input_1
					result_temp <= std_logic_vector(signed(input_0(31) & input_0) + signed(input_1(31) & input_1));
					ALU_output <= result_temp(31 downto 0);

				when "1000" => -- ALU_output = input_0 - input_1
					result_temp <= std_logic_vector(signed(input_0(31) & input_0) - signed(input_1(31) & input_1));
					ALU_output <= result_temp(31 downto 0);

				when "0001" => -- shift left logical
					ALU_output <= std_logic_vector(shift_left(unsigned(input_0), to_integer(unsigned(input_1))));

				when "0010" => -- set less than (signed)
					result_temp <= std_logic_vector(signed(input_0(31) & input_0) - signed(input_1(31) & input_1));
					if (result_temp(32) = '1') then
						ALU_output <= X"00000001";
					else
						ALU_output <= X"00000000";
					end if;

				when "0011" => -- set less than unsigned
					result_temp <= std_logic_vector(unsigned('0' & input_0) - unsigned('0' & input_1));
					if (result_temp(32) = '1') then
						ALU_output <= X"00000001";
					else
						ALU_output <= X"00000000";
					end if;

				when "0100" => -- xor port 
					ALU_output <= input_0 xor input_1;

				when "0101" => -- shift right logical
					ALU_output <= std_logic_vector(shift_right(unsigned(input_0), to_integer(unsigned(input_1))));

				when "1101" => --shift right arithmetic
					ALU_output <= std_logic_vector(shift_right(signed(input_0), to_integer(unsigned(input_1))));

				when "0110" => -- or port 
					ALU_output <= input_0 or input_1;

				when "0111" => -- and port 
					ALU_output <= input_0 and input_1;

				when others => --apenas zera tudo
					result_temp(32 downto 0) <= "000000000000000000000000000000000";
					ALU_output <= result_temp(31 downto 0);
			end case;
		end if;

	end process;
end architecture Behavioral;