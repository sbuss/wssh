FROM phusion/baseimage:0.9.17

RUN rm -f /etc/service/sshd/down

RUN apt-get update && \
    apt-get install -y python-dev python-pip

# These packages are slow
RUN pip install gevent==1.1a1
RUN pip install gevent-websocket

WORKDIR /srv
COPY requirements-server.txt /srv/
COPY requirements-client.txt /srv/

COPY setup.py /srv/
COPY bin /srv/bin
COPY wssh /srv/wssh
COPY examples /srv/examples

RUN pip install -r requirements-server.txt
RUN pip install -r requirements-client.txt
RUN python setup.py install
