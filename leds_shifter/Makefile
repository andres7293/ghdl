CC=ghdl

syntax:
	${CC} -s leds_shifter.vhd
	${CC} -s leds_shifter_tb.vhd

analyze:
	${CC} -a leds_shifter.vhd
	${CC} -a leds_shifter_tb.vhd

elaborate:
	${CC} -e leds_shifter
	${CC} -e leds_shifter_tb

run:
	${CC} -r leds_shifter_tb --vcd=leds_shifter_tb.vcd

clean:
	rm *.cf

gtkwave:
	gtkwave leds_shifter_tb.vcd
