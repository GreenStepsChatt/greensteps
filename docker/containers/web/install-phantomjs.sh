#!/bin/bash

export PHANTOMJS_VERSION=2.1.1

cd /usr/local/share && \
wget https://github.com/Medium/phantomjs/releases/download/v2.1.1/phantomjs-${PHANTOMJS_VERSION}-linux-x86_64.tar.bz2 && \
tar xvf phantomjs-${PHANTOMJS_VERSION}-linux-x86_64.tar.bz2 && \
rm phantomjs-${PHANTOMJS_VERSION}-linux-x86_64.tar.bz2 && \
ln -s /usr/local/share/phantomjs-${PHANTOMJS_VERSION}-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs

phantomjs --version
