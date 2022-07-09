FROM rust:1.62-alpine as builder
WORKDIR /usr/src/invoicing
COPY . .
RUN apk add musl-dev
RUN cargo install --path .

FROM alpine:3
RUN apk update && apk upgrade 
COPY --from=builder /usr/local/cargo/bin/invoices /usr/local/bin/invoices
WORKDIR /usr/local/bin
EXPOSE 3000
CMD ["invoices"]