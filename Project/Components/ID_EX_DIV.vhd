library IEEE;
use IEEE.STD_LOGIC_1164.all;
use work.all;

entity ID_EX_DIV is
	port (
		--INPUTS

		clock, clear : in std_logic;

		--EX control signals
		ALU_operation_in : in std_logic_vector(3 downto 0);
		ALU_branch_in : in std_logic;
		ALU_branch_control_in : in std_logic_vector(2 downto 0);
		mux1_sel_in : in std_logic;
		JTU_mux_sel_in : in std_logic;

		--MEM control signals
		data_format_in : in std_logic_vector(2 downto 0);
		datamem_write_in : in std_logic;
		jump_flag_in : in std_logic;

		--WB control signals
		mux0_sel_in : in std_logic_vector(1 downto 0);
		reg_file_write_in : in std_logic;
		reg_file_write_address_in : in std_logic_vector(4 downto 0);

		--Read addresses to be given to the forwarding unit
		register_file_read_address_0_in : in std_logic_vector(4 downto 0);
		register_file_read_address_1_in : in std_logic_vector(4 downto 0);

		--Data
		register_file_output_0_in : in std_logic_vector(31 downto 0);
		register_file_output_1_in : in std_logic_vector(31 downto 0);
		immediate_in : in std_logic_vector(31 downto 0);
		instruction_address_in : in std_logic_vector(31 downto 0);

		--OUTPUTS

		--EX control signals
		ALU_operation_out : out std_logic_vector(3 downto 0);
		ALU_branch_out : out std_logic;
		ALU_branch_control_out : out std_logic_vector(2 downto 0);
		mux1_sel_out : out std_logic;
		JTU_mux_sel_out : out std_logic;

		--MEM control signals
		data_format_out : out std_logic_vector(2 downto 0);
		datamem_write_out : out std_logic;
		jump_flag_out : out std_logic;

		--WB control signals
		mux0_sel_out : out std_logic_vector(1 downto 0);
		reg_file_write_out : out std_logic;
		reg_file_write_address_out : out std_logic_vector(4 downto 0);

		--Read addresses to be given to the forwarding unit
		register_file_read_address_0_out : out std_logic_vector(4 downto 0);
		register_file_read_address_1_out : out std_logic_vector(4 downto 0);

		--Data
		register_file_output_0_out : out std_logic_vector(31 downto 0);
		register_file_output_1_out : out std_logic_vector(31 downto 0);
		immediate_out : out std_logic_vector(31 downto 0);
		instruction_address_out : out std_logic_vector(31 downto 0)

	);
end ID_EX_DIV;

architecture behavioral of ID_EX_DIV is

	--INTERNAL SIGNALS

	--EX control signals
	signal ALU_operation_input_signal : std_logic_vector(3 downto 0);
	signal ALU_branch_input_signal : std_logic;
	signal ALU_branch_control_input_signal : std_logic_vector(2 downto 0);
	signal mux1_sel_input_signal : std_logic;
	signal JTU_mux_sel_input_signal : std_logic;

	--MEM control signals
	signal data_format_input_signal : std_logic_vector(2 downto 0);
	signal datamem_write_input_signal : std_logic;
	signal jump_flag_input_signal : std_logic;

	--WB control signals
	signal mux0_sel_input_signal : std_logic_vector(1 downto 0);
	signal reg_file_write_input_signal : std_logic;
	signal reg_file_write_address_input_signal : std_logic_vector(4 downto 0);

	--Data
	signal register_file_output_0_input_signal : std_logic_vector(31 downto 0);
	signal register_file_output_1_input_signal : std_logic_vector(31 downto 0);
	signal immediate_input_signal : std_logic_vector(31 downto 0);
	signal instruction_address_input_signal : std_logic_vector(31 downto 0);

	--Read addresses to be given to the forwarding unit
	signal register_file_read_address_0_input_signal : std_logic_vector(4 downto 0);
	signal register_file_read_address_1_input_signal : std_logic_vector(4 downto 0);

	--EX control signals
	signal ALU_operation_output_signal : std_logic_vector(3 downto 0);
	signal ALU_branch_output_signal : std_logic;
	signal ALU_branch_control_output_signal : std_logic_vector(2 downto 0);
	signal mux1_sel_output_signal : std_logic;
	signal JTU_mux_sel_output_signal : std_logic;

	--MEM control signals
	signal data_format_output_signal : std_logic_vector(2 downto 0);
	signal datamem_write_output_signal : std_logic;
	signal jump_flag_output_signal : std_logic;

	--WB control signals
	signal mux0_sel_output_signal : std_logic_vector(1 downto 0);
	signal reg_file_write_output_signal : std_logic;
	signal reg_file_write_address_output_signal : std_logic_vector(4 downto 0);

	--Data
	signal register_file_output_0_output_signal : std_logic_vector(31 downto 0);
	signal register_file_output_1_output_signal : std_logic_vector(31 downto 0);
	signal immediate_output_signal : std_logic_vector(31 downto 0);
	signal instruction_address_output_signal : std_logic_vector(31 downto 0);

	--Read addresses to be given to the forwarding unit
	signal register_file_read_address_0_output_signal : std_logic_vector(4 downto 0);
	signal register_file_read_address_1_output_signal : std_logic_vector(4 downto 0);

