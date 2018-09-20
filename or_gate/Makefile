syntax:
	ghdl -s or_gate.vhdl
	ghdl -s or_gate_tb.vhdl

analyze:
	ghdl -a or_gate.vhdl
	ghdl -a or_gate_tb.vhdl

elaborate:
	ghdl -e or_gate
	ghdl -e or_gate_tb

run:
	ghdl -r or_gate_tb --vcd=or_gate_tb.vcd

gtkwave:
	gtkwave or_gate_tb.vcd

clean:
	rm -rf *.vcd *.cf
