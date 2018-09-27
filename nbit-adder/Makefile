CC=ghdl
VCD=NBit_adder.vcd

syntax:
	$(CC) -s full_adder.vhdl
	$(CC) -s Nbit_adder.vhdl
	$(CC) -s Nbit_adder_tb.vhdl

analyze:
	$(CC) -a full_adder.vhdl
	$(CC) -a Nbit_adder.vhdl
	$(CC) -a Nbit_adder_tb.vhdl

elaborate:
	$(CC) -e full_adder
	$(CC) -e Nbit_adder
	$(CC) -e Nbit_adder_tb

run:
	$(CC) -r Nbit_adder_tb --vcd=$(VCD)

gtkwave:
	gtkwave $(VCD)

clean:
	rm -rf *.cf *.vcd
