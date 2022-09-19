# docker build -t pwnroom:ubuntu

# docker run --rm -v $HOME/PWNROOM:/share --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -d --hostname pwnroom --name pwnroom -i pwnroom:ubuntu

## run with:
# docker exec -it pwnroom /bin/bash
## or start with after being stopped:
# docker container start pwnroom

FROM ubuntu
ENV LC_CTYPE C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

RUN dpkg --add-architecture i386 && apt-get update

RUN apt-get -y install software-properties-common build-essential tmux git wget strace ltrace curl wget rubygems gcc dnsutils netcat gcc-multilib net-tools neovim gdb gdb-multiarch python3 python3-pip libssl-dev libffi-dev make procps libpcre3-dev libdb-dev libxt-dev libxaw7-dev libc6:i386 libncurses5:i386 libstdc++6:i386

RUN apt-add-repository ppa:pwntools/binutils

RUN pip3 install pwntools keystone-engine unicorn capstone ropper
RUN mkdir tools && cd tools && git clone https://github.com/JonathanSalwan/ROPgadget
RUN git clone https://github.com/radare/radare2 && cd radare2 && sys/install.sh && \
cd .. && git clone https://github.com/pwndbg/pwndbg && cd pwndbg && ./setup.sh && \
gem install one_gadget