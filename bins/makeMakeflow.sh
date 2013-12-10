#!/bin/bash
prefix='sh'

config_file='.config'
pass=`head -n 1 $config_file|tail -n 1`
dir=`head -n 2 $config_file|tail -n 1`
#script=`head -n 3 $config_file|tail -n 1`
single_file=`head -n 4 $config_file|tail -n 1`
file_or_dir=`head -n 5 $config_file|tail -n 1`
num_chunks=`head -n 6 $config_file|tail -n 1`
script='visflow.sh'
name=`basename $file_or_dir`
## create make folder for makeflow
if [ -d Makeflow_dir ];then
	rm -fr Makeflow_dir
fi
mkdir Makeflow_dir

## start making the Makeflow file
echo -e ":\n" > ./Makeflow_dir/Makeflow

## files to transfer to each worker
if [ $single_file = yes ];then
	num_chunks=1
fi

i=1
while [ $i -lt $num_chunks ];
	do
	echo "$name$i: $script$i .irodsEnv $config_file">>./Makeflow_dir/Makeflow
	echo -e "\t$prefix $script$i > $name$i">>./Makeflow_dir/Makeflow
	
	let i=$i+1
done



