FROM node:16 as builder

WORKDIR /app

COPY index.js /app/index.js
COPY package.json /app/package.json

RUN npm i --package-lock

FROM gcr.io/distroless/nodejs18-debian12

COPY --from=builder /app /app

WORKDIR /app

EXPOSE 8080

CMD [ "npm", "start" ]
