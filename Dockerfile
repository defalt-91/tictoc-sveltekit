FROM node:20 AS build-env
COPY . /app
WORKDIR /app

# RUN npm ci --omit=dev

COPY package.json ./
COPY yarn.lock ./
RUN yarn install
COPY . ./
RUN yarn build

#FROM nginx:1.25.1
#COPY --from=build-env /app/public /usr/share/nginx/html

FROM node:20-alpine
# FROM gcr.io/distroless/nodejs20-debian11
COPY --from=build-env /app /app
WORKDIR /app
CMD ["node","build"]
EXPOSE 3000