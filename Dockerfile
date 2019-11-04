FROM node:12.13-alpine as builder

WORKDIR /usr/src/app

RUN apk add --no-cache git

COPY ["package.json", "package-lock.json*", "npm-shrinkwrap.json*", "./"]

RUN npm install

COPY . .

RUN npm run build


FROM nginx

RUN apt-get update -y

COPY ./nginx-config/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /usr/src/app/build /usr/share/nginx/html
