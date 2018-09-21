syntax:
	ghdl -s full_adder.vhdl
	ghdl -s full_adder_tb.vhdl

analyze:
	ghdl -a full_adder.vhdl
	ghdl -a full_adder_tb.vhdl

elaborate:
	ghdl -e full_adder
	ghdl -e full_adder_tb

run:
	ghdl -r full_adder_tb --vcd=full_adder_tb.vcd

gtkwave:
	gtkwave full_adder_tb.vcd

clean:
	rm -rf *.vcd *.cf
