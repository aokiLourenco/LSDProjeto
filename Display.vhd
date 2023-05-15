library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity display is
	port(	timeReal 	: in std_logic_vector(7 downto 0);
			equal			: in std_logic_vector(3 downto 0);
			defOn			: in std_logic_vector(7 downto 0);
			defDisplay1	: out std_logic_vector(6 downto 0);
			defDisplay2	: out std_logic_vector(6 downto 0);
			equalDisplay: out std_logic_vector(6 downto 0); 	-- displays = if the program is paused, assign to hex6
			program 		: in std_logic_vector(3 downto 0); 		-- current program
			leftDigit	: out std_logic_vector(6 downto 0); 	-- assign to hex5
			rightDigit	: out std_logic_vector(6 downto 0); 	-- assign to hex4
			pDisplay 	: out std_logic_vector(6 downto 0); 	--displays P, assign to hex1
			pnDisplay 	: out std_logic_vector(6 downto 0)); 	--displays the program number, asign to hex0
			
end display;

architecture Behavioral of display is

signal s_ten, s_unit : std_logic_vector(3 downto 0);

begin
	bin2bcdTime		: entity work.bin2bcd(Behavioral)
			port map(
				bin 	=> timeReal(5 downto 0),
				ten 	=> s_ten,
				unit 	=> s_unit);
	
	bcd7segEqual	: entity work.bcd7seg(Behavioral)
			port map(
				bcd => equal,
				seg7=> equalDisplay);

	bcd7segProgram : entity work.bcd7seg(Behavioral)
			port map(
				bcd => program,
				seg7 => pnDisplay);
				
	bcd7segTimeL: entity work.bcd7seg(Behavioral)
			port map(
				bcd => s_ten,
				seg7 => leftDigit);
	
	bcd7segTimeR: entity work.bcd7seg(Behavioral)
			port map(
				bcd => s_unit,
				seg7 => rightDigit);
				
	bcd7segDef1	: entity work.bcd7seg(Behavioral)
			port map(
				bcd => defOn(3 downto 0),
				seg7=> defDisplay1);
				
	bcd7segDef2	: entity work.bcd7seg(Behavioral)
			port map(
				bcd => defOn(7 downto 4),
				seg7=> defDisplay2);
	
	pDisplay <= "0001100";

end Behavioral;