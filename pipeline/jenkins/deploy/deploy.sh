#!/bin/bash

# This is for setting the variable to the file which is gonna be use
# for transfering to the remote machine
# The value of these echo will be place inside the file "/tmp/.auth"
echo maven-project > /tmp/.auth
echo $BUILD_TAG >> /tmp/.auth
echo $PASS >> /tmp/.auth

# Part 1 - This is from the instruction where we load the "/opt/prod" ssh key file as part of the
# parameters

# What's the happen is that we're gonna transfer the file ".auth" to the remote machine
# This is an ssh copy to my production vm server
# "scp -i /opt/prod" - secure copy and then the "-i" will load the "prod" private for ssh-ing
# to the production vm server
# "/tmp/.auth prod-user@prod.vm:/tmp/.auth" is the file that we want to copy to production vm server
# Note: This command "prod-user@prod.vm" will only work if it's internal server but it it's 
# on other machine then we might use the ip address and it's host

# scp -i /opt/prod /tmp/.auth prod-user@prod.vm:/tmp/.auth
# scp -i /opt/prod ./jenkins/deploy/publish prod-user@prod.vm:/tmp/publish

# This will execute the commands inside the "/tmp/publish" on the production vm server or remote
# machine that will pull, create and deploy an image to container. This can be done using some 
# other tools like aws, kuberneter or swarm

# ssh -i /opt/prod prod-user@prod.vm "/tmp/publish"


# Part 2 - What we want to do is manually loading the "ssh key" file from the "/opt/prod" and use 
# Jenkins for managing that. To do that, we had to install the SSH Agent plugin so that we can 
# just use the Jenkins credential to do the SSH for us. And this is now the command

# Here is for connecting to do the production vm server
scp /tmp/.auth prod-user@prod.vm:/tmp/.auth
scp ./jenkins/deploy/publish prod-user@prod.vm:/tmp/publish
ssh prod-user@prod.vm "/tmp/publish"


