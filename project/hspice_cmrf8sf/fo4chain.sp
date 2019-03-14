
**include model and subckts
 .lib '/tools2/courses/ee6321/share/IBM_PDK/cmrf8sf/relDM/HSPICE/models/allModels.inc' tt
 .include '/tools2/courses/ee6321/share/IBM_PDK/cmrf8sf/relDM/HSPICE/models/design.inc'



.TEMP 25
**define options
 .option post=1
**comment out the option post and include psf & artist options to view waveforms in Viva.
* .option psf=1
* .option artist=1
 .option accurate=1
 .option gmin=1e-15
 .option gmindc=1.0e-15
 .option method=gear

**define parameters


**circuit instantiation


**power sources


**voltage input PWL


**run simulation


**add measurements


*end of simulation 
.end

