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
  apt-get install -y build-essential libncurses-dev libreadline-dev sqlite3 && \
  apt-get install -y git wget mercurial libssl-dev libsqlite3-dev openssl mysql-client mysql-server && \
  apt-get build-dep -y python-mysqldb

# Add files.
ADD ./convert.py /root/convert.py
ADD ./convert_mysql.py /root/convert_mysql.py

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
    && pip install mysql-python \
    && rm -rf /root/cpython/.hg \
    && cd /root/ \
    && wget http://www.tdcj.state.tx.us/documents/High_Value_Data_Sets.xlsx \
    && service mysql start \
    && python convert_mysql.py 

# Define default command.
CMD ["/bin/bash"]
