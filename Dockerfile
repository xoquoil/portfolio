FROM ruby:3.3.5

ENV APP=/app
RUN mkdir -p ${APP}

WORKDIR ${APP}
COPY Gemfile Gemfile.lock ${APP}/

ENV LANK=C.UTF-8
RUN echo 'Asia/Tokyo' > /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata

ENV DEPENDENCY="nodejs libpq-dev libsqlite3-dev libssl-dev libgeos-dev curl less sudo" \
    DEV_DEPENDENCY="build-essential" \
    YARN_VERSION=1.22.4
RUN set -x && \
    curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get update && \
    apt-get install -yq --no-install-recommends ${DEPENDENCY} ${DEV_DEPENDENCY} && \
    bash -c "curl -sL --compressed https://yarnpkg.com/downloads/${YARN_VERSION}/yarn-v${YARN_VERSION}.tar.gz | tee >(tar zx -C /usr/local/ --strip=1 --wildcards yarn*/bin --no-same-owner --no-same-permissions) | tar zx -C /usr/local/ --strip=1 --wildcards yarn*/lib --no-same-owner --no-same-permissions" && \
    bundle install -j4 && \
    apt-get purge -y ${DEV_DEPENDENCY} && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    truncate -s 0 /var/log/*log

COPY . ${APP}

CMD ["bin/rails", "s", "-b", "0.0.0.0"]