#!/bin/bash

VERSION=0.4.0
# DEFINE_SCRIPT_DIR()

# ARG_POSITIONAL_SINGLE([input])
# ARG_OPTIONAL_SINGLE([output],[o],[Name of the output file (pass '-' for stdout)],[-])
# ARG_OPTIONAL_BOOLEAN([standalone],[],[Whether the parsing code is in a standalone file.])
# ARG_VERSION([echo "argbash v$VERSION"])
# ARG_HELP([Argbash is an argument parser generator for Bash.])

# ARGBASH_GO(FYI: Generated by version 0.4.0)
#mark# m4_ignore([
### START OF CODE GENERATED BY ARGBASH (one line above) ###
# THE DEFAULTS INITIALIZATION
_ARG_OUTPUT=-
_ARG_STANDALONE=off

# THE PRINT HELP FUNCION
function print_help
{
	echo "Argbash is an argument parser generator for Bash."
	echo "Usage: $0 <input> [--output <arg>] [--(no-)standalone] [--version] [--help]"
	echo -e "\t<input>: Positional arg"
	echo -e "\t-o,--output: Name of the output file (pass '-' for stdout) (default: '-')"
	echo -e "\t--standalone,--no-standalone: Whether the parsing code is in a standalone file. (default: 'off')"
	echo -e "\t-v,--version: Prints version"
	echo -e "\t-h,--help: Prints help"
}
# THE PARSING ITSELF
while test $# -gt 0
do
	_key="$1"
	case "$_key" in
		-o|--output)
			test $# -lt 2 && { echo "Missing value for the positional argument." >&2; exit 1; }
			_ARG_OUTPUT="$2"
			shift
			;;
		--no-standalone|--standalone)
			_ARG_STANDALONE="on"
			test "${1:0:5}" = "--no-" && _ARG_STANDALONE="off"
			;;
		-v|--version)
			echo "argbash v$VERSION"
			exit 0
			;;
		-h|--help)
			print_help
			exit 0
			;;
		*)
		    	POSITIONALS+=("$1")
		    	# unknown option
			;;
	esac
	shift
done

POSITIONAL_NAMES=('_ARG_INPUT' )
test ${#POSITIONALS[@]} -lt 1 && { ( echo "FATAL ERROR: Not enough positional arguments."; print_help ) >&2; exit 1; }
test ${#POSITIONALS[@]} -gt 1 && { ( echo "FATAL ERROR: There were spurious positional arguments."; print_help ) >&2; exit 1; }
for (( ii = 0; ii <  ${#POSITIONALS[@]}; ii++))
do
	eval "${POSITIONAL_NAMES[$ii]}=\"${POSITIONALS[$ii]}\""
done
# OTHER STUFF GENERATED BY Argbash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

### END OF CODE GENERATED BY Argbash ### ])
#mark# [

#

# vvv A pretty reliable way of telling where we are
M4DIR="$SCRIPT_DIR/../src"

OUTPUT_M4="$M4DIR/output.m4"
test "$_ARG_STANDALONE" = "on" && OUTPUT_M4="$M4DIR/output-standalone.m4"

function do_stuff
{
	cat $M4DIR/stuff.m4 "$OUTPUT_M4" "$_ARG_INPUT" | autom4te -l m4sugar -I "$M4DIR" | grep -v '^#\s*<-- needed because of argbash$'
}

test -f "$_ARG_INPUT" || { echo "'$_ARG_INPUT' is supposed to be a file!"; exit 1; }
test -n "$_ARG_OUTPUT" || { echo "The output can't be blank - it is not a legal filename!"; exit 1; }
OUTFILE="$_ARG_OUTPUT"
autom4te --version > /dev/null 2>&1 || { echo "You need the 'autom4te' utility (it comes with 'autoconf'), if you have bash, that one is an easy one to get." 2>&1; exit 1; }

if test "$OUTFILE" = '-'
then
	do_stuff
else
	do_stuff > "$OUTFILE"
	chmod a+x "$OUTFILE"
fi

#
#mark# ]
