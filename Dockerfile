FROM alpine:latest

WORKDIR /tmp/build

ENV runDependencies curl jq bash libintl
ENV buildDeps gettext
ENV kubectlURL https://storage.googleapis.com/kubernetes-release/release/v1.8.4/bin/linux/amd64/kubectl

RUN apk --no-cache add ${runDependencies} && \
    apk --no-cache add --virtual build_deps ${buildDeps} && \
    curl -L -o /usr/local/bin/kubectl ${kubectlURL} && \
    chmod +x /usr/local/bin/kubectl && \
    cp /usr/bin/envsubst /usr/local/bin/envsubst && \
    apk del build_deps

ADD bin/* /opt/resource/

CMD /usr/local/bin/kubectl
