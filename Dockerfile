FROM node:16

COPY . /app/

WORKDIR /app

RUN chown -R node:node /app && npm i --package-lock

FROM node:16

COPY . /app/

WORKDIR /app

RUN npm i --package-lock

# Disable debug mode
ENV NODE_ENV=production

# Restrict CORS
EXPOSE 8080
CORS_ORIGIN="http://yourdomain.com"

# Add security headers
EXPOSE 8080
HEADER X-Content-Type-Options nosniff
HEADER X-XSS-Protection "1; mode=block"
HEADER Content-Security-Policy "default-src 'self'; script-src 'self'; img-src 'self'; style-src 'self'; font-src 'self';"

CMD [ "npm", "start" ]
