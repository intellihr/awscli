FROM alpine:latest

ENV REFRESHED_AT 2017-07-08

RUN apk add --no-cache python3 && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    pip install awscli inflection && \
    rm -r /root/.cache

WORKDIR /root
