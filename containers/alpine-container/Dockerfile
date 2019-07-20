FROM alpine:3.7

MAINTAINER Your Name "Frostlock"

RUN apk add --update py-pip

COPY . /app
WORKDIR /app

RUN pip install -r requirements.txt

ENTRYPOINT [ "python" ]

CMD [ "FlaskApp.py" ]