/** \mainpage Overall Architecture

\section introduction Aurix3G iLLD Overall Architecture

The architecture of iLLD is depicted in the below Figure.

\image html "lld_arch.png" "iLLD TC4xx Architecture"

iLLDs consist of following components:
   - Standard Layer with (verbose) access functions to SFRs
   - Interface Layer has configuration and handling functions, which will implement the use-cases
   - Infrastructure block consists of SFR headers, application startup software
   - Implementation Layer consists of device specific configuration
   - Pin configuration map to configure I/O pins for the package
   - The Service Software layer provides generic runtime API for common application use case. It abstracts the underlying Interface Driver, i.e. the runtime API is completely device independent.


*/
