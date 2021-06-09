#!/bin/bash
PackageRef="PackageReference"
#cat /version_list.txt
MinVersionsString=`cat /version_list.txt`
MinVersions=($MinVersionsString)
ChecksCount=${#MinVersions[@]}

FILES=$(find -type f -name '*.csproj')

#grep -rn PackageReference ./

for file in $FILES; do
  echo file=$file
  for (( i=0; i<$ChecksCount; i+=2 ));
  do
    #Reference='"'${MinVersions[i]}'"'
    Reference=${MinVersions[i]}
    echo i=$i, Reference=\'$Reference\'
    found=$(grep $PackageRef $file | grep $Reference)
    #echo grep $PackageRef $file grep $Reference
    #grep $PackageRef $file
    if [ "$found" ]; then
      RefMinVersion=${MinVersions[i+1]}
      #echo RefMinVersion=$RefMinVersion
      ArrRefMinVersion=(${RefMinVersion//./ })
      ArrRefMinVersionLen=${#ArrRefMinVersion[@]}
      RefVersion=$(echo $found | grep -o 'Version="[0-9.]*"' | grep -o '[0-9.]*')
      echo CurrentVersion=$RefVersion
      ArrRefVersion=(${RefVersion//./ })
      ArrRefVersionLen=${#ArrRefVersion[@]}
      MinLen=$(( $ArrRefMinVersionLen > $ArrRefVersionLen ? $ArrRefVersionLen : $ArrRefMinVersionLen ))
      for (( j=0; j<$MinLen; j++ ));
      do
        if [ ${ArrRefMinVersion[j]} -eq ${ArrRefVersion[j]} ]; then
          echo ${ArrRefMinVersion[j]} -eq ${ArrRefVersion[j]}
          continue
        elif [ ${ArrRefMinVersion[j]} -lt ${ArrRefVersion[j]} ]; then
          echo ${ArrRefMinVersion[j]} -lt ${ArrRefVersion[j]}
          break
        elif [ ${ArrRefMinVersion[j]} -gt ${ArrRefVersion[j]} ]; then
          echo ${ArrRefMinVersion[j]} -gt ${ArrRefVersion[j]}
          echo "Found a reference to $Reference in $file that has lower version than $RefMinVersion"
          exit 1
        fi
      done
    fi
  done
done
