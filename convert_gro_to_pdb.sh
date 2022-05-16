#!/bin/bash
# Converts all .gro files to .pdb files in the current directory recursively

STARTINGDIR="./"

recursive_convert() {
	for f in $STARTINGDIR
	do
		echo "$f"
		if [ -d "$f" ]
		then
			cd "$f"
			recursive_convert
		fi
		if [[ $f == *.gro ]]
		then
			echo "Converting $f to .pdb"
			filename=$(basename $f .gro)
			echo $filename
			fullfilename="$filename.top"
			gmx x2top -f $f -o fullfilename
		
			PDBFILENAME="$filename.pdb"
			gmx trjconv -f $f -t A -o PDBFILENAME
		fi
	done
}

recursive_convert


#find . -mindepth 1 -type f -name ".gro" -exec [
#	echo "Converting $f to .pdb";
#	STRIPPEDNAME = ${x%.gro};
#	TOPFILENAME = "$A.top";
#	gmx x2top -f $f -o A;
#
#	PDBFILENAME = "$STRIPPEDNAME.pdb";
#	gmx trjconv -f $f -t A -o PDBFILENAME;] {} +
