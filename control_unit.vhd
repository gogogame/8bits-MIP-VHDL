LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY control_unit IS
  PORT ( instruction : IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- From instruction mem 2 bits
         reg_write   : OUT STD_LOGIC; -- Signal Reg to Write
		   alu_op      : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);-- 4 options for ALUop code
			alu_inv     : OUT STD_LOGIC_VECTOR(1 DOWNTO 0) -- invert input options
			);
END ENTITY control_unit;

ARCHITECTURE dataflow OF control_unit IS
BEGIN
	-- Invert is not working, insufficient bit instruction
  WITH instruction SELECT
    reg_write <= '1' WHEN "00", -- and
	              '1' WHEN "01", -- or
					  '1' WHEN "10", -- add
					  '1' WHEN "11", -- slt
					  '0' WHEN OTHERS;
	
  WITH instruction SELECT
	  alu_op <= "00" WHEN "00", -- and
	            "00" WHEN "01", -- or
	            "01" WHEN "10", -- add
	            "01" WHEN "11", -- slt
				   "00" WHEN OTHERS;
					
  WITH instruction SELECT  --Unused
	  alu_inv <= "00" WHEN "00", -- normal add
	             "00" WHEN "01", -- invert B
	             "00" WHEN "10", -- invert A
	             "00" WHEN "11", -- invert A, B
				    "00" WHEN OTHERS;
END dataflow;