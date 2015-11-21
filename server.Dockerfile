FROM phusion/baseimage:0.9.17

RUN rm -f /etc/service/sshd/down

RUN apt-get update && \
    apt-get install -y python-dev python-pip

# These packages are slow
RUN pip install gevent==1.1a1
RUN pip install gevent-websocket

WORKDIR /srv
COPY requirements-server.txt /srv/
RUN pip install -r requirements-server.txt

COPY setup.py /srv/
COPY wssh /srv/

RUN setup.py install

COPY examples /srv/
