FROM node:lts

WORKDIR /app
COPY ./package*.json ./
RUN npm ci
RUN npm i -g nodemon
COPY . .
RUN chown -R node:node /app
USER node