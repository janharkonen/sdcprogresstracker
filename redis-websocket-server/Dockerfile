FROM node:18-alpine

WORKDIR /app
RUN apk add --no-cache redis
COPY package*.json ./
RUN npm install
COPY server.js ./
EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD node -e "const WebSocket = require('ws'); \
  const ws = new WebSocket('ws://node-websocket:8080'); \
  ws.on('open', () => { console.log('Connected'); process.exit(0); }); \
  ws.on('error', () => { console.error('Connection failed'); process.exit(1); });" || exit 1
CMD ["node", "server.js"]