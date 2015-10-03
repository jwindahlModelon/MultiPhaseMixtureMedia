# MultiPhaseMixtureMedia
MultiPhaseMixtureMedia is a framework for thermodynamic properties in Modelica including an external C/C++ Modelica property interface with back ends to CAPE-OPEN, RefProp and FluidProp.
It consists of two parts:
  * MultiPhaseMixture - a Modelica library
  * ExternalMultiPhaseMixture -  a C/C++ interface to MultiPhaseMixture with backends to CAPE-OPEN 1.0, RefProp and FluidProp

For an overview of the framework, see the article [*MultiComponentMultiPhase - A Framework for Thermodynamic Properties in Modelica*](http://dx.doi.org/10.3384/ecp15118653) 

## License
MultiPhaseMixtureMedia is a free software and the use is completely at your own risk;
it can be redistributed and/or modified under the terms of the [Modelica License 2](https://modelica.org/licenses/ModelicaLicense2).

##Compilation, Supported Operating Systems and Modelica tools
  * The current version of MultiPhaseMixture has only been successfully tested with Dymola 2016
  * ExternalMultiPhaseMixture has only been tested on Windows 32-bit. The CAPE-OPEN backend is based on Windows COM technology and requires Visual Studio Professional to compile. Different backends can be disabled during the compilation by modifying lib/source/config.h. When a new version of externalmixturemedialib.lib has been compiled it should be moved to  MultiPhaseMixture/Resources/Library 

##Acknowledgement
This is a result of the work that has been carried out in collaboration with Modelon AB and VORtech in a project founded by the the Seventh Framework Programme of the European Union (project MODELICAPROP).
