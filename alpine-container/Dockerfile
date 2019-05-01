FROM python:3.7-alpine

MAINTAINER Your Name "N/A"

COPY . /app
WORKDIR /app

RUN pip install -r requirements.txt

ENTRYPOINT [ "python" ]

CMD [ "FlaskApp.py" ]