#
# Ubuntu Dockerfile
#
# https://github.com/dockerfile/ubuntu
#

# Pull base image.
FROM ubuntu:14.04

# Install.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git htop man unzip vim wget mercurial libssl-dev libsqlite3-dev openssl

# Add files.

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

RUN hg clone https://hg.python.org/cpython -r v2.7.10

RUN set -x \
    && cd /root/cpython/ \
    && ./configure \
    && make \
    && make install \
    && python -m ensurepip \
    && pip install pip --upgrade \
    && pip install virtualenv --upgrade \
    && pip install openpyxl \
    && pip install pysqlite \
    && rm -rf /root/cpython/.hg \
    && cd /root/ \
    && wget http://www.tdcj.state.tx.us/documents/High_Value_Data_Sets.xlsx 

# Define default command.
CMD ["bash"]
