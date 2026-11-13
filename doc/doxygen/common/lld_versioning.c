/**
\page lld_versioning Package versioning

	\section versionNumber Package version number
	Each released package is assigned a unique identifier that consists of four numbers that represent the major and the minor version numbers separated by underscores '_'.

	For example: version  1_0_0_0_0

	With each new release:
	- either the minor version is incremented
	- or the major version number is incremented and the minor and "major update" version number reset

	the increment step for the minor and major number is >= 1.

	\note The package version number is independent from the clearcase file version numbers
        \endnote

        The version number is available in the IfxLldVersion.h header file, so that it can be referenced (and compared) by application software. The content:
\code
#define IFX_LLD_VERSION_GENERATION        1   /**< \brief Indicates the driver generation */
#define IFX_LLD_VERSION_MAJOR             0   /**< \brief Informs about changes which could lead to incompatibilities */
#define IFX_LLD_VERSION_MAJOR_UPDATE      0   /**< \brief Informs about a release for a new derivative without further API changes */
#define IFX_LLD_VERSION_MINOR             0   /**< \brief Informs about new additions to the library */
#define IFX_LLD_VERSION_REVISION          0   /**< \brief Informs about patches and/or documentation changes */
\endcode

	\section changeSignificance Change significance
	\subsection changeSignificanceMajor Change in the major version number
	Change in the major version number indicates that the version may not be fully compatible with other major version numbers.
	The reason for the incompatibility could be:
	- changes in the API names, parameters...

	\subsection changeSignificanceMajorUpdate Change in the "major update" version number
	This part of the version number indicates that the library has been released for a new derivative without further API changes.

	\subsection changeSignificanceMinor Change in the minor version number
	Change in the minor version number indicates that the version is backward compatible with smaller minor version number with identical major version number.
	The difference between minor version number are:
	- new feature introduced
	- bug fix
	- update of documentation


[\ref lld_filesAndConfig "Previous page"] [\ref lld_dosanddont "Next page"]


 */
