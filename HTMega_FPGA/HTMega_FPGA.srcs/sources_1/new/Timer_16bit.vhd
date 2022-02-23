library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Timer_16bit is
	Port (
		clk_6 : in std_logic;
		value_out : out std_logic_vector(15 downto 0) ;
		compare_value, top : in std_logic_vector (15 downto 0);
		enabled, en_comparison, en_pwm, reset, clear_buffer : in std_logic;
		out_comparison, out_overflow, out_port : out std_logic := '0';
		port_config : in std_logic_vector(1 downto 0);
		prescaler : in std_logic_vector(2 downto 0)
    );
end Timer_16bit;

architecture Behavioral of Timer_16bit is

signal pre_value : integer range 0 to 16383 := 0;
signal value : integer range 0 to 65536 := 0;
signal port_value : std_logic := '0';
signal is_match, is_value_up, port_enabled : boolean := false;
signal prescaler_value : integer range 0 to 16383;
type prescaler_type is array(7 downto 0) of integer range 0 to 16383;

constant prescalers : prescaler_type := (6000,1000,600,60,6,3,2,1);

begin
	value_out <= std_logic_vector(to_unsigned(value, 16));
	out_comparison <= '1' when is_match else '0';
	out_port <= port_value when port_enabled and enabled = '1' else 'Z';
	prescaler_value <= prescalers(to_integer(unsigned(prescaler)))-1;
	
	process(clk_6) begin
	    if clear_buffer = '1' then
		    is_match <= false;
            out_overflow <= '0';
		end if;
		if rising_edge(clk_6) and enabled = '1' then
            
			if pre_value >= prescaler_value then
				pre_value <= 0;
				is_value_up <= true;
				if value >= (unsigned(top)-1) then
					out_overflow <= '1';
					value <= 0;
				else
					value <= value + 1;
					if en_comparison = '1' then
                        is_match <= value = (unsigned(compare_value)-1) and is_value_up ;
        
                        if en_pwm = '1' then
                            case port_config is
                                when "01" =>
                                    if is_match then
                                        case port_value is
                                            when '1' => port_value <= '0';
                                            when '0' => port_value <= '1';
                                            when others => 
                                        end case;
                                    end if;
        
                                when "10" =>
                                    if value = 0 then
                                        port_value <= '1';
                                    elsif is_match then
                                        port_value <= '0';
                                    end if;
                                    
                                when "11" =>	
                                    if value = 0 then
                                        port_value <= '0';
                                    elsif is_match then
                                        port_value <= '1';
                                    end if;
                                when others =>
                            
                            end case;
        
                        elsif is_match then
                            case port_config is
                                when "01" => 
                                    case port_value is
                                        when '1' => port_value <= '0';
                                        when '0' => port_value <= '1';
                                        when others => 
                                    end case;
                                when "10" => 
                                    port_value <= '0';
                                when "11" => 
                                    port_value <= '1';
                                when others =>
                            end case;
                        end if;
                    end if; 
				end if;
			else
				is_value_up <= false;
				pre_value <= pre_value + 1;
			end if;

			if reset = '1' then
				value <= 0;
				pre_value <= 0;
			end if;

			port_enabled <= port_config /= "00";
		end if;
		
		
	end process;
end Behavioral;
