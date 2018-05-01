#!/bin/sh

#author : 		Hu jie
#creat time :		2018-04-12
#last update time :	2018-04-12
#
#globale variable definition
CHARACTERSETS='[:alnum:]'
LENGTH=10
FREQUENCY=1

#RETURN code def
E_NOERROR=0
E_ERROR=1
E_ARGSWRONG=2

#function name : usage
#description   : print usage of this script.
function usage() {
	cat<<EOF

usage : $0 [-c|--character-sets CHARACTERSETS][-w|--length LENGTH ] [-n|--frequency][-h|--help]

	-c|--character-sets	POSIX character sets or self definition sets.
	-w|--length 		length of password.
	-h|--help 		print this help.
	-n|--frequency		number of times.	
	POSIX character sets :
		
			[:alnum:]	 	letters and digits
			[:alpha:]		letters
			[:blank:]		space and tab characters
			[:cntrl:]		control characters
			[:digit:]		decimal digits
			[:graph:]		printable characters excluding space
			[:lower:]		lowercase letters (all letters when 'ignorecase' is used)
			[:print:]		printable characters including space
			[:punct:]		punctuation characters
			[:space:]		whitespace characters
			[:upper:]		uppercase letters (all letters when 'ignorecase' is used)
			[:xdigit:]		hexadecimal digits
			[:return:]		the <CR> character
			[:tab:]			the <Tab> character
			[:escape:]		the <Esc> character
			[:backspace:]		the <BS> character

	self definition sets :

			[CHAR1-CHAR2]  or 'qwerty56789)(*&^%$'

default options : -c [:alnum:] -w 10 -n 1

EOF
}

function generateRandomPassword() {
	declare passwd=$(tr -dc "${CHARACTERSETS}" < /dev/urandom | head -c ${LENGTH} )
	if [ ! $? = 0 ]; then
		echo "Error, generator exit code $?"
		exit $E_ERROR
	else
		echo $passwd
	fi
	
}
function parseArguments() {
	declare c_flag=0
	while [ $# -gt 0 ] 
	do
		case $1 in
		-c|--character-sets )
			#shift
			#if [ $c_flag = 1 ] ;then
			#	CHARACTERSETS=(${CHARACTERSETS[@]} $1) 
			#else
			#	c_flag=1
			#	CHARACTERSETS=($1)
			#fi
			#shift
			# i made a mistake here, when tr using deleting, it onlying accept one DELset.
			# so, there is no need append sets to array.	
			shift
			CHARACTERSETS=$1
			shift			
			;;
		-w|--length)
			shift
			LENGTH=$1
			shift			
			;;
		-n|--frequency)
			shift
			FREQUENCY=$1
			shift
			;;
		-h|--help)
			usage
			exit $E_NOERROR	
			;;
		*)
			echo "Unreconized augument."
			exit $E_ARGSWRONG
			;;
		esac				
	done
}

#script entry from here.
parseArguments $*

for ((i = 0; i < FREQUENCY; i++))
do
generateRandomPassword
done
