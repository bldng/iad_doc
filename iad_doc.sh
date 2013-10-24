#!/bin/bash

echo -e $(tput setaf 2)"\nYo! Please enter the names of the group, separated by commas: \n"$(tput setaf 7)
read names_input

# Holy syntax, batman! 
input_array=$(echo $names_input | sed 's/, /_/g; s/,/_/g; s/ /-/g; s/_/ /g')
first_folder=$(echo $names_input | sed 's/, / - /g;s/,/ - /g')
input_initials=$(echo $names_input | sed 's/, / _ /g; s/,/ _ /g; s/-/ /g;')
input_lastname=$(echo $names_input | sed 's/, /,/g; s/ /_/g; s/,/ ; /g')

declare -a list=( $input_array )

echo -e $(tput setaf 8)

for name in $input_initials; do
    temp_initial=$(echo "${name:0:1}" | tr '[:lower:]' '[:upper:]')
    initials+=$temp_initial
done

if [ "${#list[@]}" == 0 ]
then
	echo "Nope. Something is wrong."
elif [ "${#list[@]}" == 1 ]
then
    #echo "Single Project!"
    folder_name=$(echo $first_folder)
elif [ "${#list[@]}" == 2 ]
then
	#echo "Double Team!"
	folder_name=$(echo $first_folder)
else
	#echo "Turbo Team!"
	for name in $input_lastname; do
	    temp_lastname=$(echo $name | grep -oE "[^_]+$" | sed 's/;/ - /g')
	    lastnames+=$temp_lastname
	done
	folder_name=$(echo $lastnames)
fi

# Display the directory tree
echo -e $(tput setaf 7)
echo "."
echo $folder_name | sed 's/^/└── /'
echo $(tput setaf 8)"    |"
echo $initials"_bilder" | sed 's/^/    └── /'
echo "    |   |"
echo $initials"_bilder_hohe_qualitaet" | sed 's/^/    |   └── /'
echo "    |   |"
echo $initials"_bilder_webversion" | sed 's/^/    |   └── /'
echo "    |"
echo $initials"_text" | sed 's/^/    └── /'
echo "    |"
echo $initials"_video" | sed 's/^/    └── /'
echo "        |"
echo $initials"_video_hohe_qualitaet" | sed 's/^/        └── /'
echo "        |"
echo $initials"_video_webversion" | sed 's/^/        └── /'

# Build the folder structure
mkdir -p "$folder_name"/{"$initials"_bilder/{"$initials"_bilder_hohe_qualitaet,"$initials"_bilder_webversion},"$initials"_text,"$initials"_video/{"$initials"_video_hohe_qualitaet,"$initials"_video_webversion}}

echo -e $(tput setaf 7)"\n"
echo -e "\n🍺 !\n"