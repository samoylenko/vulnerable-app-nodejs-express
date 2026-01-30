FROM node:16

COPY . /app/

WORKDIR /app

RUN npm i --package-lock

EXPOSE 8080

USER node

CMD [ "npm", "start" ]
