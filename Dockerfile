FROM arm64v8/golang:1.16-alpine as builder

WORKDIR  /go/src/github.com/avu12/firstgo/main/
COPY main/ ./
#disable crosscompiling 
ENV CGO_ENABLED=0
#compile linux only
ENV GOOS=linux
ENV GOARCH=arm64
RUN go build .

#arm64 for raspi!
FROM arm64v8/ubuntu
EXPOSE 8080 9100
#Workarond for the html page:
COPY --from=builder /go/src/github.com/avu12/firstgo/main/firstgo ./main/firstgo
COPY --from=builder /go/src/github.com/avu12/firstgo/main/static/ ./main/static/
WORKDIR /goapp/
CMD [ "./firstgo" ]
