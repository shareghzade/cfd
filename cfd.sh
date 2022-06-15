#!/bin/bash

# this program will create file for you
# and if file does exists its not gonna create it
# you can create only files not directories



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

			if [[ -e ${filename} ]]; then # check if file already exists
				echo -e "\n\e[31m'${filename}' File Exists\n"
			elif [[ -z ${filename} ]]; then # check if user sending empty input
				echo -e "\n\e[31mPlease Enter File Name\n"
				exit 1
			else # if everything was ok it will create the file
				touch ${filename}
				echo -e "\n\e[32mFile '${filename}' Created\n"
			fi
			;;

		dir | Dir | DIR | directory | Directory | DIRECTORY | d | D)

			read -p "Please Enter Directory Name: " dirname

			if [[ -d ${dirname} ]]; then # check if file exists and its a directory
				echo -e "\n\e[31m'${dirname}' Directory Exists\n"
			elif [[ -z ${dirname} ]]; then # check if user sending empty input
				echo -e "\n\e[31mPlease Enter Directory Name\n"
				exit 1
			else # if everything was ok it will create the file
				mkdir -p ${dirname} # -p let you to create multiple directory in a row. example: /test1/test2/test3
				echo -e "\n\e[32mDirectory '${dirname}' Created\n"
			fi
			;;

		*)
			# this will echo if user doesn't input anything and hit enter
			echo -e "\n\e[32mUsage:\n\tbash $0 file <file_name>\n\tbash $0 dir <dir_name>\n\n\tor\n\n\t${0} file <file_name>\n\t${0} dir <dir_name>"

	esac

fi
