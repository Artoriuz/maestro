library verilog;
use verilog.vl_types.all;
entity microcontroller_vlg_check_tst is
    port(
        debug_ALU_input_0: in     vl_logic_vector(31 downto 0);
        debug_ALU_input_1: in     vl_logic_vector(31 downto 0);
        debug_ALU_operation: in     vl_logic_vector(3 downto 0);
        debug_ALU_output: in     vl_logic_vector(31 downto 0);
        debug_ALU_output_EX_MEM: in     vl_logic_vector(31 downto 0);
        debug_ALU_output_MEM_WB: in     vl_logic_vector(31 downto 0);
        debug_forward_mux_0: in     vl_logic_vector(2 downto 0);
        debug_forward_mux_1: in     vl_logic_vector(2 downto 0);
        debug_immediate : in     vl_logic_vector(31 downto 0);
        debug_instruction: in     vl_logic_vector(31 downto 0);
        debug_mux0_sel  : in     vl_logic_vector(1 downto 0);
        debug_mux0_sel_MEM_WB: in     vl_logic_vector(1 downto 0);
        debug_pc_output : in     vl_logic_vector(31 downto 0);
        debug_reg_file_read_address_0: in     vl_logic_vector(4 downto 0);
        debug_reg_file_read_address_0_ID_EXE: in     vl_logic_vector(4 downto 0);
        debug_reg_file_read_address_1: in     vl_logic_vector(4 downto 0);
        debug_reg_file_write_address_EX_MEM: in     vl_logic_vector(4 downto 0);
        debug_reg_file_write_address_MEM_WB: in     vl_logic_vector(4 downto 0);
        debug_reg_file_write_MEM_WB: in     vl_logic;
        debug_regfile_write: in     vl_logic;
        debug_regfile_x1_output: in     vl_logic_vector(31 downto 0);
        debug_regfile_x2_output: in     vl_logic_vector(31 downto 0);
        debug_regfile_x31_output: in     vl_logic_vector(31 downto 0);
        debug_register_file_output_0: in     vl_logic_vector(31 downto 0);
        debug_register_file_output_0_ID_EX: in     vl_logic_vector(31 downto 0);
        debug_register_file_output_1: in     vl_logic_vector(31 downto 0);
        debug_register_file_output_1_ID_EX: in     vl_logic_vector(31 downto 0);
        sampler_rx      : in     vl_logic
    );
end microcontroller_vlg_check_tst;
