library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

library work;
use work.Constants.ALL;

entity UART_Interface is
    Port ( clk_6 : in STD_LOGIC;
    	   bus_addr_in : in STD_LOGIC_VECTOR (7 downto 0);
           bus_data_in : in STD_LOGIC_VECTOR (15 downto 0);
           bus_data_out : out STD_LOGIC_VECTOR(15 downto 0) := X"0000";
           bus_enable, bus_write_enable : in STD_LOGIC;
           UART_port_out : out STD_LOGIC := '1';
           UART_port_in : in STD_LOGIC
           );
end UART_Interface;

architecture Behavioral of UART_Interface is

component UART_Transmitter is
    Port ( uart_out : out STD_LOGIC := '1';
           is_sending : out STD_LOGIC;
           clk, active, start_sending, parity_type : in STD_LOGIC;
           data : in STD_LOGIC_VECTOR(7 downto 0)
           );
end component;

component UART_Reciever is
    Port ( clk, active, uart_in, reset_buffer, parity_type: in STD_LOGIC;
           data : out STD_LOGIC_VECTOR (7 downto 0) := X"00";
           is_receiving, finished_receiving, wrong_parity : out STD_LOGIC := '0'
           );
end component;

signal rec_data, status, send_data : std_logic_vector(7 downto 0) := X"00";
signal config : std_logic_vector (3 downto 0) := X"0";
signal baud_rate, prescaler_value : unsigned(11 downto 0) := X"000";
signal start_sending, rec_buffer_reset, prescaler : std_logic := '0';
signal reset_prescaler : boolean := false;


begin
	
	Transmitter : UART_Transmitter port map(
		uart_out => UART_port_out, is_sending => status(0),
		clk => prescaler and clk_6, active => config(0), 
		start_sending => start_sending, parity_type => config(1), 
		data => send_data);

	Receiver : UART_Reciever port map(
		clk => prescaler and clk_6, active => config(0), uart_in => UART_port_in,
		reset_buffer => rec_buffer_reset, parity_type => config(1),
		data => rec_data, is_receiving => status(1), finished_receiving => status(2),
		wrong_parity => status(3));

	process(clk_6) begin
		if rising_edge(clk_6) then
			
			if baud_rate > 1 then
				prescaler <= '0';

				if reset_prescaler then
					prescaler_value <= X"000";
					prescaler <= '1';
				elsif prescaler_value >= (baud_rate-1) then
					prescaler_value <= X"000";
					prescaler <= '1';
				else
					prescaler_value <= prescaler_value + 1;					
				end if;
			else 
				prescaler <= '1';
			end if;
		end if;	
		if falling_edge(clk_6) then
            rec_buffer_reset <= '0';
			start_sending <= '0';
			reset_prescaler <= false;
            if bus_enable = '1' then
                case bus_addr_in is
                    when AD_UART_CONF =>
                        bus_data_out <= std_logic_vector(baud_rate) & config;
                        if bus_write_enable = '1' then
                            config <= bus_data_in(3 downto 0);
                            baud_rate <= unsigned(bus_data_in(15 downto 4));
                            reset_prescaler <= true;
                        end if;
                    when AD_UART_RD => 
                        if bus_write_enable = '1' then
                            rec_buffer_reset <= '1';
                            reset_prescaler <= true;
                        end if;
                        bus_data_out <= status & rec_data;
                    when AD_UART_TD =>
                        bus_data_out <= X"00" & send_data;
                        if bus_write_enable = '1' then
                            send_data <= bus_data_in(7 downto 0);
                            start_sending <= '1';
                            reset_prescaler <= true;
                        end if;
                    when others =>
                end case;
            end if;
		end if;
	end process;
end Behavioral;
