LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_signed.ALL;

ENTITY alu IS
PORT
	(	
		ain	:	IN		STD_LOGIC_VECTOR(7 DOWNTO 0);
		bin	:	IN		STD_LOGIC_VECTOR(7 DOWNTO 0);
		inv	:	IN		STD_LOGIC_VECTOR(1 DOWNTO 0); -- invert A and B
		op		:	IN		STD_LOGIC_VECTOR(1 DOWNTO 0);
		res	:	OUT	STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END ENTITY alu;

ARCHITECTURE behavior OF alu IS
	SIGNAL res_sig : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL a : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL b : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN
	PROCESS(a, b, inv)
		BEGIN
			IF inv = "00" THEN
				a <= ain;
				b <= bin;
			ELSIF inv = "01" THEN
				a <= ain;
				b <= NOT bin;
			ELSIF inv = "10" THEN
				a <= NOT ain;
				b <= bin;
			ELSIF inv = "11" THEN
				a <= NOT ain;
				b <= NOT bin;
			END IF;
	END PROCESS;
	
	PROCESS(a, b, op)
		BEGIN
			IF (op = "00") THEN -- AND NOR
				res_sig <= a AND b;
			ELSIF (op = "01") THEN -- OR
				res_sig <= a OR b;
			ELSIF (op = "10") THEN -- ADD SUB
				res_sig <= a + b;	
			ELSIF (op = "11" and (a < b) ) THEN -- SLT
				res_sig <= "00000001";
			ELSIF (op = "11" and (a > b) ) THEN -- SLT 
				res_sig <= "00000000";
			END IF;
	END PROCESS;
	res <= res_sig;
END behavior;