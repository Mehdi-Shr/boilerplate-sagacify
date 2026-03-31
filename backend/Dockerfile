FROM node:22-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

USER node

EXPOSE 3001

CMD ["sh", "-c", "npx prisma generate && npm run start:dev"]
