library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.ALL;

library work;
use work.Constants.ALL;

entity Instruction_Decoder is
    Port ( 
		clk_12 : in STD_LOGIC;
		Reset : in STD_LOGIC;
		Start_decoder : in STD_LOGIC;

		PM_Data_1_in : in STD_LOGIC_VECTOR (15 downto 0);
		PM_Data_2_in : in STD_LOGIC_VECTOR (15 downto 0);
		
		PC_out : out STD_LOGIC_VECTOR(15 downto 0) := X"0000";
		Flags_in : in STD_LOGIC_VECTOR (7 downto 0);
		Zreg_in : in STD_LOGIC_VECTOR (15 downto 0);
		SP_in : in STD_LOGIC_VECTOR (15 downto 0);
		SP_inc, SP_dec : out STD_LOGIC := '0';
		
		Start_execution : out STD_LOGIC := '0';
		Program_stopped : out STD_LOGIC := '0';
		
		Use_imdt : out STD_LOGIC := '0';
		ALU_enable : out STD_LOGIC := '0';
		ALU_sel : out STD_LOGIC_VECTOR (4 downto 0) := "00000";
		Immediate : out STD_LOGIC_VECTOR(15 downto 0) := X"0000";
		
		Bus_load, Bus_load_second, Bus_write : out STD_LOGIC := '0';
		Bus_addr_1, Bus_addr_2 : out STD_LOGIC_VECTOR(7 downto 0) := X"00";
		
		RAM_load, RAM_write : out STD_LOGIC := '0';
		RAM_addr : out STD_LOGIC_VECTOR(15 downto 0) := X"0000";
		
		PM_load, PM_write : out STD_LOGIC := '0';
		PM_addr : out STD_LOGIC_VECTOR(15 downto 0) := X"0000"
	);

end Instruction_Decoder;
architecture Behavioral of Instruction_Decoder is

signal instr_type : std_logic_vector(2 downto 0);
signal running, execute : std_logic := '0';
signal mem_addr, OP_Data_2: std_logic_vector(15 downto 0) := X"0000";
signal PC : unsigned(15 downto 0) := X"FFFF";
signal PC_branch, PC_branch_relative, PC_branch_indirect : std_logic := '0';
signal Mem_addr_sel : std_logic_vector(1 downto 0) := "00";
signal PC_branched, PC_branch_in, PC_new : unsigned(15 downto 0) := X"0000";
signal Instruction, OP_Data_1 : std_logic_vector(7 downto 0) := X"00";
begin

Instruction <= PM_Data_1_in(15 downto 8);
instr_type <= PM_Data_1_in(15 downto 13);
Immediate <= OP_Data_2;
Bus_addr_1 <= OP_Data_1;
Bus_addr_2 <= OP_Data_2(7 downto 0);

PC_branch_in <= unsigned(Zreg_in) when PC_branch_indirect = '0' else unsigned(OP_Data_2);
PC_branched <= PC_branch_in when PC_branch_relative = '0' else (PC + PC_branch_in + 1);
PC_new <= PC + 1 when PC_branch = '0' else PC_branched;

with mem_addr_sel select mem_addr <=
	OP_Data_2  when "01",
	SP_in when "10",
	Zreg_in when "11",
	X"0000" when others;

RAM_addr <= mem_addr;
PM_addr <= mem_addr;
	
