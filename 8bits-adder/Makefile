syntax:
	ghdl -s eight_bits_adder.vhdl
	ghdl -s full_adder.vhdl
	ghdl -s eight_bits_adder_tb.vhdl

analyze:
	ghdl -a eight_bits_adder.vhdl
	ghdl -a full_adder.vhdl
	ghdl -a eight_bits_adder_tb.vhdl

elaborate:
	ghdl -e eight_bits_adder
	ghdl -e full_adder
	ghdl -e eight_bits_adder_tb

run:
	ghdl -r eight_bits_adder_tb --vcd=eight_bits_adder.vcd

gtkwave:
	gtkwave eight_bits_adder.vcd

clean:
	rm -rf *.vcd *.cf
