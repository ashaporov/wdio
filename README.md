# jdk-node-wdio
Dockerfile with JDK+maven, NodeJS, and wdio(with ts). Versions are configurable.


## Build

You may build image with desired versions of JDK, Maven and NodeJS:
- **MAVEN_JDK_VERSION**=`3-jdk-8` see available versions - [maven docker image](https://hub.docker.com/_/maven/)
- **NODE_VERSION**=`10` see available version - [Node.js Binary Distributions](https://github.com/nodesource/distributions/blob/master/README.md#debinstall)

### Command Line

`docker build --build-arg NODE_VERSION=10 --build-arg MAVEN_JDK_VERSION=3-jdk-8 -f Dockerfile -t jdk-mvn-node .`

## Browsers

Firefox and Chrome
