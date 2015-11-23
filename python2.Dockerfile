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
RUN pip install -r requirements-server.txt
RUN pip install -r requirements-client.txt

COPY setup.py /srv/
COPY bin /srv/bin
COPY wssh /srv/wssh
COPY examples /srv/examples

RUN python setup.py install

ADD https://github.com/phusion/baseimage-docker/raw/master/image/services/sshd/keys/insecure_key.pub /root/.ssh/insecure_key.pub
ADD https://github.com/phusion/baseimage-docker/raw/master/image/services/sshd/keys/insecure_key /root/.ssh/insecure_key
RUN chmod 600 /root/.ssh/insecure_key* && \
    cat /root/.ssh/insecure_key.pub >> /root/.ssh/authorized_keys && \
    eval "$(ssh-agent)" && \
    ssh-add /root/.ssh/insecure_key

COPY start-server.sh /srv/

CMD ["my_init", "--enable-insecure-key"]
