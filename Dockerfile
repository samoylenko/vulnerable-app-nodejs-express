FROM node:16

WORKDIR /app

COPY index.js /app/index.js
COPY package.json /app/package.json

RUN npm i --package-lock

EXPOSE 8080

CMD [ "npm", "start" ]
