FROM node:16

COPY . /app/

WORKDIR /app

RUN npm install --package-lock --user root

EXPOSE 8080

CMD [ "npm", "start" ]
