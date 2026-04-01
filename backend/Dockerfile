FROM node:22-alpine

WORKDIR /app

RUN apk add --no-cache netcat-openbsd

COPY package*.json ./
COPY prisma ./prisma

RUN npm install

COPY . .

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 3001

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["npm", "run", "start:dev"]
