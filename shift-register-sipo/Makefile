CC=ghdl

syntax:
	$(CC) -s shift_register_sipo.vhdl
	$(CC) -s shift_register_sipo_tb.vhdl

analyze:
	$(CC) -a shift_register_sipo.vhdl
	$(CC) -a shift_register_sipo_tb.vhdl

elaborate:
	$(CC) -e shift_register_sipo
	$(CC) -e shift_register_sipo_tb

run:
	$(CC) -r shift_register_sipo_tb --vcd=shift_register_sipo.vcd

gtkwave:
	gtkwave shift_register_sipo.vcd
