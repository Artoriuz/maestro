library verilog;
use verilog.vl_types.all;
entity riscv_microcontroller is
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        debug_controller_state: out    vl_logic_vector(2 downto 0);
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
        debug_ALU_operation: out    vl_logic_vector(3 downto 0)
    );
end riscv_microcontroller;
