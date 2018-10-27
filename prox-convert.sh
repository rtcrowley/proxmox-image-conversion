#!/bin/bash

# color
cyn='\033[0;36m'
noco='\033[0m'

br=$(echo -e ${cyn}"----------------------------ova to qcow2-------------------------------"${noco})

usage=$(
    echo -e ${cyn}"--------------------------------Usage----------------------------------"${noco}
    echo "-f = Location of image you'd like to convert"
    echo "-p = Proxmox VM number where converted image is to be palced"
    echo "     First, you must create a new blank VM via the GUI"
    echo "-n = New image name w/o extension. eg: coolVM"
    echo "$br")

if [ -z "$1" ] || [[ "$1" != "-"* ]]; then
        echo "${usage}"
        exit 1
fi

while getopts ':f:p:n:' flag; do
  case "${flag}" in

    f)  f="${OPTARG}"
        ;;
    p)  p="${OPTARG}"
        ;;
    n)  n="${OPTARG}"
        ;;
  esac
done
shift $((OPTIND - 1))
echo "$br"
check=$(ls /var/lib/vz/images/${p}/ |wc -l)
a=1
if [ "$check" -gt "$a" ]; then
  echo "Are you sure you have the correct Proxmox VM  Number?"
  echo "Only 1 file should be in /var/lib/vz/images/${p}/"
  echo "Closing...."
  exit
fi
echo -e ${cyn}"Creating working dir and unzipping..."${noco}
wdir=$(echo "${n}-working")
mkdir ${wdir}
cp ${f} ${wdir}
cd ${wdir}
mv ${f} ${n}.tgz
tar xvf *.tgz
echo -e ${cyn}"Converting to qcow2.."${noco}
# .ova to qcow2 size is about double
qemu-img convert -f vmdk *.vmdk -O qcow2 ${n}.qcow2
echo -e ${cyn}"Conversion complete, moving to /var/lib/vz/${p}/..."${noco}
mv *.qcow2 /var/lib/vz/images/${p}/*
echo -e ${cyn}"Move complete, deleting working fies and folder..."${noco}
cd ..
rm -rf ${wdir}
echo -e ${cyn}"Done"${noco}
echo -e ${cyn}"-------------------------converter complete----------------------------"${noco}
