ARG ALPINE_VERSION=3.21

FROM alpine:${ALPINE_VERSION} AS ci-formatter

ENV PNPM_HOME="/root/.pnpm"
ENV COMPOSER_PATH="/root/.composer/vendor/bin"
ENV PATH="${COMPOSER_PATH}:${PNPM_HOME}:${PATH}"

RUN apk add --no-cache \
    # install system packages
    php83 php83-tokenizer \
    nodejs pnpm composer && \
    # install formatters
    pnpm add -g prettier && \
    composer global require friendsofphp/php-cs-fixer
