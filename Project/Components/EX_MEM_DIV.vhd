library IEEE;
use IEEE.STD_LOGIC_1164.all;
use work.all;

entity EX_MEM_DIV is
	port (
		--INPUTS

		clock, clear : in std_logic;

		--MEM control signals
		data_format_in : in std_logic_vector(2 downto 0);
		datamem_write_in : in std_logic;
		jump_flag_in : in std_logic;

		--WB control signals
		mux0_sel_in : in std_logic_vector(1 downto 0);
		reg_file_write_in : in std_logic;
		reg_file_write_address_in : in std_logic_vector(4 downto 0);

		--Data
		ALU_output_in : in std_logic_vector(31 downto 0);
		register_file_output_1_in : in std_logic_vector(31 downto 0);
		ALU_branch_response_in : in std_logic;
		instruction_address_in : in std_logic_vector(31 downto 0);

		--OUTPUTS

		--MEM control signals
		data_format_out : out std_logic_vector(2 downto 0);
		datamem_write_out : out std_logic;
		jump_flag_out : out std_logic;

		--WB control signals
		mux0_sel_out : out std_logic_vector(1 downto 0);
		reg_file_write_out : out std_logic;
		reg_file_write_address_out : out std_logic_vector(4 downto 0);

		--Data
		ALU_output_out : out std_logic_vector(31 downto 0);
		register_file_output_1_out : out std_logic_vector(31 downto 0);
		ALU_branch_response_out : out std_logic;
		instruction_address_out : out std_logic_vector(31 downto 0)

	);
end EX_MEM_DIV;

architecture behavioral of EX_MEM_DIV is

	--INTERNAL SIGNALS

	--MEM control signals
	signal data_format_input_signal : std_logic_vector(2 downto 0);
	signal datamem_write_input_signal : std_logic;
	signal jump_flag_input_signal : std_logic;

	--WB control signals
	signal mux0_sel_input_signal : std_logic_vector(1 downto 0);
	signal reg_file_write_input_signal : std_logic;
	signal reg_file_write_address_input_signal : std_logic_vector(4 downto 0);

	--Data
	signal ALU_output_input_signal : std_logic_vector(31 downto 0);
	signal register_file_output_1_input_signal : std_logic_vector(31 downto 0);
	signal ALU_branch_response_input_signal : std_logic;
	signal instruction_address_input_signal : std_logic_vector(31 downto 0);

	--MEM control signals
	signal data_format_output_signal : std_logic_vector(2 downto 0);
	signal datamem_write_output_signal : std_logic;
	signal jump_flag_output_signal : std_logic;

	--WB control signals
	signal mux0_sel_output_signal : std_logic_vector(1 downto 0);
	signal reg_file_write_output_signal : std_logic;
	signal reg_file_write_address_output_signal : std_logic_vector(4 downto 0);

	--Data
	signal ALU_output_output_signal : std_logic_vector(31 downto 0);
	signal register_file_output_1_output_signal : std_logic_vector(31 downto 0);
	signal ALU_branch_response_output_signal : std_logic;
	signal instruction_address_output_signal : std_logic_vector(31 downto 0);

begin

	--INTERNAL REGISTERS

	--MEM control signals
	data_format_reg : reg3b port map(data_format_input_signal, '1', clock, clear, data_format_output_signal);
	datamem_write_reg : reg1b port map(datamem_write_input_signal, '1', clock, clear, datamem_write_output_signal);
	jump_flag_reg : reg1b port map(jump_flag_input_signal, '1', clock, clear, jump_flag_output_signal);

	--WB control signals
	mux0_sel_reg : reg2b port map(mux0_sel_input_signal, '1', clock, clear, mux0_sel_output_signal);
	reg_file_write_reg : reg1b port map(reg_file_write_input_signal, '1', clock, clear, reg_file_write_output_signal);
	reg_file_write_address_reg : reg5b port map(reg_file_write_address_input_signal, '1', clock, clear, reg_file_write_address_output_signal);

	--Data
	ALU_output_reg : reg32b port map(ALU_output_input_signal, '1', clock, clear, ALU_output_output_signal);
	register_file_output_1_reg : reg32b port map(register_file_output_1_input_signal, '1', clock, clear, register_file_output_1_output_signal);
	ALU_branch_respose_reg : reg1b port map(ALU_branch_response_input_signal, '1', clock, clear, ALU_branch_response_output_signal);
	instruction_address_reg : reg32b port map(instruction_address_input_signal, '1', clock, clear, instruction_address_output_signal);

	--WIRING INPUT PORTS

	--MEM control signals
	data_format_input_signal <= data_format_in;
	datamem_write_input_signal <= datamem_write_in;
	jump_flag_input_signal <= jump_flag_in;

	--WB control signals
	mux0_sel_input_signal <= mux0_sel_in;
	reg_file_write_input_signal <= reg_file_write_in;
	reg_file_write_address_input_signal <= reg_file_write_address_in;

	--Data
	ALU_output_input_signal <= ALU_output_in;
	register_file_output_1_input_signal <= register_file_output_1_in;
	ALU_branch_response_input_signal <= ALU_branch_response_in;
	instruction_address_input_signal <= instruction_address_in;

	--WIRING OUTPUT PORTS

	--MEM control signals
	data_format_out <= data_format_output_signal;
	datamem_write_out <= datamem_write_output_signal;
	jump_flag_out <= jump_flag_output_signal;

	--WB control signals
	mux0_sel_out <= mux0_sel_output_signal;
	reg_file_write_out <= reg_file_write_output_signal;
	reg_file_write_address_out <= reg_file_write_address_output_signal;

	--Data
	ALU_output_out <= ALU_output_output_signal;
	register_file_output_1_out <= register_file_output_1_output_signal;
	ALU_branch_response_out <= ALU_branch_response_output_signal;
	instruction_address_out <= instruction_address_output_signal;

end behavioral;