process(clk_12) begin
if rising_edge(clk_12) then
	execute <= '0';
	SP_dec <= '0';
	SP_inc <= '0';
	Program_stopped <= '0';
	if Reset = '0' and ((running = '1' and Start_decoder = '1') or running = '0') then
		OP_Data_1 <= PM_Data_1_in(7 downto 0);
		OP_Data_2 <= PM_Data_2_in;
		running <= '1';
		execute <= '1';
		ALU_enable <= '0';
		Use_imdt <= '0';
		Bus_load <= '0';
		Bus_load_second <= '0';
		Bus_write <= '0';
		mem_addr_sel <= "00";
		RAM_load <= '0';
		RAM_write <= '0';
		
		case instr_type is
			
			when "000" => -- General
				if Instruction(4 downto 2) = "001" then
					execute <= '0';
					running <= '0';
					Program_stopped <= '1';
					PC <= X"FFFF";
				end if;
				
			when "001" => -- Data Transfer
				case Instruction(4 downto 1) is
					when "0000" => -- MOV
						Bus_write <= '1';
						Bus_load <= '1';
					when "0001" => -- LD
						Bus_write <= '1';
						RAM_load <= '1';
						mem_addr_sel <= "01";
					when "0010" => -- LDI
						Bus_write <= '1';
						Use_imdt <= '1';
					when "0011" => -- ILD
						Bus_write <= '1';
						RAM_load <= '1';
						mem_addr_sel <= "11";
					when "0100" => -- ST
						Bus_load <= '1';
						RAM_write <= '1';
						mem_addr_sel <= "01";
					when "0101" => -- IST
						RAM_write <= '1';
						Bus_load <= '1';
						mem_addr_sel <= "11";
					when "0110" => -- ISTI
						RAM_write <= '1';
						Use_imdt <= '1';
						mem_addr_sel <= "11";
					when "0111" => -- PUSH
						RAM_write <= '1';
						Bus_load <= '1';
						mem_addr_sel <= "10";
						SP_dec <= '1';
					when "1000" => -- PUSHI
						RAM_write <= '1';
						Use_imdt <= '1';
						mem_addr_sel <= "10";
						SP_dec <= '1';
					when "1001" => -- POP
						Bus_write <= '1';
						RAM_load <= '1';
						mem_addr_sel <= "10";
						SP_inc <= '1';
					when "1010" => -- LPM
						Bus_write <= '1';
						PM_load  <= '1';
						mem_addr_sel <= "01";
					when "1011" => -- ILPM
						Bus_write <= '1';
						PM_load <= '1';
						mem_addr_sel <= "11";
					when "1100" => -- STM
						PM_write <= '1';
						Bus_load <= '1';
						mem_addr_sel <= "01";
					when "1101" => -- ISTM
						PM_write <= '1';
						Bus_load <= '1';
						mem_addr_sel <= "11";
					when "1110" => -- ISTMI
						PM_write <= '1';
						Use_imdt <= '1';
						mem_addr_sel <= "11";
					when others =>
				end case;
				
			when "010" => -- Branch
				PC_branch_relative <= Instruction(0);
				case Instruction(4 downto 1) is
				when "0000" => -- JMP
					PC_branch <= '1';
				when "0001" => -- IJMP
					PC_branch <= '1';
					PC_branch_indirect <= '1';
				when "0010" => -- JHI
					PC_branch <= not Flags_in(f_Z) and not Flags_in(f_C);
				when "0011" => -- JSLO
					PC_branch <= Flags_in(f_Z) or Flags_in(f_C);
				when "0100" => -- JGE
					PC_branch <= Flags_in(f_N) xor not Flags_in(f_V);
				when "0101" => -- JLT
					PC_branch <= Flags_in(f_N) xor Flags_in(f_V);
				when others =>
				end case;
				
			when "011" => -- Test Flags
				PC_branch_relative <= Instruction(0);
				case Instruction(4 downto 2) is
				when "000" =>
					PC_branch <= FLags_in(f_Z) xor Instruction(1);
				when "001" =>
					PC_branch <= FLags_in(f_C) xor Instruction(1);
				when "010" =>
					PC_branch <= FLags_in(f_N) xor Instruction(1);
				when "011" =>
					PC_branch <= FLags_in(f_V) xor Instruction(1);
				when "100" =>
					PC_branch <= FLags_in(f_T) xor Instruction(1);
				when "101" =>
					PC_branch <= FLags_in(f_I) xor Instruction(1);
				when "110" =>
					PC_branch <= FLags_in(f_R) xor Instruction(1);
				when "111" => 
					PC_branch <= Flags_in(f_P) xor Instruction(1);
				when others =>
				end case;
				
			when "100" => -- Double Arithmetic
				ALU_enable <= '1';
				Bus_load <= '1';
				ALU_sel <= '0' & Instruction(4 downto 1);
				if Instruction(4 downto 1) < X"B" then
					Bus_write <= '1';
				end if;
				if Instruction(0) = '1' then
					Use_imdt <= '1';
				else
					Bus_load_second <= '1';
				end if;
			when "101" => -- Single Arithmetic
				Bus_load <= '1';
				ALU_enable <= '1';
				ALU_sel <= '1' & Instruction(4 downto 1);
				if Instruction(4 downto 1) < X"B" then
					Bus_write <= '1';
				end if;
				
			when others => 
		end case;
	end if;
	if Reset = '1' then
		running <= '0';
	end if;
end if;

if falling_edge(clk_12) then
	Start_execution <= execute;
	PC <= PC_new;
	PC_out <= std_logic_vector(PC);
end if;
end process;

end Behavioral;
