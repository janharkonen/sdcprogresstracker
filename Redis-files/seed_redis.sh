#!/bin/sh
# Start Redis server in the background
redis-server --daemonize yes

# Wait for Redis to be ready
echo "Waiting for Redis to be ready..."
while ! redis-cli ping > /dev/null 2>&1; do
  sleep 1
done
echo "Redis is ready. Seeding data..."

# Seed Redis with initial data
redis-cli SET item1:user1 0
redis-cli SET item2:user1 0
redis-cli SET item3:user1 0
redis-cli SET item4:user1 0
redis-cli SET item5:user1 0
redis-cli SET item6:user1 0
redis-cli SET item1:user2 0
redis-cli SET item2:user2 0
redis-cli SET item3:user2 0
redis-cli SET item4:user2 0
redis-cli SET item5:user2 0
redis-cli SET item6:user2 0
redis-cli CONFIG SET notify-keyspace-events KEA

echo "Redis seeding complete."

# Keep the container running
tail -f /dev/null