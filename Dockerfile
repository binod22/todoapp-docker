FROM node:18-alpine AS installer

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install

COPY . .

RUN npm run build

FROM nginx:latest AS deployer

COPY -- from == installer /app/build /user/share/nginx/html/

RUN npm install -g serve

EXPOSE 3000

CMD ["serve", "-s", "build", "-l", "3000"]

