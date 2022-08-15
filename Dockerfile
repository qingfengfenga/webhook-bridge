FROM python:3.10.6-slim

LABEL maintainer=penn.wang@digitwin.com

RUN pip install -i https://pypi.tuna.tsinghua.edu.cn/simple requests

WORKDIR /app

COPY . .

EXPOSE 8080

CMD ./webhookd -scripts scripts -static-dir www -static-path /www -listen-addr :8080