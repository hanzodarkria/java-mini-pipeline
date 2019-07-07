#!/bin/bash

echo "***************************"
echo "** Building jar ***********"
echo "***************************"

# This is the cloned repository from the Jenkins SCM pipefile which will be placed in the "workspace" direcotory
# inside the "Jenkins" container. But all the content of that container is mounted to our local server
WORKSPACE=/home/jenkins/jenkins_home/workspace/pipeline-docker-maven

# command below is for running the image maven, mount the workspace and .m2 dir and executure a maven command
# that will bundle the library and will create a .jar file
# origin line for running the command is 
# `docker run --rm -v $PWD/java-app:/app -v /root/.m2/:/root/.m2/ -w /app maven:3-alpine mvn -B -DskipTests clean package`
# 1. "docker run --rm" - means run and create the container as well as remove it after it's done
# 2. "-v $PWD/java-app:/app" - means mount a volume from "$PWD/java-app" to "/app" so that they'll have same content(which has the .pom file for building the package using mvn command)
# 3. "-v /root/.m2/:/root/.m2/" - means mount the volume to have same content
# 4. "-w /app" - on start of the container, directly go to dir "/app" where the java files are in because of mounted volume
# 5. "maven:3-alpine" - is the image being use for "docker run" that'll create the image and container(for a while)
# 6. "mvn -B -DskipTests clean package" - finally is command that will package the java files using mvn command which will look for the ".pom" file
# 7. After all that, the package files which is ".jar" file will be stored in the "$PWD/java-app/target/" directory
# "$@" - means it will accept any/all parameters
# To execute this file is
# `mvn.sh mvn -B -DskipTests clean package` - and here we just pass the parameters for packaging the java files

docker run --rm  -v  $WORKSPACE/java-app:/app -v /root/.m2/:/root/.m2/ -w /app maven:3-alpine "$@"
