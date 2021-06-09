#!/bin/bash
PackageRef='PackageReference'
MinVersions=`cat /version_list.txt`
ChecksCount=${#MinVersions[@]}

FILES=$(find -type f -name '*.csproj')

for file in $FILES; do
  for (( i=0; i<$ChecksCount; i+=2 ));
  do
    Reference='"'${MinVersions[i]}'"'
    echo Reference=$Reference
    found=$(grep $PackageRef $file | grep $Reference)
    #if [ "$found" ]; then
    #  RefMinVersion=${MinVersions[i+1]}
    #  ArrRefMinVersion=(${RefMinVersion//./ })
    #  ArrRefMinVersionLen=${#ArrRefMinVersion[@]}
    #  RefVersion=$(echo $found | grep -o 'Version="[0-9.]*"' | grep -o '[0-9.]*')
    #  ArrRefVersion=(${RefVersion//./ })
    #  ArrRefVersionLen=${#ArrRefVersion[@]}
    #  MinLen=$(( $ArrRefMinVersionLen > $ArrRefVersionLen ? $ArrRefVersionLen : $ArrRefMinVersionLen ))
    #  for (( j=0; j<$MinLen; j++ ));
    #  do
    #    if [ ${ArrRefMinVersion[j]} -eq ${ArrRefVersion[j]} ]; then
    #      continue
    #    elif [ ${ArrRefMinVersion[j]} -lt ${ArrRefVersion[j]} ]; then
    #      break
    #    elif [ ${ArrRefMinVersion[j]} -gt ${ArrRefVersion[j]} ]; then
    #      echo "Found a reference to $Reference in $file that has lower version than $RefMinVersion"
    #      exit 1
    #    fi
    #  done
    #fi
  done
done
