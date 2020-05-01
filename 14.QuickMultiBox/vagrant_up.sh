#!/bin/bash
main (){
# setting #####################
unset false
true=1
isError=$false
###############################

# Variables
scriptExcutionPath=$(pwd)
thePath=${BASH_SOURCE[0]}
sourceFile=$(pwd)/$thePath
sourcePath=`echo $(dirname $sourceFile)|sed "s/\/\.\//\//g"|sed "s/\/\.//g"`
configPath=$sourcePath/config
prebuildPath=$sourcePath/prebuild

originalImage=`cat $configPath/orignalImage.txt` 
baseImage=`cat  $configPath/baseImage.txt` 

# echo sourceFile     = $sourceFile
# echo sourcePath     = $sourcePath
# echo configPath     = $configPath
# echo originalImage  = $originalImage
# echo baseImage      = $baseImage

# Base Image Build
x=$(vagrant box list|awk '{print $1}'|grep $baseImage)
if [ ${#x} -eq 0 ];then 
    cd $prebuildPath
    vagrant up
    x=$(vagrant status |grep prebuild|grep running)
    if [ ${#x} -eq 0 ];then 
        isError=$true
        errorMsg="Message : prebuild fail."
        return
    else
        vagrant package --output=/tmp/prebuild.box
        vagrant destroy -f;rm -rf .vagrant/ 
        vagrant box add $baseImage /tmp/prebuild.box
        rm -f /tmp/prebuild.box
    fi    
fi

x=$(vagrant box list|awk '{print $1}'|grep $baseImage)
if [ ${#x} -eq 0 ];then 
    echo --------------------------------------------------------------------------------
    echo "Change below path and debug it. "
    echo $prebuildPath
    echo --------------------------------------------------------------------------------
    isError=$true
    errorMsg="Message : Prebuild fail. "
    return
else
    cd $sourcePath
    vagrant up
fi 

# var=$(command)
# echo -------- $var 






cd $scriptExcutionPath

# if [ ${#x} -eq 0 ];then
#     isError=$true
#     errorMsg="Message : error "
#     return
# fi


}

main "$@"

if [ $isError ]; then
    echo ---------------------------------------------------------------------------
    echo -------------- Error Message-----------------------------------------------
    echo $errorMsg
    echo ---------------------------------------------------------------------------
    cd $scriptExcutionPath
fi





# cf
# baseImage=generic/ubuntu1804
# newImage=nowage/$(echo "generic/ubuntu1804"|sed 's/\//_/g')









