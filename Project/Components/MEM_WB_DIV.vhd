library IEEE;
use IEEE.STD_LOGIC_1164.all;
use work.all;

entity MEM_WB_DIV is
	port (
		--INPUTS

		clock, clear : in std_logic;

		--WB control signals
		mux0_sel_in : in std_logic_vector(1 downto 0);
		reg_file_write_in : in std_logic;
		reg_file_write_address_in : in std_logic_vector(4 downto 0);

		--Data
		ALU_output_in : in std_logic_vector(31 downto 0);
		datamem_output_in : in std_logic_vector(31 downto 0);
		instruction_address_in : in std_logic_vector(31 downto 0);

		--OUTPUTS

		--WB control signals
		mux0_sel_out : out std_logic_vector(1 downto 0);
		reg_file_write_out : out std_logic;
		reg_file_write_address_out : out std_logic_vector(4 downto 0);

		--Data
		ALU_output_out : out std_logic_vector(31 downto 0);
		datamem_output_out : out std_logic_vector(31 downto 0);
		instruction_address_out : out std_logic_vector(31 downto 0)

	);
end MEM_WB_DIV;

architecture behavioral of MEM_WB_DIV is

	--INTERNAL SIGNALS

	--WB control signals
	signal mux0_sel_input_signal : std_logic_vector(1 downto 0);
	signal reg_file_write_input_signal : std_logic;
	signal reg_file_write_address_input_signal : std_logic_vector(4 downto 0);

	--Data
	signal ALU_output_input_signal : std_logic_vector(31 downto 0);
	signal datamem_output_input_signal : std_logic_vector(31 downto 0);
	signal instruction_address_input_signal : std_logic_vector(31 downto 0);

	--WB control signals
	signal mux0_sel_output_signal : std_logic_vector(1 downto 0);
	signal reg_file_write_output_signal : std_logic;
	signal reg_file_write_address_output_signal : std_logic_vector(4 downto 0);

	--Data
	signal ALU_output_output_signal : std_logic_vector(31 downto 0);
	signal datamem_output_output_signal : std_logic_vector(31 downto 0);
	signal instruction_address_output_signal : std_logic_vector(31 downto 0);

begin

	--INTERNAL REGISTERS

	--WB control signals
	mux0_sel_reg : reg2b port map(mux0_sel_input_signal, '1', clock, clear, mux0_sel_output_signal);
	reg_file_write_reg : reg1b port map(reg_file_write_input_signal, '1', clock, clear, reg_file_write_output_signal);
	reg_file_write_address_reg : reg5b port map(reg_file_write_address_input_signal, '1', clock, clear, reg_file_write_address_output_signal);

	--Data
	ALU_output_reg : reg32b port map(ALU_output_input_signal, '1', clock, clear, ALU_output_output_signal);
	datamem_output_reg : reg32b port map(datamem_output_input_signal, '1', clock, clear, datamem_output_output_signal);
	instruction_address_reg : reg32b port map(instruction_address_input_signal, '1', clock, clear, instruction_address_output_signal);

	--WIRING INPUT PORTS

	--WB control signals
	mux0_sel_input_signal <= mux0_sel_in;
	reg_file_write_input_signal <= reg_file_write_in;
	reg_file_write_address_input_signal <= reg_file_write_address_in;

	--Data
	ALU_output_input_signal <= ALU_output_in;
	datamem_output_input_signal <= datamem_output_in;
	instruction_address_input_signal <= instruction_address_in;

	--WIRING OUTPUT PORTS

	--WB control signals
	mux0_sel_out <= mux0_sel_output_signal;
	reg_file_write_out <= reg_file_write_output_signal;
	reg_file_write_address_out <= reg_file_write_address_output_signal;

	--Data
	ALU_output_out <= ALU_output_output_signal;
	datamem_output_out <= datamem_output_output_signal;
	instruction_address_out <= instruction_address_output_signal;

end behavioral;