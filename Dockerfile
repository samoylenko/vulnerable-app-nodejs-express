FROM node:16 as builder

COPY . /app/

WORKDIR /app

RUN npm i --package-lock

FROM gcr.io/distroless/nodejs18-debian12

COPY --from=builder /app /app

WORKDIR /app

EXPOSE 8080

CMD ["index.js"]
