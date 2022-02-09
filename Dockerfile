# syntax=docker/dockerfile:1
FROM golang:1.17 As builder
WORKDIR /minikube-test
COPY . .
RUN go mod tidy
#RUN go build -o /hello-minikube
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o hello-minikube .

FROM alpine
WORKDIR /minikube-test
ENV PORT 8080
COPY --from=builder /minikube-test/hello-minikube ./
CMD ["./hello-minikube"]