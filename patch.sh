#!/usr/bin/zsh
dfPath=~/Projects/dotfiles;
if [[ ! -z $3 ]]; then
	fileName=$3
else
	fileName="*"
fi
for diff in $(ls $dfPath/$1/$2/$1\-$2\-$fileName.diff); do
	diff=$(basename $diff);
	git apply $dfPath/$1/$2/$diff;
done;
