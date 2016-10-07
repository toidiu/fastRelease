#!/usr/bin/env bash
source script.sh

#------------------Execute
outDst="out"
host="blog.toidiu.com";
jarRegex="blog-assembly-v1*.jar"
currentVersion=$(head build.sbt | grep -o 'v1.*[0-9]')
oldVersion=$(cat $outDst/$host/appVersion)
buildPath=target/scala-2.11
releaseScript="releaseProdScript.sh"

#---make the dir
mkdir -p out/$host


##---remove old jars if the app version has changed
#app_build_version_rm_jar
##---build the jars
#package_jars
##---Only copy jars if they are changed, so that docker can cache (which for ADD, looks at timestamps).
#check_and_copy_files
##---ssh into environment
#ssh_into_host

app_build_version_rm_jar && package_jars && check_and_copy_files && echo "copying releaseScript" && scp $releaseScript root@$host:$releaseScript && ssh -t root@$host "chmod +x $releaseScript" && ssh_into_host
