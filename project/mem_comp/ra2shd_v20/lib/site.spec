# $Revision: 1.2 $
# generic switches
instname=RA2SHD
words=2048
bits=32
frequency=1
ring_width=4
mux=8
drive=6
#uti=off
#pipeline=off
#output_enable=off
write_mask=off
wp_size=8
top_layer=met5-8
power_type=rings
horiz=met3
vert=met4

# advanced options
cust_comment=
left_bus_delim=[
right_bus_delim=]
pwr_gnd_rename=VDD:VDD,GND:VSS
prefix=
pin_space=0.0
name_case=upper
inside_ring_type=GND
check_instname=on
diodes=on
vclef-fp.inst2ring=blockages
vclef-fp.site_def=off
dpccm=on
asvm=on
bus_notation=on

# view-specific switches
ambit.libname=USERLIB
synopsys.libname=USERLIB
tlf.libname=USERLIB
udl.libname=USERLIB
wattwatcher.libname=USERLIB
corners=ff_1p32v_m40c,ff_1p65v_125c,tt_1p2v_25c,ss_1p08v_125c
