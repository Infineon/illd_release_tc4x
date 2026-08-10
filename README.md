# iLLD Release TC4x

## Folder structure
illd_release_tc4x contains the following folders and file
* `doc`          : contains the TC4xx UM and iLLD Release note
* `examples`     : contains the BaseFramework projects for the TC4xx devices 
* `src`          : contains the source code for TC4xx
* `IFASLL202501` : contains the click license for TC4xx
* `Readme.md`    : Contains information about the folder structure, package usage and iLLD software
			       release version.


## Build Instructions & Usage
The TC4xx BaseFramework project contains only the AppSw, the libraries are not included in the template projects, with the exception of the Hypervisor Baseframework. Instead, the libraries are located in "src" folder in the repo and are linked to the template project. This means that after importing the template project into the BIFACES, users can compile the project as usual, and the required libraries will be automatically linked..

								  
## iLLD version info
iLLD Release version	V2.7.0

								   
## API Documentation
The iLLD API reference is published as GitHub Pages: https://infineon.github.io/illd_release_tc4x/


## Revision History
For a summary of changes, please refer to Section 3.1 of the release notes in the doc folder.


