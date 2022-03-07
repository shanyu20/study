#!/bin/sh

cat << EOF
Please select the operation:
	1) build main application
	2) clean main application
	3) distclean main application
	4) package for firmware
EOF

echo -n "input: "
read operation
case $operation in
	1)
		echo "select build"
		;;
	2)
		echo "select clean"
		;;
	3)
		echo "select distclean"
		;;
	4)
		echo "select package"
		;;
	*)
		;;
esac

echo "bye bye ......"
