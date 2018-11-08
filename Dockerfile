FROM cgswong/min-jessie:latest

RUN groupadd -r judge && \
    useradd -r -g judge judge
RUN apt-get -y update && \
    apt-get install -y --no-install-recommends python python2.7-dev python3 gcc g++ wget file nano vim && \
    apt-get clean
RUN wget -q --no-check-certificate -O- https://bootstrap.pypa.io/get-pip.py | python && \
    pip install --no-cache-dir pyyaml watchdog cython ansi2html termcolor dmoj && \
    rm -rf ~/.cache
RUN mkdir /problems

ADD config.yml /
RUN dmoj-autoconf -s >> /config.yml

CMD dmoj -c /config.yml site
