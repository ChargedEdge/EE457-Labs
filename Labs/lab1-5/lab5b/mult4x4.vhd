LIBRARY IEEE;
USE IEEE.NUMERIC_STD.ALL;

ENTITY mult4x4 IS

	PORT(
		SIGNAL dataa	: IN UNSIGNED (3 DOWNTO 0);
		SIGNAL datab	: IN UNSIGNED (3 DOWNTO 0);
		
		SIGNAL product	: OUT UNSIGNED (7 DOWNTO 0)
	);

END ENTITY mult4x4;


ARCHITECTURE mult4x4_arch OF mult4x4 IS

BEGIN
	product <= dataa * datab;
END ARCHITECTURE mult4x4_arch;
