FROM golang:1.16-alpine as builder

WORKDIR  /go/src/github.com/avu12/firstgo/main/
COPY main.go go.mod ./
RUN go build .


FROM scratch
# Get Ubuntu packages
#Workarond for the html page:
COPY --from=builder /go/src/github.com/avu12/firstgo/main/ .
ENTRYPOINT ["./main"]