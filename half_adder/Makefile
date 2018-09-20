syntax:
	ghdl -s half_adder.vhdl
	ghdl -s half_adder_tb.vhdl

analyze:
	ghdl -a half_adder.vhdl
	ghdl -a half_adder_tb.vhdl

elaborate:
	ghdl -e half_adder
	ghdl -e half_adder_tb

run:
	ghdl -r half_adder_tb --vcd=half_adder_tb.vcd

gtkwave:
	gtkwave half_adder_tb.vcd

clean:
	rm -rf *.vcd *.cf
