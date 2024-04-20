FROM registry.access.redhat.com/ubi9/nodejs-18-minimal:1 AS builder

WORKDIR /opt/app-root/src

COPY --chown=1001:root . .

RUN mkdir -p /opt/app-root/src/node_modules && \
    ls -lA && \
    npm ci && \
    npm run build

FROM registry.access.redhat.com/ubi9/nodejs-18-minimal:1

LABEL name="ibm/template-node-typescript" \
      vendor="IBM" \
      version="1" \
      release="68" \
      summary="This is an example of a container image." \
      description="This container image will deploy a Typescript Node App"

WORKDIR /opt/app-root/src

COPY --chown=1001:root . .
COPY --from=builder --chown=1001:root /opt/app-root/src/dist dist
RUN chmod -R 755 .

RUN ls -lA && \
    mkdir -p /opt/app-root/src/node_modules && \
    npm ci --only=production

RUN chgrp -R 0 . && \
    chmod -R g=u .

ENV HOST=0.0.0.0 PORT=3000

EXPOSE 3000/tcp

CMD ["npm", "run", "start:prod"]
