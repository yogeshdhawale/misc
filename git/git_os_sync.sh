#!/bin/bash -i


#ls -F | grep "tidb/" | cut -d'/' -f1 | xargs -I z sh -c '
#	echo "Sync running for dir: " z ;
#	cd z;
#	if [ "master" == $(git remote show origin | awk '"'"'/HEAD branch/ {print $NF}'"'"') ]; then gh repo sync yogeshdhawale/z -b master; fi;
#	if [ "main" == $(git remote show origin | awk '"'"'/HEAD branch/ {print $NF}'"'"') ]; then gh repo sync yogeshdhawale/z -b main; fi;
#	gh repo sync;
#	cd ..; 
#	' \

if [ $# -ne 1 ]; then
	echo "Provide directory string pattern. e.g. \"*/\""
	exit
fi

dir_pattern=$1

for dir in $(ls -d $dir_pattern)
do
	z=${dir%*/}

	skip_dirs=" 1Notes demo "

	if [[ " $skip_dirs " =~ "$z" ]] ; then
		echo "Skipping dir $z"
		continue
	fi

	echo "Sync running for dir: " $z ;
	cd $z;

	branch=$(git remote show origin | awk '/HEAD branch/ {print $NF}');
	#echo "Branch is " $branch;

	if [ "" == "$branch" ] ; then
		gh repo sync;
		cd ..;
		continue;
	fi

	git remote | grep upstream && gh repo sync yogeshdhawale/$z -b $branch;
	gh repo sync;

	cd ..
done

echo "	---	Done, exited.	---";

