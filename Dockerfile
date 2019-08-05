ARG JDK_VERSION=latest

FROM jdk:${JDK_VERSION}
USER root

# install nodejs as root
# https://github.com/nodesource/distributions/blob/master/README.md#debinstall
WORKDIR /install/
ARG NODE_VERSION=10
RUN \
    curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - && \
    apt-get update -qqy && \
    apt-get install -qqy gcc g++ make nodejs && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/* && \
	curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - && \
	echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list && \
	sudo apt-get update && sudo apt-get install --no-install-recommends yarn

COPY package.json /wdio/package.json
COPY yarn.lock /wdio/yarn.lock
WORKDIR /wdio/
RUN yarn
