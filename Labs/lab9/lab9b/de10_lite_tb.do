vlib work
vcom -2008 gen_counter.vhd
# Add any additional files here 
vcom -2008 de10_lite_base.vhd 
vcom -2008 de10_lite_tb.vhd 
vsim -t ns work.de10_lite_tb
view wave
do wave.do
run 100000 ns