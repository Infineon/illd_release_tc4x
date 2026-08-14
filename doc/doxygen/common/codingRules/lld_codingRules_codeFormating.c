/**

\page lld_codingRules_codeFormating Code formating
    \section autoformating Auto-formating
        Only use the code formating as defined by following script: $VERIF_LLD/bin/indent_rec

    \section ignoreautoformating Ignore auto-formating
	In case the source code shall not be formated by the formating tool the following command can be used:
	\code
	// *INDENT-OFF* Note: this file was indented manually by the author.
	... place here code that shall not be formated by the tool
	// *INDENT-ON*
	\endcode

    \section fileStructure File structure
        The source code in a file should be grouped using doxygen groups.
        Groups should be sorted in the file by alphabetical order of the group name.
        Inside a group, code shall be sorted by alphabetical order of the API names.



[\ref lld_codingRules "Previous page"] [\ref lld_codingRules_general "Next page"]

 */
