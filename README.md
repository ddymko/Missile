# Missile
This is a cli app that allows you to do single command deployments from your local environment to your remote environment

###Getting started

Note the following guide is currently only for linux/mac os

Currently you can download a zip of the project from this repo (rubygem will be coming soon)

Once it is download open up your favorite terminal and go to where it is located and unzip the file and run the following commands
```
mv Missile-master /usr/local/lib/Missile

rm /usr/local/lib/Missile/.gitignore

ln -s /usr/local/lib/Missile/missile.rb /usr/local/bin/missile

source ~/.bash_profile
```

Now you should be able to run missile in terminal by simplying typing in **missile**

###Using missile
If you just type in **missile** you will get a list of avaiable commands

####setting up a project
In order to setup a project configuration simply run the following command

```
missile setup project_name
```
Note* please change project_name to whatever name you want to use
Missile will then prompt you to enter information about this project
* Host - server address
* Username - username for server
* Password - password for server
* Web Path - this is the remote url that your web app is located on your server
* Local path - this is the local path to the project on your machine

Missile then stores the this project configuration to be used whenever needed

####deploying a project
This is what makes missile great - to deploy a project all you have to type in is

```
missile deploy project_name
```
All you have to subsitute here is your *project_name* with the project name you have created whrn running missile setup








