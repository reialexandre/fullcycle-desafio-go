FROM golang:1.22-alpine AS builder

WORKDIR /app

COPY go.mod ./
COPY main.go ./

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -trimpath -ldflags="-s -w" -o /out/fullcycle ./main.go

FROM scratch

COPY --from=builder /out/fullcycle /fullcycle

ENTRYPOINT ["/fullcycle"]
