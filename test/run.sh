
#nohup ./webhookd -scripts scripts -static-dir www -static-path /www -listen-addr :8080 &

#  docker run -it -d --name test -p 8080:8080 -v E:\Me\webhook-bridge:/app python:3.10.6-slim sh