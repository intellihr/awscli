FROM alpine:latest

ENV REFRESHED_AT="2019-11-11" \
    BUILD_DEPS="gettext" \
    RUNTIME_DEPS="libintl" \
    SSM_ENV_VERSION="0.0.3" \
    AWS_REGION="ap-southeast-2"

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
    rm -r /root/.cache /root/requirements.txt && \
    wget -O /usr/local/bin/ssm-env https://github.com/remind101/ssm-env/releases/download/v${SSM_ENV_VERSION}/ssm-env && \
    echo 'da4bac1c1937da4689e49b01f1c85e28  /usr/local/bin/ssm-env' | md5sum -c && \
    chmod +x /usr/local/bin/ssm-env

ENTRYPOINT ["/usr/local/bin/ssm-env", "-with-decryption"]
CMD ["/bin/sh"]
