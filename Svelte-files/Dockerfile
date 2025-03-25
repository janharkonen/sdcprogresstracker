FROM node:22-alpine AS builder

WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci

COPY . .
ARG VITE_WEBSOCKET_URL
ENV VITE_WEBSOCKET_URL=${VITE_WEBSOCKET_URL}

# Build the app
RUN npm run build

# Production stage
FROM node:22-alpine AS production
WORKDIR /app

# Copy built assets from the builder stage
COPY --from=builder /app/build ./build
COPY --from=builder /app/package.json ./

# Install only production dependencies
RUN npm ci --production

# For development mode
FROM node:22-alpine AS development
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
EXPOSE 5173
CMD ["npm", "run", "dev", "--", "--host"]

# Use the appropriate target based on your environment
FROM ${NODE_ENV:-development}