begin

	--INTERNAL REGISTERS

	--EX control signals
	ALU_operation_reg : reg4b port map(ALU_operation_input_signal, '1', clock, clear, ALU_operation_output_signal);
	ALU_branch_reg : reg1b port map(ALU_branch_input_signal, '1', clock, clear, ALU_branch_output_signal);
	ALU_branch_control_reg : reg3b port map(ALU_branch_control_input_signal, '1', clock, clear, ALU_branch_control_output_signal);
	mux1_sel_reg : reg1b port map(mux1_sel_input_signal, '1', clock, clear, mux1_sel_output_signal);
	JTU_mux_sel_reg : reg1b port map(JTU_mux_sel_input_signal, '1', clock, clear, JTU_mux_sel_output_signal);

	--MEM control signals
	data_format_reg : reg3b port map(data_format_input_signal, '1', clock, clear, data_format_output_signal);
	datamem_write_reg : reg1b port map(datamem_write_input_signal, '1', clock, clear, datamem_write_output_signal);
	jump_flag_reg : reg1b port map(jump_flag_input_signal, '1', clock, clear, jump_flag_output_signal);

	--WB control signals
	mux0_sel_reg : reg2b port map(mux0_sel_input_signal, '1', clock, clear, mux0_sel_output_signal);
	reg_file_write_reg : reg1b port map(reg_file_write_input_signal, '1', clock, clear, reg_file_write_output_signal);
	reg_file_write_address_reg : reg5b port map(reg_file_write_address_input_signal, '1', clock, clear, reg_file_write_address_output_signal);

	--Data
	register_file_output_0_reg : reg32b port map(register_file_output_0_input_signal, '1', clock, clear, register_file_output_0_output_signal);
	register_file_output_1_reg : reg32b port map(register_file_output_1_input_signal, '1', clock, clear, register_file_output_1_output_signal);
	immediate_reg : reg32b port map(immediate_input_signal, '1', clock, clear, immediate_output_signal);
	instruction_address_reg : reg32b port map(instruction_address_input_signal, '1', clock, clear, instruction_address_output_signal);

	--Read addresses to be given to the forwarding unit
	register_file_read_address_0_reg : reg5b port map(register_file_read_address_0_input_signal, '1', clock, clear, register_file_read_address_0_output_signal);
	register_file_read_address_1_reg : reg5b port map(register_file_read_address_1_input_signal, '1', clock, clear, register_file_read_address_1_output_signal);

	--WIRING INPUT PORTS

	--EX control signals
	ALU_operation_input_signal <= ALU_operation_in;
	ALU_branch_input_signal <= ALU_branch_in;
	ALU_branch_control_input_signal <= ALU_branch_control_in;
	mux1_sel_input_signal <= mux1_sel_in;
	JTU_mux_sel_input_signal <= JTU_mux_sel_in;

	--MEM control signals
	data_format_input_signal <= data_format_in;
	datamem_write_input_signal <= datamem_write_in;
	jump_flag_input_signal <= jump_flag_in;

	--WB control signals
	mux0_sel_input_signal <= mux0_sel_in;
	reg_file_write_input_signal <= reg_file_write_in;
	reg_file_write_address_input_signal <= reg_file_write_address_in;

	--Data
	register_file_output_0_input_signal <= register_file_output_0_in;
	register_file_output_1_input_signal <= register_file_output_1_in;
	immediate_input_signal <= immediate_in;
	instruction_address_input_signal <= instruction_address_in;

	--Read addresses to be given to the forwarding unit
	register_file_read_address_0_input_signal <= register_file_read_address_0_in;
	register_file_read_address_1_input_signal <= register_file_read_address_1_in;

	--WIRING OUTPUT PORTS

	--EX control signals
	ALU_operation_out <= ALU_operation_output_signal;
	ALU_branch_out <= ALU_branch_output_signal;
	ALU_branch_control_out <= ALU_branch_control_output_signal;
	mux1_sel_out <= mux1_sel_output_signal;
	JTU_mux_sel_out <= JTU_mux_sel_output_signal;

	--MEM control signals
	data_format_out <= data_format_output_signal;
	datamem_write_out <= datamem_write_output_signal;
	jump_flag_out <= jump_flag_output_signal;

	--WB control signals
	mux0_sel_out <= mux0_sel_output_signal;
	reg_file_write_out <= reg_file_write_output_signal;
	reg_file_write_address_out <= reg_file_write_address_output_signal;

	--Data
	register_file_output_0_out <= register_file_output_0_output_signal;
	register_file_output_1_out <= register_file_output_1_output_signal;
	immediate_out <= immediate_output_signal;
	instruction_address_out <= instruction_address_output_signal;

	--Read addresses to be given to the forwarding unit
	register_file_read_address_0_out <= register_file_read_address_0_output_signal;
	register_file_read_address_1_out <= register_file_read_address_1_output_signal;

end behavioral;