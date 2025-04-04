FROM node:16

COPY . /app/

WORKDIR /app

RUN npm i --package-lock

EXPOSE 8080

CMD [ "npm", "start" ]
