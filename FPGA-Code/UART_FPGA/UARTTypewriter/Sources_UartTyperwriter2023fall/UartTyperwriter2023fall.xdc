#ECE433 Fall 2022
#UartTyperwriter2022fall.v
#Uart Typewriter with Nexy A7
set_property PACKAGE_PIN E3 [get_ports clock]
#BTND
set_property PACKAGE_PIN P18 [get_ports reset]

set_property PACKAGE_PIN C4 [get_ports rx]
set_property PACKAGE_PIN D4 [get_ports tx]
#
set_property PACKAGE_PIN V11 [get_ports {transmitted_bits[7]}]
set_property PACKAGE_PIN V12 [get_ports {transmitted_bits[6]}]
set_property PACKAGE_PIN V14 [get_ports {transmitted_bits[5]}]
set_property PACKAGE_PIN V15 [get_ports {transmitted_bits[4]}]
set_property PACKAGE_PIN T16 [get_ports {transmitted_bits[3]}]
set_property PACKAGE_PIN U14 [get_ports {transmitted_bits[2]}]
set_property PACKAGE_PIN T15 [get_ports {transmitted_bits[1]}]
set_property PACKAGE_PIN V16 [get_ports {transmitted_bits[0]}]

set_property IOSTANDARD LVCMOS33 [get_ports {transmitted_bits[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {transmitted_bits[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {transmitted_bits[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {transmitted_bits[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {transmitted_bits[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {transmitted_bits[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {transmitted_bits[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {transmitted_bits[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports clock]
set_property IOSTANDARD LVCMOS33 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports rx]
set_property IOSTANDARD LVCMOS33 [get_ports Start]
set_property IOSTANDARD LVCMOS33 [get_ports tx]

