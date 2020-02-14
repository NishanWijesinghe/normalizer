FROM python:3.7.4
ENV APP normalizer

#RUN useradd -ms /bin/bash $APP

COPY / /opt/$APP

RUN cd /opt/$APP

#RUN chown -R $APP *

WORKDIR /opt/$APP
RUN pip install --no-cache-dir -r requirements.txt

#USER $APP
#VOLUME /opt/$APP/inputs