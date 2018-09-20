syntax:
	ghdl -s and_gate.vhdl
	ghdl -s and_gate_tb.vhdl

analyze:
	ghdl -a and_gate.vhdl
	ghdl -a and_gate_tb.vhdl

elaborate:
	ghdl -e and_gate
	ghdl -e and_gate_tb

run:
	ghdl -r and_gate_tb --vcd=and_gate_tb.vcd

gtkwave:
	gtkwave and_gate_tb.vcd

clean:
	rm -rf *.vcd *.cf
