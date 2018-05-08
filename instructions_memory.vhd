LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY instructions_memory IS
  PORT ( instruction_addr	: IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
         read_reg_1			: OUT STD_LOGIC_VECTOR(1 DOWNTO 0); -- Find register destination
			read_reg_2			: OUT STD_LOGIC_VECTOR(1 DOWNTO 0); -- Find register destination
			write_reg			: OUT STD_LOGIC_VECTOR(1 DOWNTO 0); -- Find register destination
			instruction			: OUT STD_LOGIC_VECTOR(1 DOWNTO 0)  --
			);
END ENTITY instructions_memory;

ARCHITECTURE dataflow OF instructions_memory IS
    TYPE mem_array IS ARRAY(0 TO 7) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
	 -- op rs rt rd
	 SIGNAL instruction_mem : mem_array := (
	 "00000000", -- initial
	 "10101101", -- add s1, s2, s3
	 "10100100", -- add s0, s2, s1
	 "00101100", -- and s0, s2, s3
	 "01011001", -- or  s1, s2, s0
	 "11010010", -- slt s2, s1, s0
	 "00000000",
	 "00000000"); 
BEGIN

  instruction <= instruction_mem(to_integer(unsigned(instruction_addr)))(7 downto 6);
  read_reg_1 <= instruction_mem(to_integer(unsigned(instruction_addr)))(5 downto 4);
  read_reg_2 <= instruction_mem(to_integer(unsigned(instruction_addr)))(3 downto 2);
  write_reg <= instruction_mem(to_integer(unsigned(instruction_addr)))(1 downto 0);

END dataflow;