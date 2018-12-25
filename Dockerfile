FROM ubuntu:disco

ENV JUDGE_NAME='judger'
ENV JUDGE_KEY='The_key_you_set_in_admin_paneL'
ENV JUDGE_SITE='site'

RUN groupadd -r judge && \
    useradd -r -g judge judge && \
    apt-get dist-upgrade -y && \
    apt-get -y update && \
    apt-get install -y --no-install-recommends python python2.7-dev python3 gcc g++ wget file nano vim git ca-certificates && \
    wget -q -O- https://bootstrap.pypa.io/get-pip.py | python

WORKDIR /judge
RUN apt-get -y autoremove && apt-get clean && \
    git clone https://github.com/schoj/judge /judge --depth=1 && \
    pip install cython && \
    python setup.py develop && \
    pip install . && \
    dmoj-autoconf >> /config.yml && \
    mkdir /problems

ADD startup.sh /

CMD sh /startup.sh
