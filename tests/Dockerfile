FROM node:12.16.1-buster-slim

ARG BUILD_NUMBER
ARG GIT_REF

ENV BUILD_NUMBER ${BUILD_NUMBER:-1_0_0}
ENV GIT_REF ${GIT_REF:-dummy}

RUN addgroup --gid 2000 --system appgroup && \
    adduser --uid 2000 --system appuser --gid 2000

# Create app directory
RUN mkdir -p /app
WORKDIR /app

RUN chown -R appuser:appgroup /app
USER 2000

CMD [ "echo", "Test docker image" ]
