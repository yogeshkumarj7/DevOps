FROM node:18-alpine
WORKDIR /app

COPY package*.json ./

RUN npm ci --only=production

COPY . .

EXPOSE 4000

HEALTHCHECK --interval=10s --timeout=2s --start-period=5s \
  CMD wget -q -O- http://localhost:4000/healthz || exit 1

CMD ["node", "server.js"]


