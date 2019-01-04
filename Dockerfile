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
    wget -q -O- https://bootstrap.pypa.io/get-pip.py | python

# Extra language configurations. Choose what you want.
RUN apt-get install -y haskell-platform openjdk-11-jdk-headless lua5.3 clang julia nodejs coffeescript&& \
    wget https://downloads.lightbend.com/scala/2.12.8/scala-2.12.8.deb && \
    dpkg -i scala-2.12.8.deb && \
    rm scala-2.12.8.deb && \
    apt-get install -y cargo rustc curl gnupg2 && \
    curl -sL "https://keybase.io/crystal/pgp_keys.asc" | apt-key add - && \
    echo "deb https://dist.crystal-lang.org/apt crystal main" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y crystal

WORKDIR /judge

RUN apt-get autoremove -y && apt-get clean && \
    git clone https://github.com/schoj/judge /judge --depth=1 && \
    pip install cython && \
    python setup.py develop && \
    pip install . && \
    mkdir /problems

RUN mkdir -p /home/judge/.cargo/
ADD .cargo/config /home/judge/.cargo/
ADD perlanguage/ /tmp/
WORKDIR /tmp/rust
RUN chown judge:judge -R /home/judge && \
    chown judge:judge -R /tmp/rust && \
    su judge -c 'cargo build'

ADD startup.sh /

