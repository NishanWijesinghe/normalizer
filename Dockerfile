FROM python:3.7.4
ENV APP normalizer

COPY / /opt/$APP

RUN cd /opt/$APP

WORKDIR /opt/$APP
RUN pip install --no-cache-dir -r requirements.txt
