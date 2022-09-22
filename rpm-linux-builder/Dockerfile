FROM almalinux:8

LABEL maintainer="Aaron M. Bond <abond@mpr.org>"

ARG OUT_PATH=/opt/dist
ARG BUILD_PATH=/opt/build
ARG BUILD_USER=lensbuilder
ARG BUILD_GROUP=lensbuilder
ARG APP_USER_UID=8000
ARG APP_GROUP_GID=8000

RUN dnf upgrade -y && dnf module install -y nodejs:16 && \
  dnf install -y gcc gcc-c++ kernel-devel make jq git rpm-build python39 && \
  npm install --global yarn corepack && \
  mkdir -p ${BUILD_PATH} && \
  groupadd -g ${APP_GROUP_GID} ${BUILD_GROUP} && \
  useradd -l -u ${APP_USER_UID} -g ${BUILD_GROUP} ${BUILD_USER} -d ${BUILD_PATH} && \
  chown ${BUILD_USER}:${BUILD_GROUP} ${BUILD_PATH} 

RUN corepack enable

COPY entrypoint.sh /usr/bin/entrypoint.sh

RUN chmod 755 /usr/bin/entrypoint.sh

USER ${BUILD_USER}

ENV ELECTRON_BUILDER_EXTRA_ARGS="--linux rpm" 

CMD /usr/bin/entrypoint.sh
