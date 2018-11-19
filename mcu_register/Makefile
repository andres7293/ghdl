CC=ghdl

syntax:
	$(CC) -s mcu_register.vhdl
	$(CC) -s mcu_register_tb.vhdl

analyze:
	$(CC) -a mcu_register.vhdl
	$(CC) -a mcu_register_tb.vhdl

elaborate:
	$(CC) -e mcu_register
	$(CC) -e mcu_register_tb

run:
	$(CC) -r mcu_register_tb --vcd=mcu_register_tb.vcd

gtkwave:
	gtkwave mcu_register_tb.vcd

clean:
	clean mcu_register_tb.vcd
