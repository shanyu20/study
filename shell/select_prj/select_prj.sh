#!/bin/bash

cat << EOF
Welcome to select the project:
	PROJ_A:	project for A
	PROJ_B: project for B
	PROJ_C: project for C
EOF

echo "Please select project to build:"
select project in PROJ_A PROJ_B PROJ_C
do
	echo $project
	case $project in
		PROJ_A)
			echo "select project A"
			break
			;;
		PROJ_B)
			echo "select project B"
			break
			;;
		PROJ_C)
			echo "select project C"
			break
			;;
	esac
done

echo "bye bye......"
			
