# Build stage
FROM node:20 AS builder
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy source code
COPY . .

# Optional build step if you have a build process
# RUN npm run build

# Runtime stage
FROM node:20
WORKDIR /app
COPY --from=builder /app .

EXPOSE 3000
CMD ["node", "server.js"]
