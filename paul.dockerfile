ARG TAG=latest

FROM cnarf/buster:${TAG}

LABEL maintainer="cnarf@charline"
LABEL description="paul"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get install -y \
   make \
   g++-8 libstdc++6-8-dbg gcc-8-locales libgomp1-dbg libitm1-dbg libatomic1-dbg libasan5-dbg liblsan0-dbg libtsan0-dbg libubsan1-dbg libmpx2-dbg libquadmath0-dbg \
   clang-6.0 llvm-6.0-dev \
   lcov \
   openssh-server \
&& apt-get autoremove --purge -y \
&& apt-get clean \
&& /root/finalize.sh;


# RUN echo paul > /etc/hostname; \
# sshd
RUN mkdir /var/run/sshd;

EXPOSE 22

# TODO shell
# user
RUN useradd --create-home user \
&& echo user:user | chpasswd;


CMD /usr/sbin/sshd -D
