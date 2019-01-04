FROM ubuntu:disco

ENV JUDGE_NAME='judger'
ENV JUDGE_KEY='The_key_you_set_in_admin_paneL'
ENV JUDGE_SITE='site'

RUN groupadd -r judge && \
    useradd -r -g judge judge && \
    sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    apt-get dist-upgrade -y && \
    apt-get -y update && \
    apt-get install -y --no-install-recommends python python2.7-dev python3 gcc g++ wget file nano vim git ca-certificates && \
    wget -q -O- https://bootstrap.pypa.io/get-pip.py | python && \
    apt-get autoremove -y && apt-get clean

WORKDIR /judge
RUN git clone https://github.com/schoj/judge /judge && \
# We have a mirror here. Faster but not so up-to-date.
#   git clone https://git.dev.tencent.com/outloudvi/schoj-judge /judge --depth=1 && \
    pip install cython && \
    python setup.py develop && \
    pip install . && \
    mkdir /problems

ADD startup.sh /

CMD sh /startup.sh
