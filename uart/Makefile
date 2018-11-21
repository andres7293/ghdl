syntax:
	ghdl -s uart.vhd
	ghdl -s uart_tb.vhd

analyze:
	ghdl -a uart.vhd
	ghdl -a uart_tb.vhd

elaborate:
	ghdl -e uart
	ghdl -e uart_tb

run:
	ghdl -r uart_tb --vcd=uart_tb.vcd

gtkwave:
	gtkwave uart_tb.vcd

clean:
	rm -f uart_tb.vcd
	rm -f work*
