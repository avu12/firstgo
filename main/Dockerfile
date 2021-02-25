FROM golang as builder

WORKDIR  /go/src/github.com/avu12/firstgo/main/
COPY main.go .
RUN go build .


FROM ubuntu
RUN apt-get update
# Get Ubuntu packages
#Workarond for the html page:
COPY --from=builder /go/src/github.com/avu12/firstgo/main/ .
ENTRYPOINT ["./main"]