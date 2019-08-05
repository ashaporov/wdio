# jdk-node-wdio
Dockerfile with JDK, NodeJS and wdio(with ts). Versions are configurable.

## Build

You may build image with desired versions of JDK and NodeJS:
- **JDK_VERSION**=`8u192-zulu-alpine` see available versions - [Java SE JDK docker images](https://hub.docker.com/_/microsoft-java-jdk)
- **NODE_VERSION**=`10` see available version - [Node.js Binary Distributions](https://github.com/nodesource/distributions/blob/master/README.md#debinstall)

### Examples

#### Command Line

`docker build --build-arg NODE_VERSION=10 --build-arg JDK_VERSION=8u192-zulu-alpine -f Dockerfile -t jdk-node-wdio .`
