FROM alpine:latest 
LABEL maintainer Colline louis "collinelouis@gmail.com"

RUN echo "**** install Python ****" && \
    apk add --no-cache python3 && \
    if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi && \
    \
    echo "**** install pip ****" && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --no-cache --upgrade pip setuptools wheel && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi

WORKDIR /app

COPY . /app

RUN pip --no-cache-dir install -r requirements.txt 

EXPOSE 8080

ENTRYPOINT [ "python3" ]
CMD [ "main.py" ]
