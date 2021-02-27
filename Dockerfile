FROM golang:1.16-alpine as builder

WORKDIR  /go/src/github.com/avu12/firstgo/main/
COPY main/ ./
#disable crosscompiling 
ENV CGO_ENABLED=0
#compile linux only
ENV GOOS=linux
ENV GOARCH=amd64
RUN go build .


FROM ubuntu
EXPOSE 8080 9100
#Workarond for the html page:
COPY --from=builder /go/src/github.com/avu12/firstgo/main/firstgo ./goapp/firstgo
COPY --from=builder /go/src/github.com/avu12/firstgo/main/static/ ./goapp/static/
CMD [ "/goapp/firstgo" ]
