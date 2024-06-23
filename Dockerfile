FROM node:20-alpine AS build-env
COPY . /app
WORKDIR /app

# RUN npm ci --omit=dev

COPY package.json ./
COPY yarn.lock ./
RUN yarn install
COPY . ./
RUN yarn build


# FROM gcr.io/distroless/nodejs20-debian11
FROM node:20-alpine
COPY --from=build-env /app /app
WORKDIR /app
CMD ["node","build"]
EXPOSE 3000

