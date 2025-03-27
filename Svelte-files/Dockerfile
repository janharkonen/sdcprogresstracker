FROM node:22-alpine AS builder

WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci

# Copy necessary files
COPY . .

# Clear Vite cache before building
RUN rm -rf .vite .svelte-kit node_modules/.vite

# Build with detailed logs for debugging
RUN NODE_ENV=production npm run build

# Production stage
FROM node:22-alpine AS production
WORKDIR /app

# Copy built app (adapter-node puts output in the 'build' directory)
COPY --from=builder /app/build ./
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/package-lock.json ./package-lock.json

# Install only production dependencies
RUN npm ci --omit=dev

# Expose the port the app runs on
EXPOSE 3000

# Start the application
CMD ["node", "index.js"]

# Development stage
FROM node:22-alpine AS development
WORKDIR /app

# Copy package files first for better caching
COPY package.json package-lock.json ./
RUN npm install

# Copy the rest of the application
COPY . .

# Extra environment settings for development
ENV NODE_ENV=development
ENV VITE_CLEAR_DEPS_CACHE=true

# Clear cache before starting dev server
RUN rm -rf .vite .svelte-kit node_modules/.vite

EXPOSE 5173
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0", "--force"]