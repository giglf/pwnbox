#----------------------------------------------------------------#
# Dockerfile to build a container for binary reverse engineering #
# and exploitation. Suitable for CTFs.                           #
#                                                                #
# See https://github.com/giglf/pwnbox for details.               #
#                                                                #
# To build: docker build -t giglf/pwnbox                         #
#----------------------------------------------------------------#

FROM ubuntu:18.04
MAINTAINER lin.giglf@gmail.com

ENV DEBIAN_FRONTEND noninteractive

RUN sed -i s/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g /etc/apt/sources.list 
RUN dpkg --add-architecture i386
RUN apt-get update && apt-get -y upgrade

#-------------------------------------#
# Install packages from Ubuntu repos  #
#-------------------------------------#
RUN apt-get install -y \
    sudo \
    apt-utils \
    locales \
    build-essential \
    gcc-multilib \
    g++-multilib \
    gdb \
    gdb-multiarch \
    python3-dev \
    python3-pip \
    ipython \
    default-jdk \
    net-tools \
    nasm \
    cmake \
    rubygems \
    ruby-dev \
    vim \
    tmux \
    git \
    binwalk \
    strace \
    ltrace \
    autoconf \
    socat \
    netcat \
    nmap \
    wget \
    tcpdump \
    exiftool \
    squashfs-tools \
    unzip \
    upx-ucl \
    man-db \
    manpages-dev \
    libtool-bin \
    bison \
    gperf \
    libseccomp-dev \
    libini-config-dev \
    libssl-dev \
    libffi-dev \
    libc6-dbg \
    libglib2.0-dev \
    libc6:i386 \
    libc6-dbg:i386 \
    libncurses5:i386 \
    libstdc++6:i386 \
    libc6-dev-i386 \
    zsh \ 
    curl

RUN apt-get -y autoremove
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# update locale to include en_US.UTF-8
RUN locale-gen en_US.UTF-8
RUN update-locale

#-------------------------------------#
# Install stuff from pip repos        #
#-------------------------------------#
RUN python3 -m pip install --upgrade pip
# RUN pip3 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
RUN pip3 install r2pipe \
                 scapy \
                 python-constraint \
                 pycipher \
                 uncompyle6 \
                 pipenv \
                 manticore[native] \
                 ropper

# install pwntools 3
RUN python3 -m pip install --upgrade git+https://github.com/Gallopsled/pwntools.git@dev

# install xortool
RUN python3 -m pip install xortool

# install rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y 
ENV PATH="/root/.cargo/bin:${PATH}"

#-------------------------------------#
# Install stuff from GitHub repos     #
#-------------------------------------#
# install radrare2
# RUN git clone https://github.com/radare/radare2.git /opt/radare2 && \
#     cd /opt/radare2 && \
#     git fetch --tags && \
#     git checkout $(git describe --tags $(git rev-list --tags --max-count=1)) && \
#     ./sys/install.sh  && \
#     make symstall

# install oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install villoc
RUN git clone https://github.com/wapiflapi/villoc.git /opt/villoc 

# install preeny
RUN git clone https://github.com/zardus/preeny.git /opt/preeny && \
    cd /opt/preeny && \
    make

# install libc-database
RUN git clone https://github.com/niklasb/libc-database /opt/libc-database

# install peda
# RUN git clone https://github.com/longld/peda.git /opt/peda

# install gef
RUN git clone https://github.com/hugsy/gef.git /opt/gef

# install pwndbg
# RUN git clone https://github.com/pwndbg/pwndbg.git /opt/pwndbg && \
#     cd /opt/pwndbg && \
#     ./setup.sh

# install libseccomp
RUN git clone https://github.com/seccomp/libseccomp.git /opt/libseccomp && \
    cd /opt/libseccomp && \
    ./autogen.sh && ./configure && make && make install 

# install PinCTF
RUN git clone https://github.com/ChrisTheCoolHut/PinCTF.git /opt/PinCTF && \
    cd /opt/PinCTF && \
    ./installPin.sh 

# install one_gadget
RUN gem install one_gadget

# install seccomp-tools
RUN gem install seccomp-tools

COPY ./rc/* /root/

ENTRYPOINT ["/bin/zsh"]
