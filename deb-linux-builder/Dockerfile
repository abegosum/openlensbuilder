FROM node:16-bullseye

LABEL maintainer="Aaron M. Bond <abond@mpr.org>"

ARG OUT_PATH=/opt/dist
ARG BUILD_PATH=/opt/build
ARG BUILD_USER=lensbuilder
ARG BUILD_GROUP=lensbuilder
ARG APP_USER_UID=8000
ARG APP_GROUP_GID=8000

RUN apt-get update && apt-get install git jq rpm -y && \
  mkdir -p ${BUILD_PATH} && \
  groupadd -g ${APP_GROUP_GID} ${BUILD_GROUP} && \
  useradd -l -u ${APP_USER_UID} -g ${BUILD_GROUP} ${BUILD_USER} -d ${BUILD_PATH} && \
  chown ${BUILD_USER}:${BUILD_GROUP} ${BUILD_PATH} && \
  corepack enable

COPY entrypoint.sh /usr/bin/entrypoint.sh

RUN chmod 755 /usr/bin/entrypoint.sh

USER ${BUILD_USER}

ENV ELECTRON_BUILDER_EXTRA_ARGS="--linux AppImage --linux deb" 

CMD /usr/bin/entrypoint.sh
