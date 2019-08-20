ARG MAVEN_JDK_VERSION=latest

FROM maven:${MAVEN_JDK_VERSION}
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
	curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
	echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
	apt-get update && apt-get install --no-install-recommends yarn

# Install Chrome

RUN echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' > /etc/apt/sources.list.d/chrome.list

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -

RUN set -x \
    && apt-get update \
    && apt-get install -y \
        xvfb \
        google-chrome-stable

ADD scripts/xvfb-chrome /usr/bin/xvfb-chrome
RUN ln -sf /usr/bin/xvfb-chrome /usr/bin/google-chrome

ENV CHROME_BIN /usr/bin/google-chrome

# Install firefox

RUN set -x \
    && apt-get update \
    && apt-get install -y \
        pkg-mozilla-archive-keyring

RUN echo 'deb http://security.debian.org/ jessie/updates main' >> /etc/apt/sources.list.d/jessie-updates.list

RUN set -x \
    && apt-get update \
    && apt-get install -y \
        xvfb \
    && apt-get install -y -t \
        jessie-backports \
        firefox-esr

ADD scripts/xvfb-firefox /usr/bin/xvfb-firefox
RUN ln -sf /usr/bin/xvfb-firefox /usr/bin/firefox

ENV FIREFOX_BIN /usr/bin/firefox

COPY package.json /wdio/package.json
COPY yarn.lock /wdio/yarn.lock
WORKDIR /wdio/
RUN yarn
