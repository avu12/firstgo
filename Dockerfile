FROM golang:1.16-alpine as builder

WORKDIR  /go/src/github.com/avu12/firstgo/main/
COPY main/main.go main/go.mod ./
#disable crosscompiling 
ENV CGO_ENABLED=0
#compile linux only
ENV GOOS=linux
RUN go build .


FROM scratch
# Get Ubuntu packages
#Workarond for the html page:
COPY --from=builder /go/src/github.com/avu12/firstgo/main/ .
CMD ["./main"]