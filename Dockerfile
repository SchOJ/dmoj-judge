FROM ubuntu:18.04

ENV JUDGE_NAME='judger'
ENV JUDGE_KEY='The_key_you_set_in_admin_paneL'
ENV JUDGE_SITE='site'

RUN groupadd -r judge && \
    useradd -r -g judge judge && \
    sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    apt-get dist-upgrade -y && \
    apt-get -y update && \
    apt-get install -y --no-install-recommends python python3-dev python3 gcc g++ wget file nano vim git ca-certificates python3-pip build-essential libseccomp-dev python3-setuptools && \
    apt-get autoremove -y && apt-get clean

WORKDIR /judge
RUN git clone https://github.com/DMOJ/judge-server /judge --depth=1
RUN pip3 install wheel && \
    pip3 install -r requirements.txt -i https://mirrors.ustc.edu.cn/pypi/web/simple
RUN python3 setup.py develop && \
    mkdir /problems

ADD startup.sh /

CMD sh /startup.sh
