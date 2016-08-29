FROM gitlab/gitlab-runner:alpine-v1.5.2

ENV DOCKERIZE_VERSION v0.2.0

ADD https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz /tmp
ADD ./templates/config.toml /templates/config.toml

RUN cd /tmp \
    && tar -C /usr/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm -rf /tmp

ENV GITLAB_CI_CONCURRENT 5
ENV GITLAB_CI_URL ''
ENV GITLAB_CI_TOKEN ''

ENTRYPOINT dockerize -template /templates/config.toml:/etc/gitlab-runner/config.toml gitlab-runner run --user=gitlab-runner --working-directory=/home/gitlab-runner