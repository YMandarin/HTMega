library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
use IEEE.std_logic_misc.ALL;

library work;
use work.Constants.ALL;

entity ALU_16bit is
    Port (
    	clk_12 : in STD_LOGIC;
    	Enable, Start_Execution : in STD_LOGIC;
		Instr_sel : in STD_LOGIC_VECTOR(4 downto 0);
        X,Y : in STD_LOGIC_VECTOR(15 downto 0);
        Flags_in : STD_LOGIC_VECTOR(7 downto 0);
        Res1,Res2 : out STD_LOGIC_VECTOR(15 downto 0) := X"0000";
        Flags_out : out STD_LOGIC_VECTOR(7 downto 0);
        Finished : out STD_LOGIC := '0'
	);
        
end ALU_16bit;

architecture Hierarchical of ALU_16bit is
signal IN_1, IN_2 : unsigned (16 downto 0);
signal OUT_1, OUT_2, Q_ADD, Q_ADDC, Q_SUB, Q_SUBC, Q_DIV, 
	Q_DIVS, Q_INC, Q_DEC, Q_NEG, Q_COM, Q_AND, Q_OR, Q_XOR, Q_SWAP,
	Q_LSL, Q_LSR, Q_ROL, Q_ROR, Q_ASR : unsigned (16 downto 0);
signal Q_MUL, Q_MULS : unsigned (32 downto 0);
signal result : std_logic_vector(15 downto 0);

signal fin, start_buffer, use_out_2 : std_logic := '0';
signal flags : std_logic_vector(7 downto 0) := X"00"; 

attribute keep: boolean;
attribute keep of IN_1: signal is true; -- prevent the dsp from absorbing the input registers
attribute keep of IN_2: signal is true;
begin

Finished <= fin when Enable = '1' else Start_Execution;

Q_ADD <= IN_1 + IN_2;
Q_ADDC <= (IN_1 + IN_2) + (flags_in(f_C)&"");
Q_SUB <= IN_1 - IN_2;
Q_SUBC <= (IN_1 - IN_2) - (flags_in(f_C)&"");
Q_DIV <= '0' & (IN_1(15 downto 0) / IN_2(15 downto 0));
Q_DIVS <= '0' & unsigned(signed(IN_1(15 downto 0)) / signed(IN_2(15 downto 0)));
Q_MUL <= '0' & (IN_1(15 downto 0) * IN_2(15 downto 0)); -- use hardware dsp modules for multiplication
Q_MULS <='0' & unsigned(signed(IN_1(15 downto 0)) * signed(IN_2(15 downto 0)));

Q_AND <= IN_1 AND IN_2;
Q_OR <= IN_1 OR IN_2;
Q_XOR <= IN_1 XOR IN_2;

Q_COM <= NOT IN_1;
Q_NEG <= X"0000" - IN_1;
Q_INC <= IN_1 + 1;
Q_DEC <= IN_1 - 1;

Q_SWAP <= '0' & IN_1(7 downto 0) & IN_1(15 downto 8);
Q_LSL <= IN_1(15 downto 0) & '0';
Q_LSR <= IN_1(0) & '0' & IN_1(15 downto 1);
Q_ROL <= '0' & IN_1(14 downto 0) & IN_1(15);
Q_ROR <= '0' & IN_1(0) & IN_1(15 downto 1);
Q_ASR <= '0' & IN_1(15) & IN_1(15 downto 1); 


with Instr_sel select OUT_1 <= 
	Q_ADD when  "00000",
	Q_ADDC when "00001",
	Q_SUB when  "00010",
	Q_SUBC when "00011",
	'0' & Q_MUL(15 downto 0) when "00100",
	Q_DIV when  "00101",
	'0' & Q_MULS(15 downto 0) when "00110",
	Q_DIVS when "00111",
	Q_AND when  "01000",
	Q_OR when   "01001",
	Q_XOR when  "01010",
	Q_SUB when  "01011",
	Q_SUBC when "01100",
	
	IN_1 when   "10000",
	Q_COM when  "10001",
	Q_NEG when  "10010",	
	Q_INC when  "10011",
	Q_DEC when  "10100",
	Q_SWAP when "10101",
	Q_LSL when  "10110",
	Q_LSR when  "10111",
	Q_ROL when  "11000",
	Q_ROR when  "11001",
	Q_ASR when  "11010",
	IN_1 when   "11011",
	X"0000"&'0' when others;
	
with Instr_sel select OUT_2 <= 
	Q_MUL(32 downto 16) when  "00100",
	Q_MULS(32 downto 16) when "00110",
	X"0000"&'0' when others;
	
use_out_2 <= '1' when Instr_sel = "00100" or Instr_sel = "00110" else '0';

flags(f_Z) <= OR_REDUCE(std_logic_vector(OUT_1)) NOR OR_REDUCE(std_logic_vector(OUT_2)); -- zero flag
flags(f_C) <= OUT_2(16) when use_out_2 = '1' else OUT_1(16); -- carry flag
flags(f_N) <= OUT_2(15) when use_out_2 = '1' else OUT_1(15); -- negative flag
flags(f_V) <= flags(1); -- overflow flag

flags(f_T) <= Flags_in (f_T);
flags(f_I) <= Flags_in(f_I);
flags(f_R) <= Flags_in(f_R);
flags(f_P) <= Flags_in(f_P);

result <= std_logic_vector(OUT_1(15 downto 0));
res2 <= std_logic_vector(OUT_2(15 downto 0));

res1 <= X when enable = '0' else result;

flags_out <= flags_in when enable = '0' else flags;

process(clk_12) begin
	if rising_edge(clk_12) then
		if Enable = '1' and Start_Execution = '1' then
			IN_1 <= '0'&unsigned(X);
			IN_2 <= '0'&unsigned(Y);
		end if;
		start_buffer <= Enable and Start_Execution;
	end if;
	
	if falling_edge(clk_12) then
		fin <= start_buffer;
	end if;
end process;
end architecture;
