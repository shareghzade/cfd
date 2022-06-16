#!/bin/bash

# with this program you can create file and directory
# you can just run the programm and it will prompt you
# or you can use the arguments
# ./cfd.sh file <file_name>
# ./cfd.sh dir <dir_name>


# with this if statement user can't run the program as root
if [[ $EUID -eq 0 ]]; then
	echo -e "\n\e[31mDon't Run This as Root\n"
	exit 1
fi


# for create file or directory throw command line arguments
# Example:
# ./cfd.sh file <file_name>
# ./cfd.sh dir <dir_name>

if [[ $1 == "file" ]] && [[ -n $2 ]]; then # -n means not empty. if $2 is empty will go to else condition
	touch ${2}
	echo -e "\n\e[32mFile ${2} Created\n"
elif [[ $1 == "dir" ]] && [[ -n $2 ]]; then
	mkdir -p ${2}
	echo -e "\n\e[32mDirectory ${2} Created\n"
else
	read -p "Do you want file or directory? file/dir: " cfd
	case ${cfd} in
		file | File | FILE | FiLe | fIlE | f | F | fil | Fil)

			read -p "Please Enter File Name: " filename
			while [[ -e ${filename} ]]
			do
				echo -e "\n\e[31m'${filename}' File Exists\n\e[0m"
				read -p "Please Enter File Name: " filename
			done
			while [[ -z ${filename} ]]
			do
				echo -e "\n\e[31mYou Have to Enter the Name\n\e[0m"
				read -p "Please Enter File Name: " filename
			done
			touch ${filename}
			echo -e "\n\e[32mFile '${filename}' Created\n"
			;;
		dir | Dir | DIR | directory | Directory | DIRECTORY | d | D)

			read -p "Please Enter Directory Name: " dirname
			while [[ -d ${dirname} ]]
			do
				echo -e "\n\e[31m'${dirname}' Directory Exists\n\e[0m"
				read -p "Please Enter Directory Name: " dirname
			done
			while [[ -z ${dirname} ]]
			do
				echo -e "\n\e[31mPlease Enter Directory Name\n\e[0m"
				read -p "Please Enter Directory Name: " dirname
			done
				mkdir -p ${dirname} # -p let you to create multiple directory in a row. example: /test1/test2/test3
				echo -e "\n\e[32mDirectory '${dirname}' Created\n\e[0m"
			;;

		*)
			# this will echo if user doesn't input anything and hit enter
			echo -e "\n\e[32mUsage:\n\tbash $0 file <file_name>\n\tbash $0 dir <dir_name>\n\n\tor\n\n\t${0} file <file_name>\n\t${0} dir <dir_name>"

	esac
fi
