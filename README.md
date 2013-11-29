bak
================================

bak is a simple little utility for quickly creating (temp or otherwise) files based on a few simple switches
Basic - appends .bak to the end of the files/directories
Date - appends .YYYY-MM-DD.bak to the end of the files/directories
PREFEX - prepends <text>_ to the files/directories
POSTFIX - appends _<text> to the files/directories
NO_BAK - does not append .bak to the end of the file (requires using another switch then)
REPLACE - takes a pattern (text or regexp inside single quotes) and replaces it with other text
FORCE - forces the overwriting of an existing backup file

A tour of the commandline interface
-------------------------

* none ( bak <filename> ) - appends .bak to the end of the filename
* -d - appends the current date to the filename in the YYYY-MM-DD format
* -s <text> - prepends <text>_ to the start of the filename
* -p <text> - appends _<text> to the end of the filename
* -R <text/pattern> -R <text> replaces the first match of <text/filename> in the filename with <text>
* -f - forces bak to run even if the target file you are creating already exists

These options can be mixed and matched to create a number of different backup styles
