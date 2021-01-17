FROM archlinux

ENV JUDGE_NAME='judger'
ENV JUDGE_KEY='The_key_you_set_in_admin_paneL'
ENV JUDGE_SITE='site'

RUN pacman-key --init && \
    pacman-key --populate && \
    useradd -r -m judge && \
    #sed -i 's/archive.ubuntu.com/opentuna.cn/g' /etc/apt/sources.list && \
    pacman -Syu --noconfirm python python2 python-pip nano vim git cython && \
    locale-gen

# Extra language configurations. Choose what you want.
RUN pacman -S --noconfirm \
      ghc lua clang julia nodejs coffeescript scala crystal rust \
      pypy pypy3 racket ruby2.6 swi-prolog gcc-ada gnucobol dmd gcc-fortran \
      dart go groovy fpc php ocaml jdk8-openjdk jdk11-openjdk

WORKDIR /judge

RUN git clone https://github.com/schoj/judge /judge --depth=1 && \
    pip install cython && \
    python setup.py install && \
    mkdir /problems

#RUN mkdir -p /home/judge/.cargo/
#ADD .cargo/config /home/judge/.cargo/
#ADD perlanguage/ /tmp/
#WORKDIR /tmp/rust
#RUN chown judge:judge -R /home/judge && \
#    chown judge:judge -R /tmp/rust && \
#    su judge -c 'cargo build'

ADD startup.sh /
