#!/bin/bash
# Converts all .gro files to .pdb files in the current directory recursively

STARTINGDIR="./"

convert() {
	for f in ./*
	do
		
		if [ -d "$f" ]
		then
			(cd "$f";
			convert)
		elif [[ $f == *.gro ]]
		then
			echo "Converting $f to .pdb"
			filename=$(basename $f .gro)
			#fullfilename="$filename.top"
			#gmx x2top -f $f -o $fullfilename
		
			PDBFILENAME="$filename.pdb"
			#get entire system including H atoms
			(echo 2 | gmx trjconv -f $f -s $f -o $PDBFILENAME)
		fi
	done
}

convert


#find . -mindepth 1 -type f -name ".gro" -exec (
#	echo "Converting $f to .pdb";
#	STRIPPEDNAME=${x%.gro};
#	TOPFILENAME="$A.top";
#	gmx x2top -f $f -o A;
#
#	PDBFILENAME="$STRIPPEDNAME.pdb";
#	gmx trjconv -f $f -t  -o PDBFILENAME;) {} +


#find . -mindepth 1 -type f -name ".gro" -exec 
#	echo "Converting $f to .pdb";
#	STRIPPEDNAME=$(basename $f .gro)
#	TOPFILENAME="$A.top";
#	gmx x2top -f $f -o A;
#
#	PDBFILENAME="$STRIPPEDNAME.pdb";
#	echo 2 | gmx trjconv -f $f -s $f -o PDBFILENAME; {} +
