#!/usr/bin/env bash

function copy_if_changed {
    # shorten name of the jars to 'app.jar' and 'dep.jar'
    if [[ $1 == *"deps"* ]]
    then
        local to_name="dep.jar"
    else
        local to_name="app.jar"
    fi

    local path_from="$1"
    local path_to="$2/$to_name"

    # calculate md5 of 'from' file
    local md5_from=$(md5 -q $path_from)

    # check and calculate md5 of 'to' file
    if [ -e $path_to ]
    then
        local md5_to=$(md5 -q $path_to)
    else
        local md5_to=""
    fi

    # compare md5 and check if we need to copy file
    if [ "q$md5_from" = "q$md5_to" ];
    then
        echo "$1 not changed, not copying------"
    else
        echo "$1 changed, copying------"
        cp $path_from $path_to
        scp $path_to root@$host:$to_name
    fi
}

function remove_jars {
    local jarjar=( $buildPath/$jarRegex )
    for jar in ${jarjar[@]}
    do
        rm $jar
    done
}

function app_build_version_rm_jar {
    if [ "$currentVersion" = "$oldVersion" ]
      then
        echo "same app version--------"
    else
        echo "version of app has changed, delete jars--------"
        remove_jars
    fi

    #---print current app version to a file within out dir
    echo $currentVersion > $outDst/$host/appVersion
}

function package_jars {
    sbt assembly assemblyPackageDependency
}

function check_and_copy_files {
    #---Only copy jars if they are changed, so that docker can cache (which for ADD, looks at timestamps).
    jars=( $buildPath/$jarRegex )
    for jar in ${jars[@]}
    do
        copy_if_changed $jar out/$host
    done

    #---Copy the Dockerfile
    echo "copying Dockerfile"
    scp Dockerfile root@$host:Dockerfile
}

function ssh_into_host {
    ssh root@$host
}