# fastRelease

The goal is to break the app into two separate jars, app code and dependency code. The app jar is 
usually much smaller than the dependency jar and allows for quicker releases. The following configuration
is meant to work from a single machine/laptop but can be modified for other environments.

*The following assumes you are trying to deploy a Scala/Playframework app. To adapt to other envoronments
change the main class in the Dockerfile to the appropriate main class.*


#### Get Started

Make sure you can ssh into the production environment! 

1. **deployProd.sh** is the single point of entry and defines your environment. Change the 
following variables depending on your project:

    ```
    host="yousite.com";
    jarRegex="PROJECT NAME-assembly-v1*.jar"  
    ```

2. *releaseProdScript.sh* builds and runs your docker image. This is the place tp set environment 
variables such as postges url and password. 

#### Deploy

1. `chmod +x deployProd.sh`
   - make the deploy script executable if it isn't
2. `./deployProd.sh` 
   - generate your jars (app and dependency)
   - `scp` to prod machine jar only if it's changed!!
   - `scp` Dockerfile and release script
3. `./releaseProdScript.sh`
   - build docker image
   - stop and remove currently running container (this will break the first time since there won't be a running container)
   - start new container from image
   - clean up environment and delete releaseProdScript.sh file (security)

#### Reference
- deployProd.sh: the main deploy script 
- script.sh: contains general functions used during the release
- Dockerfile: the docker configuration to build an image from two jar files
- releaseProdScript.sh: is the single executable that is meant to run on your prod machine. It builds and runs the docker image

#### Next step
Ideally this should be used to deploy multiple environments. You should be able to create 
a `deployStage.sh` that launches to your staging environment.