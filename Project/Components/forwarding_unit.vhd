library IEEE;
use IEEE.STD_LOGIC_1164.all;
use work.all;

entity forwarding_unit is
	port (
		reg_file_read_address_0_ID_EXE : in std_logic_vector(4 downto 0);
		reg_file_read_address_1_ID_EXE : in std_logic_vector(4 downto 0);

		reg_file_write_EX_MEM : in std_logic;
		reg_file_write_address_EX_MEM : in std_logic_vector(4 downto 0);
		mux_0_sel_EX_MEM : in std_logic_vector(1 downto 0);

		reg_file_write_MEM_WB : in std_logic;
		reg_file_write_address_MEM_WB : in std_logic_vector(4 downto 0);
		mux_0_sel_MEM_WB : in std_logic_vector(1 downto 0);

		forward_mux_0_control : out std_logic_vector(2 downto 0);
		forward_mux_1_control : out std_logic_vector(2 downto 0)
	);
end forwarding_unit;

architecture structural of forwarding_unit is

	signal internal_mux_0_control : std_logic_vector(2 downto 0) := "000";
	signal internal_mux_1_control : std_logic_vector(2 downto 0) := "000";

begin

	forward_0 : process (reg_file_read_address_0_ID_EXE, reg_file_write_EX_MEM, reg_file_write_MEM_WB, reg_file_write_address_EX_MEM, reg_file_write_address_MEM_WB, mux_0_sel_EX_MEM, mux_0_sel_MEM_WB)
	begin
		if (mux_0_sel_EX_MEM = "00") and (reg_file_write_EX_MEM = '1') and (reg_file_read_address_0_ID_EXE = reg_file_write_address_EX_MEM) and (reg_file_read_address_0_ID_EXE /= "00000") then
			internal_mux_0_control <= "001";

		elsif (mux_0_sel_EX_MEM = "01") and (reg_file_write_EX_MEM = '1') and (reg_file_read_address_0_ID_EXE = reg_file_write_address_EX_MEM) and (reg_file_read_address_0_ID_EXE /= "00000") then
			internal_mux_0_control <= "010";

		elsif (mux_0_sel_MEM_WB = "00") and (reg_file_write_MEM_WB = '1') and (reg_file_read_address_0_ID_EXE = reg_file_write_address_MEM_WB) and (reg_file_read_address_0_ID_EXE /= "00000") then
			internal_mux_0_control <= "011";

		elsif (mux_0_sel_MEM_WB = "01") and (reg_file_write_MEM_WB = '1') and (reg_file_read_address_0_ID_EXE = reg_file_write_address_MEM_WB) and (reg_file_read_address_0_ID_EXE /= "00000") then
			internal_mux_0_control <= "100";

		else
			internal_mux_0_control <= "000";

		end if;
	end process;

	forward_1 : process (reg_file_read_address_1_ID_EXE, reg_file_write_EX_MEM, reg_file_write_MEM_WB, reg_file_write_address_EX_MEM, reg_file_write_address_MEM_WB, mux_0_sel_EX_MEM, mux_0_sel_MEM_WB)
	begin
		if (mux_0_sel_EX_MEM = "00") and (reg_file_write_EX_MEM = '1') and (reg_file_read_address_1_ID_EXE = reg_file_write_address_EX_MEM) and (reg_file_read_address_1_ID_EXE /= "00000") then
			internal_mux_1_control <= "001";

		elsif (mux_0_sel_EX_MEM = "01") and (reg_file_write_EX_MEM = '1') and (reg_file_read_address_1_ID_EXE = reg_file_write_address_EX_MEM) and (reg_file_read_address_1_ID_EXE /= "00000") then
			internal_mux_1_control <= "010";

		elsif (mux_0_sel_MEM_WB = "00") and (reg_file_write_MEM_WB = '1') and (reg_file_read_address_1_ID_EXE = reg_file_write_address_MEM_WB) and (reg_file_read_address_1_ID_EXE /= "00000") then
			internal_mux_1_control <= "011";

		elsif (mux_0_sel_MEM_WB = "01") and (reg_file_write_MEM_WB = '1') and (reg_file_read_address_1_ID_EXE = reg_file_write_address_MEM_WB) and (reg_file_read_address_1_ID_EXE /= "00000") then
			internal_mux_1_control <= "100";

		else
			internal_mux_1_control <= "000";

		end if;
	end process;

	forward_mux_0_control <= internal_mux_0_control;
	forward_mux_1_control <= internal_mux_1_control;

end architecture structural;