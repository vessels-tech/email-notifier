FROM node:12.16.1-alpine as builder
USER root

WORKDIR /opt/email-notifier

RUN apk --no-cache add git
RUN apk add --no-cache -t build-dependencies make gcc g++ python libtool autoconf automake \
    && cd $(npm root -g)/npm \
    && npm config set unsafe-perm true \
    && npm install -g node-gyp

COPY package.json package-lock.json* /opt/email-notifier/
RUN npm install

COPY src /opt/email-notifier/src
COPY config /opt/email-notifier/config
COPY app.js /opt/email-notifier/
COPY templates /opt/email-notifier/templates

FROM node:12.16.1-alpine

WORKDIR /opt/email-notifier

# Create empty log file & link stdout to the application log file
RUN mkdir ./logs && touch ./logs/combined.log
RUN ln -sf /dev/stdout ./logs/combined.log

# Create a non-root user: ml-user
RUN adduser -D ml-user 
USER ml-user

COPY --chown=ml-user --from=builder /opt/email-notifier .
RUN npm prune --production

EXPOSE 3081
CMD node app.js