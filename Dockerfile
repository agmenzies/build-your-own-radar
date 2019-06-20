FROM node:10.15.3 as source
WORKDIR WORKDIR /src/coeus-radar02
COPY package.json ./
RUN npm install
COPY . ./
RUN npm run build

FROM nginx:1.15.9
WORKDIR /opt/coeus-radar02
COPY --from=source /src/coeus-radar02/dist .
COPY default.template /etc/nginx/conf.d/default.conf
CMD ["nginx", "-g", "daemon off;"]
