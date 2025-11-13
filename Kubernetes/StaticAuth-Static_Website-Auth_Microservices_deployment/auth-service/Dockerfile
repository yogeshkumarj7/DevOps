# auth-service/Dockerfile (bcryptjs approach)
FROM node:18-alpine
WORKDIR /app

# copy lock file if available
COPY package*.json ./

# install production deps
RUN npm ci --only=production

COPY . .

EXPOSE 5000

HEALTHCHECK --interval=10s --timeout=2s --start-period=5s \
  CMD wget -q -O- http://localhost:5000/healthz || exit 1

CMD ["node", "server.js"]

