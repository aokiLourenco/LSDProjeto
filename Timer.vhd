library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Timer is
	port(reset		: in  std_logic;
		  clk			: in  std_logic;
		  timeEn		: in std_logic;								--enables the timer
		  newTime	: in  std_logic;								--starts the timer for current task
		  timeVal	: in  std_logic_vector(7 downto 0); 	-- receives time in bcd
		  timeExp	: out std_logic;								-- '1' if current task has ended
		  timeReal	: out std_logic_vector(7 downto 0));	-- sends 2 digits in bcd to display
end Timer;

architecture Behavioral of Timer is

	signal s_counter : unsigned(7 downto 0) := (others => '1');
	signal s_cntZero : std_logic := '0';

begin
	process(clk)
	begin
		if (rising_edge(clk)) then
			if (reset = '1') then
				s_counter <= (others => '1');
				s_cntZero <= '0';
			else
				if (newTime = '1') then
					s_counter <= unsigned(timeVal);
					s_cntZero <= '0';
				elsif (timeEn = '1') then
					if (s_counter = "00000001") then
						s_cntZero <= '1';
					else
						s_counter <= s_counter  - 1;
						s_cntZero <= '0';
					end if;
				else
					s_cntZero <= '0';
				end if;
			end if;
		end if;
	end process;
	
	timeReal <= std_logic_vector(s_counter);
	timeExp <= s_cntZero;
	
end Behavioral;
