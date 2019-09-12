-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- *****************************************************************************
-- This file contains a Vhdl test bench with test vectors .The test vectors     
-- are exported from a vector file in the Quartus Waveform Editor and apply to  
-- the top level entity of the current Quartus project .The user can use this   
-- testbench to simulate his design using a third-party simulation tool .       
-- *****************************************************************************
-- Generated on "08/14/2019 17:17:43"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          microcontroller
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY microcontroller_vhd_vec_tst IS
END microcontroller_vhd_vec_tst;
ARCHITECTURE microcontroller_arch OF microcontroller_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL clock : STD_LOGIC;
SIGNAL debug_ALU_input_0 : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL debug_ALU_input_1 : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL debug_ALU_operation : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL debug_ALU_output : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL debug_ALU_output_EX_MEM : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL debug_ALU_output_MEM_WB : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL debug_forward_mux_0 : STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL debug_forward_mux_1 : STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL debug_immediate : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL debug_instruction : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL debug_mux0_sel : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL debug_mux0_sel_MEM_WB : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL debug_pc_output : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL debug_reg_file_read_address_0 : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL debug_reg_file_read_address_0_ID_EXE : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL debug_reg_file_read_address_1 : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL debug_reg_file_write_address_EX_MEM : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL debug_reg_file_write_address_MEM_WB : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL debug_reg_file_write_MEM_WB : STD_LOGIC;
SIGNAL debug_regfile_write : STD_LOGIC;
SIGNAL debug_regfile_x1_output : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL debug_regfile_x2_output : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL debug_regfile_x31_output : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL debug_register_file_output_0 : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL debug_register_file_output_0_ID_EX : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL debug_register_file_output_1 : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL debug_register_file_output_1_ID_EX : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL reset : STD_LOGIC;
COMPONENT microcontroller
	PORT (
	clock : IN STD_LOGIC;
	debug_ALU_input_0 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	debug_ALU_input_1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	debug_ALU_operation : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	debug_ALU_output : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	debug_ALU_output_EX_MEM : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	debug_ALU_output_MEM_WB : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	debug_forward_mux_0 : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
	debug_forward_mux_1 : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
	debug_immediate : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	debug_instruction : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	debug_mux0_sel : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
	debug_mux0_sel_MEM_WB : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
	debug_pc_output : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	debug_reg_file_read_address_0 : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
	debug_reg_file_read_address_0_ID_EXE : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
	debug_reg_file_read_address_1 : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
	debug_reg_file_write_address_EX_MEM : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
	debug_reg_file_write_address_MEM_WB : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
	debug_reg_file_write_MEM_WB : OUT STD_LOGIC;
	debug_regfile_write : OUT STD_LOGIC;
	debug_regfile_x1_output : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	debug_regfile_x2_output : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	debug_regfile_x31_output : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	debug_register_file_output_0 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	debug_register_file_output_0_ID_EX : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	debug_register_file_output_1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	debug_register_file_output_1_ID_EX : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	reset : IN STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : microcontroller
	PORT MAP (
-- list connections between master ports and signals
	clock => clock,
	debug_ALU_input_0 => debug_ALU_input_0,
	debug_ALU_input_1 => debug_ALU_input_1,
	debug_ALU_operation => debug_ALU_operation,
	debug_ALU_output => debug_ALU_output,
	debug_ALU_output_EX_MEM => debug_ALU_output_EX_MEM,
	debug_ALU_output_MEM_WB => debug_ALU_output_MEM_WB,
	debug_forward_mux_0 => debug_forward_mux_0,
	debug_forward_mux_1 => debug_forward_mux_1,
	debug_immediate => debug_immediate,
	debug_instruction => debug_instruction,
	debug_mux0_sel => debug_mux0_sel,
	debug_mux0_sel_MEM_WB => debug_mux0_sel_MEM_WB,
	debug_pc_output => debug_pc_output,
	debug_reg_file_read_address_0 => debug_reg_file_read_address_0,
	debug_reg_file_read_address_0_ID_EXE => debug_reg_file_read_address_0_ID_EXE,
	debug_reg_file_read_address_1 => debug_reg_file_read_address_1,
	debug_reg_file_write_address_EX_MEM => debug_reg_file_write_address_EX_MEM,
	debug_reg_file_write_address_MEM_WB => debug_reg_file_write_address_MEM_WB,
	debug_reg_file_write_MEM_WB => debug_reg_file_write_MEM_WB,
	debug_regfile_write => debug_regfile_write,
	debug_regfile_x1_output => debug_regfile_x1_output,
	debug_regfile_x2_output => debug_regfile_x2_output,
	debug_regfile_x31_output => debug_regfile_x31_output,
	debug_register_file_output_0 => debug_register_file_output_0,
	debug_register_file_output_0_ID_EX => debug_register_file_output_0_ID_EX,
	debug_register_file_output_1 => debug_register_file_output_1,
	debug_register_file_output_1_ID_EX => debug_register_file_output_1_ID_EX,
	reset => reset
	);

-- clock
t_prcs_clock: PROCESS
BEGIN
LOOP
	clock <= '0';
	WAIT FOR 5000 ps;
	clock <= '1';
	WAIT FOR 5000 ps;
	IF (NOW >= 1000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_clock;

-- reset
t_prcs_reset: PROCESS
BEGIN
	reset <= '0';
WAIT;
END PROCESS t_prcs_reset;
END microcontroller_arch;
