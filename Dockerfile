FROM ubuntu:20.04


RUN apt update -y
RUN DEBIAN_FRONTEND="noninteractive" apt -y install tzdata
RUN apt install git cmake build-essential uuid-dev python3 python3-pip python3-dev python3-setuptools libboost-python-dev libboost-thread-dev -y

RUN git clone https://github.com/nalves599/libmei && cd libmei && mkdir build && cd build && cmake .. && make && make install && cd ../python && python3 setup.py build && python3 setup.py install && cd ../.. && rm -rf libmei

ARG NB_USER=mei
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

WORKDIR ${HOME}

ENV PATH "$HOME/.local/bin:$PATH"

RUN pip3 install -r requirements.txt
RUN pip3 install --no-cache-dir notebook
RUN pip3 install --no-cache-dir jupyterhub
RUN pip3 install --no-cache-dir jupyterlab





