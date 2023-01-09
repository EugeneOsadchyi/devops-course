# syntax=docker/dockerfile:1

FROM node:19-alpine AS builder
ENV NODE_ENV=production
WORKDIR /app
COPY ./nodejs-demoapp/src/package* ./
RUN npm install --omit=dev

FROM node:19-alpine
ENV NODE_ENV "production"
WORKDIR /app

RUN apk add --no-cache nginx

COPY ./docker/nginx/nginx.conf /etc/nginx/http.d/default.conf

COPY --from=builder /app ./
COPY ./nodejs-demoapp/src ./

EXPOSE 80

CMD nginx && npm run start
