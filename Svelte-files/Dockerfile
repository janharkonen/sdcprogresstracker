FROM node:22-alpine AS builder

WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci

COPY . .

# Build the app for production
RUN npm run build

# Production stage
FROM node:22-alpine AS production
WORKDIR /app

# Copy built assets from the builder stage
COPY --from=builder /app/build ./build
COPY --from=builder /app/package.json ./

# Install only production dependencies
RUN npm ci --production
EXPOSE 5173
CMD ["npm", "run", "preview", "--", "--host"]

# Development stage
FROM node:22-alpine AS development
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
EXPOSE 5173
CMD ["npm", "run", "dev", "--", "--host"]