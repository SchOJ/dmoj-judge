FROM ubuntu:disco

RUN groupadd -r judge && \
    useradd -r -g judge judge && \
    sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    apt dist-upgrade -y && \
    apt-get -y update && \
    apt-get install -y --no-install-recommends python python2.7-dev python3 gcc g++ wget file nano vim git ca-certificates && \
    wget -q -O- https://bootstrap.pypa.io/get-pip.py | python

# Extra language configurations. Choose what you want.
RUN apt-get install -y ghc openjdk-11-jre-headless lua5.3 && \
    wget https://downloads.lightbend.com/scala/2.12.8/scala-2.12.8.deb && \
    dpkg -i scala-2.12.8.deb && \
    rm scala-2.12.8.deb && \
    apt-get install -y cargo rustc curl gnupg2 && \
    curl -sSL https://dist.crystal-lang.org/apt/setup.sh | bash && \
    apt-get install -y crystal

WORKDIR /judge
RUN apt-get clean && \
    git clone https://github.com/schoj/judge /judge && \
    pip install cython && \
    python setup.py develop && \
    pip install .

RUN mkdir /problems

ADD config.yml /

CMD su judge -c 'dmoj -c /config.yml site'
