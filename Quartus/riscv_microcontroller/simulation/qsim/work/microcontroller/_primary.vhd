library verilog;
use verilog.vl_types.all;
entity microcontroller is
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        debug_pc_output : out    vl_logic_vector(31 downto 0);
        debug_regfile_x31_output: out    vl_logic_vector(31 downto 0);
        debug_regfile_x1_output: out    vl_logic_vector(31 downto 0);
        debug_regfile_x2_output: out    vl_logic_vector(31 downto 0);
        debug_ALU_output: out    vl_logic_vector(31 downto 0);
        debug_regfile_write: out    vl_logic;
        debug_ALU_input_0: out    vl_logic_vector(31 downto 0);
        debug_ALU_input_1: out    vl_logic_vector(31 downto 0);
        debug_reg_file_read_address_0: out    vl_logic_vector(4 downto 0);
        debug_reg_file_read_address_1: out    vl_logic_vector(4 downto 0);
        debug_mux0_sel  : out    vl_logic_vector(1 downto 0);
        debug_immediate : out    vl_logic_vector(31 downto 0);
        debug_ALU_operation: out    vl_logic_vector(3 downto 0);
        debug_forward_mux_0: out    vl_logic_vector(2 downto 0);
        debug_forward_mux_1: out    vl_logic_vector(2 downto 0);
        debug_reg_file_read_address_0_ID_EXE: out    vl_logic_vector(4 downto 0);
        debug_reg_file_write_address_EX_MEM: out    vl_logic_vector(4 downto 0);
        debug_mux0_sel_MEM_WB: out    vl_logic_vector(1 downto 0);
        debug_reg_file_write_MEM_WB: out    vl_logic;
        debug_reg_file_write_address_MEM_WB: out    vl_logic_vector(4 downto 0);
        debug_ALU_output_MEM_WB: out    vl_logic_vector(31 downto 0);
        debug_ALU_output_EX_MEM: out    vl_logic_vector(31 downto 0);
        debug_register_file_output_0: out    vl_logic_vector(31 downto 0);
        debug_register_file_output_1: out    vl_logic_vector(31 downto 0);
        debug_register_file_output_0_ID_EX: out    vl_logic_vector(31 downto 0);
        debug_register_file_output_1_ID_EX: out    vl_logic_vector(31 downto 0);
        debug_instruction: out    vl_logic_vector(31 downto 0)
    );
end microcontroller;
