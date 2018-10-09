FROM gocd/gocd-server:v18.7.0

ENV AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION
ENV AWS_ACCESS_KEY=$AWS_ACCESS_KEY
ENV AWS_SECRET_KEY=$AWS_SECRET_KEY
ENV AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY

RUN apk -v --update add \
        python \
        py-pip \
        groff \
        less \
        mailcap \
        unzip \
        && pip install --upgrade awscli python-magic \
        && apk -v --purge del py-pip \
        && rm /var/cache/apk/*

ADD plugins.sh /docker-entrypoint.d/plugins.sh
ADD plugins.MD5 /godata/plugins/external/plugins.MD5
