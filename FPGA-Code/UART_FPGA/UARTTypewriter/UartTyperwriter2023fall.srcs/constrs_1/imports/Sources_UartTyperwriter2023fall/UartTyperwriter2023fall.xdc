#ECE433 Fall 2023
#UartTyperwriter2023fall.v
#Uart Typewriter with Nexy A7
set_property PACKAGE_PIN E3 [get_ports clock]
#BTND
set_property PACKAGE_PIN D9 [get_ports reset]
#A9 RX - D10 TX USB
#set_property PACKAGE_PIN A9 [get_ports rx]
#set_property PACKAGE_PIN D10 [get_ports tx]
set_property PACKAGE_PIN F3 [get_ports rx]
set_property PACKAGE_PIN F4 [get_ports tx]

set_property PACKAGE_PIN H5 [get_ports {transmitted_bits[7]}]
set_property PACKAGE_PIN J5 [get_ports {transmitted_bits[6]}]
set_property PACKAGE_PIN T9 [get_ports {transmitted_bits[5]}]
set_property PACKAGE_PIN T10 [get_ports {transmitted_bits[4]}]
set_property PACKAGE_PIN F6 [get_ports {transmitted_bits[3]}]
set_property PACKAGE_PIN J4 [get_ports {transmitted_bits[2]}]
set_property PACKAGE_PIN J2 [get_ports {transmitted_bits[1]}]
set_property PACKAGE_PIN H6 [get_ports {transmitted_bits[0]}]

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
set_property IOSTANDARD LVCMOS33 [get_ports tx]

