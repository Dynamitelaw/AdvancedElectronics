./nuke.sh
#velocity -init lfsr1.tcl
velocity -nowin -init lfsr1.tcl
./makecdl.sh

echo ===========================================
cat encounter.log | grep density
