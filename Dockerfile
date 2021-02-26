FROM golang:1.16-alpine as builder

WORKDIR  /go/src/github.com/avu12/firstgo/main/
COPY main/main.go main/go.mod ./
#disable crosscompiling 
ENV CGO_ENABLED=0
#compile linux only
ENV GOOS=linux
ENV GOARCH=amd64
RUN go build .


FROM scratch
EXPOSE 8080 9100
#Workarond for the html page:
COPY --from=builder /go/src/github.com/avu12/firstgo/main/ .
CMD [ "/firstgo" ]
