# About

Pwnbox is a Docker container with tools for binary reverse engineering and exploitation. It's primarily geared towards Capture The Flag competitions. 

This branch is for lighter use of docker only through docker desktop.

Because docker machine has been removed from later versions of Docker Desktop. Your going to need the docker-toolbox package.

[https://stackoverflow.com/questions/60078434/docker-machine-command-not-found](https://stackoverflow.com/questions/60078434/docker-machine-command-not-found)

## Note

This branch is for my own use. So i delete/modify many things so that he becomes what i like.

You can checkout to master for the original.

∠( ᐛ 」∠)＿

## Build

`docker build -t giglf/pwnbox .`

## Usage

### First: create docker container

`docker create -p 23946:23946 --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -it -v ~/Workbench:/share --name="pwnbox" giglf/pwnbox`

`-p 23946:23946`: Export 23946 port for host debugging executable in container using IDA.
`--cap-add=SYS_PTRACE --security-opt seccomp=unconfined`: For gdb debugging in container. Check [https://stackoverflow.com/questions/35860527/warning-error-disabling-address-space-randomization-operation-not-permitted](https://stackoverflow.com/questions/35860527/warning-error-disabling-address-space-randomization-operation-not-permitted) for more information.
`~/Workbench:/share`: Mount my workbench to `/shared` folder. So that I can access file in my host.

### Second: run the container

`docker start -ai pwnbox`


### Go forth, and CTF 
•_•)

( •_•)>⌐■-■

(⌐■_■)
