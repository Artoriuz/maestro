library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity controller is
	port (
		clock : in std_logic;
		reset : in std_logic;
		instruction : in std_logic_vector(31 downto 0);
		reg_file_read_address_0 : out std_logic_vector(4 downto 0);
		reg_file_read_address_1 : out std_logic_vector(4 downto 0);
		reg_file_write : out std_logic;
		reg_file_write_address : out std_logic_vector(4 downto 0);
		immediate : out std_logic_vector(31 downto 0);
		ALU_operation : out std_logic_vector(3 downto 0);
		ALU_branch : out std_logic;
		ALU_branch_control : out std_logic_vector(2 downto 0);
		JTU_mux_sel : out std_logic;
		data_format : out std_logic_vector(2 downto 0);
		datamem_write : out std_logic;
		jump_flag : out std_logic;
		mux0_sel : out std_logic_vector(1 downto 0);
		mux1_sel : out std_logic
	);
end entity controller;

architecture Behavioral of controller is
	type operational_states is (normal);
	signal current_state, next_state : operational_states := normal;

	type instruction_cluster is (INVALID, LOAD, STORE, MADD, BRANCH, LOAD_FP, STORE_FP, MSUB, JALR, NMSUB, MISC_MEM, AMO, NMADD, JAL, OP_IMM, OP, OP_FP, SYSTEM, AUIPC, LUI, OP_IMM_32, OP_32);
	signal decoded_cluster : instruction_cluster;

	type opcode is (INVALID, LUI, AUIPC, JAL, JALR, BEQ, BNE, BLT, BGE, BLTU, BGEU, LB, LH, LW, LBU, LHU, SB, SH, SW,
		ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI, ADD, SUB, inst_SLL, SLT, SLTU, inst_XOR, inst_SRL, inst_SRA, inst_OR, inst_AND, FENCE,
		FENCEI, EXALL, EBREAK, CSRRW, CSRRS, CSRRC, CSRRSI, CSRRCI);
	signal decoded_opcode : opcode;

	signal fetched_instruction : std_logic_vector (31 downto 0) := X"00000000";
	signal internal_immediate : std_logic_vector (31 downto 0) := X"00000000";
	signal internal_reg_file_read_address_0 : std_logic_vector(4 downto 0) := "00000";
	signal internal_reg_file_read_address_1 : std_logic_vector(4 downto 0) := "00000";
	signal internal_reg_file_write : std_logic := '0';
	signal internal_reg_file_write_address : std_logic_vector(4 downto 0) := "00000";
	signal internal_PC_operation : std_logic_vector(2 downto 0) := "000";
	signal internal_ALU_operation : std_logic_vector(3 downto 0) := "0000";
	signal internal_ALU_branch : std_logic := '0';
	signal internal_ALU_branch_control : std_logic_vector(2 downto 0) := "000";
	signal internal_JTU_mux_sel : std_logic;
	signal internal_data_format : std_logic_vector(2 downto 0) := "000";
	signal internal_datamem_write : std_logic := '0';
	signal internal_jump_flag : std_logic := '0';
	signal internal_mux0_sel : std_logic_vector(1 downto 0) := "00";
	signal internal_mux1_sel : std_logic := '0';

