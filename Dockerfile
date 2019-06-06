FROM alpine:latest

ENV REFRESHED_AT="2019-06-06" \
    BUILD_DEPS="gettext" \
    RUNTIME_DEPS="libintl"

WORKDIR /root

ADD ./requirements.txt /root/requirements.txt
RUN set -x && \
    apk add --update --no-cache python3 bash zip ${RUNTIME_DEPS} && \
    apk add --virtual build_deps ${BUILD_DEPS} && \
    cp /usr/bin/envsubst /usr/local/bin/envsubst && \
    apk del build_deps && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/python ]; then ln -s python3 /usr/bin/python ; fi && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    pip install -r /root/requirements.txt && \
    rm -r /root/.cache /root/requirements.txt
