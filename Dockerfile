FROM cgswong/min-jessie:latest

RUN groupadd -r judge && \
    useradd -r -g judge judge
RUN sed -i 's/http.debian.net/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    sed -i 's|security.debian.org/debian-security|mirrors.ustc.edu.cn/debian-security|g' /etc/apt/sources.list && \
    apt-get -y update && \
    apt-get install -y --no-install-recommends python python2.7-dev python3 gcc g++ wget file nano vim && \
    apt-get clean
RUN wget -q --no-check-certificate -O- https://bootstrap.pypa.io/get-pip.py | python && \
    pip install --no-cache-dir pyyaml watchdog cython ansi2html termcolor dmoj && \
    rm -rf ~/.cache
RUN mkdir /problems

COPY . /judge
WORKDIR /judge

ADD config.yml /

CMD dmoj -c /config.yml site