begin

	synchronism : process (clock, reset)
	begin
		if (reset = '1') then
			current_state <= normal;
		elsif rising_edge(clock) then
			current_state <= next_state;
		end if;
	end process;

	logic : process (fetched_instruction, decoded_cluster, decoded_opcode, current_state)
	begin
		case (current_state) is
				--			when start => --This states exists to clean the existing mess and restart the processor
				--				internal_reg_file_read_address_0 <= "00000";
				--				internal_reg_file_read_address_1 <= "00000";
				--				internal_reg_file_write <= '0';
				--				internal_reg_file_write_address <= "00000";
				--				internal_immediate <= X"00000000";
				--				internal_PC_operation <= "000";
				--				internal_ALU_operation <= "0000"; --unused number to make the ALU output 0
				--				internal_ALU_branch <= '0';
				--				internal_ALU_branch_control <= "000";
				--				internal_data_format <= "000";
				--				internal_datamem_write <= '0';
				--				internal_mux0_sel <= "00";
				--				internal_mux1_sel <= '0';
				--				next_state <= normal;

			when normal =>
				if fetched_instruction(1 downto 0) = "00" then
					decoded_cluster <= INVALID;
					decoded_opcode <= INVALID;
				else
					case (fetched_instruction(4 downto 2)) is
						when "000" =>
							case (fetched_instruction(6 downto 5)) is
								when "00" => --LOAD
									decoded_cluster <= LOAD;
									case (fetched_instruction(14 downto 12)) is --funct3
										when "000" => --Load Byte
											decoded_opcode <= LB;
										when "001" => --Load Half-Word
											decoded_opcode <= LH;
										when "010" => --Load Word
											decoded_opcode <= LW;
										when "100" => --Load Byte Unsigned
											decoded_opcode <= LBU;
										when "101" => --Load Hald-Word Unsigned
											decoded_opcode <= LHU;
										when others =>
											decoded_opcode <= INVALID;
									end case;
								when "01" => --STORE
									decoded_cluster <= STORE;
									case (fetched_instruction(14 downto 12)) is --funct3
										when "000" => --Store Byte
											decoded_opcode <= SB;
										when "001" => --Store Half-Word
											decoded_opcode <= SH;
										when "010" => --Store Word
											decoded_opcode <= SW;
										when others =>
											decoded_opcode <= INVALID;
									end case;
								when "10" => --MADD
									decoded_cluster <= INVALID;
									decoded_opcode <= INVALID;
								when "11" => --BRANCH
									decoded_cluster <= BRANCH;
									case (fetched_instruction(14 downto 12)) is --funct3
										when "000" => --Branch if equal
											decoded_opcode <= BEQ;
										when "001" => --Branch if not equal
											decoded_opcode <= BNE;
										when "100" => --Branch if lower than
											decoded_opcode <= BLT;
										when "101" => --Branch if greater or equal
											decoded_opcode <= BGE;
										when "110" => --Branch if lower than unsigned
											decoded_opcode <= BLTU;
										when "111" => --Branch if greater or equal unsigned
											decoded_opcode <= BGEU;
										when others =>
											decoded_opcode <= INVALID;
									end case;
							end case;
						when "001" =>
							case (fetched_instruction(6 downto 5)) is
								when "00" => --LOAD-FP
									decoded_cluster <= INVALID;
									decoded_opcode <= INVALID;
								when "01" => --STORE-FP
									decoded_cluster <= INVALID;
									decoded_opcode <= INVALID;
								when "10" => --MSUB
									decoded_cluster <= INVALID;
									decoded_opcode <= INVALID;
								when "11" => --JALR
									decoded_cluster <= JALR;
									decoded_opcode <= JALR;
							end case;
						when "010" =>
							case (fetched_instruction(6 downto 5)) is
								when "00" => --Custom 0
									decoded_cluster <= INVALID;
									decoded_opcode <= INVALID;
								when "01" => --Custom 1
									decoded_cluster <= INVALID;
									decoded_opcode <= INVALID;
								when "10" => --NMSUB
									decoded_cluster <= INVALID;
									decoded_opcode <= INVALID;
								when "11" => --Reserved
									decoded_cluster <= INVALID;
									decoded_opcode <= INVALID;
							end case;
						when "011" =>
							case (fetched_instruction(6 downto 5)) is
								when "00" => --MISC-MEM
									decoded_cluster <= INVALID;
									decoded_opcode <= INVALID;
								when "01" => --AMO
									decoded_cluster <= INVALID;
									decoded_opcode <= INVALID;
								when "10" => --NMADD
									decoded_cluster <= INVALID;
									decoded_opcode <= INVALID;
								when "11" => --JAL
									decoded_cluster <= JAL;
									decoded_opcode <= JAL;
							end case;
						when "100" =>
							case (fetched_instruction(6 downto 5)) is
								when "00" => --OP-IMM
									decoded_cluster <= OP_IMM;
									case (fetched_instruction(14 downto 12)) is --funct3
										when "000" => --Add immediate
											decoded_opcode <= ADDI;
										when "010" => --Set less than immediate
											decoded_opcode <= SLTI;
										when "011" => --Set less than immediate unsigned
											decoded_opcode <= SLTIU;
										when "100" => --XOR immediate
											decoded_opcode <= XORI;
										when "110" => --OR immediate
											decoded_opcode <= ORI;
										when "111" => --AND immediate
											decoded_opcode <= ANDI;
										when "001" => --Shift left logical immediate
											decoded_opcode <= SLLI;
										when "101" => --Shift right immediate
											case (fetched_instruction(30)) is
												when '0' => --Shift right logical immediate
													decoded_opcode <= SRLI;
												when '1' => --Shift right arithmetic immediate
													decoded_opcode <= SRAI;
											end case;
										when others =>
											decoded_opcode <= INVALID;
									end case;
								when "01" => --OP
									decoded_cluster <= OP;
									case (fetched_instruction(14 downto 12)) is --funct3
										when "000" => --ADD or SUB
											case (fetched_instruction(30)) is
												when '0' => --Add
													decoded_opcode <= ADD;
												when '1' => --Sub
													decoded_opcode <= SUB;
											end case;
										when "001" => --Shift left logical
											decoded_opcode <= inst_SLL;
										when "010" => --Set less than
											decoded_opcode <= SLT;
										when "011" => --Set less than unsigned
											decoded_opcode <= SLTU;
										when "100" => --XOR
											decoded_opcode <= inst_XOR;
										when "101" => --Shift right
											case (fetched_instruction(30)) is
												when '0' => --Shift right logical
													decoded_opcode <= inst_SRL;
												when '1' => --Shift right arithmetic
													decoded_opcode <= inst_SRA;
											end case;
										when "110" => --OR
											decoded_opcode <= inst_OR;
										when "111" => --AND
											decoded_opcode <= inst_AND;
									end case;
								when "10" => --OP-FP
									decoded_cluster <= INVALID;
									decoded_opcode <= INVALID;
								when "11" => --SYSTEM
									decoded_cluster <= INVALID;
									decoded_opcode <= INVALID;
							end case;
						when "101" =>
							case (fetched_instruction(6 downto 5)) is
								when "00" => --AUIPC
									decoded_cluster <= AUIPC;
									decoded_opcode <= AUIPC;
								when "01" => --LUI
									decoded_cluster <= LUI;
									decoded_opcode <= LUI;
								when "10" => --Reserved
									decoded_cluster <= INVALID;
									decoded_opcode <= INVALID;
								when "11" => --Reserved
									decoded_cluster <= INVALID;
									decoded_opcode <= INVALID;
							end case;
						when "110" =>
							case (fetched_instruction(6 downto 5)) is
								when "00" => --OP-IMM-32
									decoded_cluster <= INVALID;
									decoded_opcode <= INVALID;
								when "01" => --OP-32
									decoded_cluster <= INVALID;
									decoded_opcode <= INVALID;
								when "10" => --rv128
									decoded_cluster <= INVALID;
									decoded_opcode <= INVALID;
								when "11" => --rv128
									decoded_cluster <= INVALID;
									decoded_opcode <= INVALID;
							end case;
						when others =>
					end case;
				end if;

				case (decoded_cluster) is
					when INVALID =>
						internal_reg_file_read_address_0 <= "00000";
						internal_reg_file_read_address_1 <= "00000";
						internal_reg_file_write <= '0';
						internal_reg_file_write_address <= "00000";
						internal_immediate <= X"00000000";
						internal_ALU_operation <= "0000"; --random unused number to make the ALU output 0
						internal_ALU_branch <= '0';
						internal_ALU_branch_control <= "000";
						internal_JTU_mux_sel <= '0';
						internal_data_format <= "000";
						internal_datamem_write <= '0';
						internal_jump_flag <= '0';
						internal_mux0_sel <= "00";
						internal_mux1_sel <= '0';
						next_state <= normal;

					when LOAD =>
						internal_reg_file_read_address_0 <= fetched_instruction(19 downto 15);
						internal_reg_file_read_address_1 <= "00000";
						internal_reg_file_write <= '1'; --regfile is only lodaded on write_back
						internal_reg_file_write_address <= fetched_instruction(11 downto 7);
						internal_immediate <= std_logic_vector("00000000000000000000" & fetched_instruction(31 downto 20));
						internal_ALU_operation <= "0000";
						internal_ALU_branch <= '0';
						internal_ALU_branch_control <= "000"; --BEQ, BNE, BLT, BGE, BLTU, BGEU 
						internal_JTU_mux_sel <= '0';
						internal_data_format <= std_logic_vector(fetched_instruction(14 downto 12)); --LB, LH, LW, LBU, LHU
						internal_datamem_write <= '0';
						internal_jump_flag <= '0';
						internal_mux0_sel <= "01";
						internal_mux1_sel <= '1';
						next_state <= normal;

					when STORE =>
						internal_reg_file_read_address_0 <= fetched_instruction(19 downto 15);
						internal_reg_file_read_address_1 <= fetched_instruction(24 downto 20);
						internal_reg_file_write <= '0';
						internal_reg_file_write_address <= fetched_instruction(11 downto 7);
						internal_immediate <= std_logic_vector("00000000000000000000" & fetched_instruction(31 downto 25) & fetched_instruction(11 downto 7));
						internal_ALU_operation <= "0000";
						internal_ALU_branch <= '0';
						internal_ALU_branch_control <= "000"; --BEQ, BNE, BLT, BGE, BLTU, BGEU 
						internal_JTU_mux_sel <= '0';
						internal_data_format <= std_logic_vector(fetched_instruction(14 downto 12)); --SB, SH, SW
						internal_datamem_write <= '1'; --memory is only written on memory_access
						internal_jump_flag <= '0';
						internal_mux0_sel <= "00";
						internal_mux1_sel <= '1';
						next_state <= normal;

					when BRANCH =>
						internal_reg_file_read_address_0 <= fetched_instruction(19 downto 15);
						internal_reg_file_read_address_1 <= fetched_instruction(24 downto 20);
						internal_reg_file_write <= '0';
						internal_reg_file_write_address <= fetched_instruction(11 downto 7);
						internal_immediate <= std_logic_vector("00000000000000000" & fetched_instruction(31) & fetched_instruction(7) & fetched_instruction(30 downto 25) & fetched_instruction(11 downto 6) & '0');
						internal_ALU_operation <= "0000";
						internal_ALU_branch <= '1';
						internal_ALU_branch_control <= std_logic_vector(fetched_instruction(14 downto 12)); --BEQ, BNE, BLT, BGE, BLTU, BGEU 
						internal_JTU_mux_sel <= '0';
						internal_data_format <= "000";
						internal_datamem_write <= '0';
						internal_jump_flag <= '0';
						internal_mux0_sel <= "00";
						internal_mux1_sel <= '0';
						next_state <= normal;

					when JALR =>
						internal_reg_file_read_address_0 <= fetched_instruction(19 downto 15);
						internal_reg_file_read_address_1 <= "00000";
						internal_reg_file_write <= '1';
						internal_reg_file_write_address <= fetched_instruction(11 downto 7);
						internal_immediate <= std_logic_vector(shift_right(signed(fetched_instruction(31 downto 20) & "00000000000000000000"), 20));
						internal_ALU_operation <= "0000";
						internal_ALU_branch <= '0';
						internal_ALU_branch_control <= "000";
						internal_JTU_mux_sel <= '1';
						internal_data_format <= "000";
						internal_datamem_write <= '0';
						internal_jump_flag <= '1';
						internal_mux0_sel <= "10";
						internal_mux1_sel <= '0';
						next_state <= normal;

					when JAL =>
						internal_reg_file_read_address_0 <= "00000";
						internal_reg_file_read_address_1 <= "00000";
						internal_reg_file_write <= '1';
						internal_reg_file_write_address <= fetched_instruction(11 downto 7);
						internal_immediate <= std_logic_vector(shift_right(signed(fetched_instruction(31) & fetched_instruction(19 downto 12) & fetched_instruction(20) & fetched_instruction(30 downto 21) & '0' & "00000000000"), 11));
						internal_ALU_operation <= "0000";
						internal_ALU_branch <= '0';
						internal_ALU_branch_control <= "000";
						internal_JTU_mux_sel <= '0';
						internal_data_format <= "000";
						internal_datamem_write <= '0';
						internal_jump_flag <= '1';
						internal_mux0_sel <= "10";
						internal_mux1_sel <= '0';
						next_state <= normal;

					when OP_IMM => --ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI
						internal_reg_file_read_address_0 <= fetched_instruction(19 downto 15);
						internal_reg_file_read_address_1 <= fetched_instruction(24 downto 20);
						internal_reg_file_write <= '1';
						internal_reg_file_write_address <= fetched_instruction(11 downto 7);
						internal_ALU_branch <= '0';
						internal_ALU_branch_control <= "000";
						internal_JTU_mux_sel <= '0';
						internal_data_format <= "000";
						internal_datamem_write <= '0';
						internal_jump_flag <= '0';
						internal_mux0_sel <= "00";
						internal_mux1_sel <= '1';
						case (decoded_opcode) is
							when ADDI | SLTI | SLTIU =>
								internal_ALU_operation <= std_logic_vector('0' & fetched_instruction(14 downto 12));
								internal_immediate <= std_logic_vector(shift_right(signed(fetched_instruction(31 downto 20) & "00000000000000000000"), 20));
							when XORI | ORI | ANDI =>
								internal_ALU_operation <= std_logic_vector('0' & fetched_instruction(14 downto 12));
								internal_immediate <= std_logic_vector("00000000000000000000" & fetched_instruction(31 downto 20));
							when SLLI =>
								internal_ALU_operation <= std_logic_vector('0' & fetched_instruction(14 downto 12));
								internal_immediate <= std_logic_vector("000000000000000000000000000" & fetched_instruction(24 downto 20));
							when SRLI | SRAI =>
								internal_ALU_operation <= std_logic_vector(fetched_instruction(30) & fetched_instruction(14 downto 12));
								internal_immediate <= std_logic_vector("000000000000000000000000000" & fetched_instruction(24 downto 20));
							when others =>

						end case;
						next_state <= normal;

					when OP =>
						internal_reg_file_read_address_0 <= fetched_instruction(19 downto 15);
						internal_reg_file_read_address_1 <= fetched_instruction(24 downto 20);
						internal_reg_file_write <= '1';
						internal_reg_file_write_address <= fetched_instruction(11 downto 7);
						internal_immediate <= X"00000000";
						internal_ALU_operation <= std_logic_vector(fetched_instruction(30) & fetched_instruction(14 downto 12));
						internal_ALU_branch <= '0';
						internal_ALU_branch_control <= "000";
						internal_JTU_mux_sel <= '0';
						internal_data_format <= "000";
						internal_datamem_write <= '0';
						internal_jump_flag <= '0';
						internal_mux0_sel <= "00";
						internal_mux1_sel <= '0';
						next_state <= normal;

					when AUIPC =>
						internal_reg_file_read_address_0 <= "00000";
						internal_reg_file_read_address_1 <= "00000";
						internal_reg_file_write <= '1';
						internal_reg_file_write_address <= fetched_instruction(11 downto 7);
						internal_immediate <= std_logic_vector(fetched_instruction(31 downto 12) & "000000000000");
						internal_ALU_operation <= "0000";
						internal_ALU_branch <= '0';
						internal_ALU_branch_control <= "000";
						internal_JTU_mux_sel <= '0';
						internal_data_format <= "000";
						internal_datamem_write <= '0';
						internal_jump_flag <= '0';
						internal_mux0_sel <= "00";
						internal_mux1_sel <= '0';
						next_state <= normal;

					when LUI =>
						internal_reg_file_read_address_0 <= "00000";
						internal_reg_file_read_address_1 <= "00000";
						internal_reg_file_write <= '1';
						internal_reg_file_write_address <= fetched_instruction(11 downto 7);
						internal_immediate <= std_logic_vector(fetched_instruction(31 downto 12) & "000000000000");
						internal_ALU_operation <= "0000";
						internal_ALU_branch <= '0';
						internal_ALU_branch_control <= "000";
						internal_JTU_mux_sel <= '0';
						internal_data_format <= "000";
						internal_datamem_write <= '0';
						internal_jump_flag <= '0';
						internal_mux0_sel <= "00";
						internal_mux1_sel <= '1';
						next_state <= normal;
					when others =>
				end case;
		end case;
	end process;
	fetched_instruction <= instruction;
	reg_file_read_address_0 <= internal_reg_file_read_address_0;
	reg_file_read_address_1 <= internal_reg_file_read_address_1;
	reg_file_write <= internal_reg_file_write;
	reg_file_write_address <= internal_reg_file_write_address;
	immediate <= internal_immediate;
	ALU_operation <= internal_ALU_operation;
	ALU_branch <= internal_ALU_branch;
	ALU_branch_control <= internal_ALU_branch_control;
	JTU_mux_sel <= internal_JTU_mux_sel;
	data_format <= internal_data_format;
	datamem_write <= internal_datamem_write;
	jump_flag <= internal_jump_flag;
	mux0_sel <= internal_mux0_sel;
	mux1_sel <= internal_mux1_sel;

end architecture Behavioral;