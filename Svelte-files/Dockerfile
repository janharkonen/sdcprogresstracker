FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json .
RUN npm ci
COPY . .
RUN npm run build
RUN npm prune --production

# Production stage
FROM node:18-alpine AS production
WORKDIR /app
# Copy necessary files
COPY --from=builder /app/build build/
COPY --from=builder /app/node_modules node_modules/
COPY package*.json .
ENV NODE_ENV=production
EXPOSE 3000
# Use the entry point you discovered
CMD ["node", "build"]

# Development stage
FROM node:20-alpine AS development
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 5173
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"]
