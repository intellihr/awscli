FROM alpine:latest

ENV REFRESHED_AT 2018-02-14

WORKDIR /root

ADD ./requirements.txt /root/requirements.txt
RUN apk add --no-cache python3 && \
    apk add --no-cache bash && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/python ]; then ln -s python3 /usr/bin/python ; fi && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    pip install -r /root/requirements.txt && \
    rm -r /root/.cache /root/requirements.txt
