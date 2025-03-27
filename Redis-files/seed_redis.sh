#!/bin/sh

cat > /redis.conf << EOF
# Enable RDB persistence
save 900 1
save 300 10
save 60 10000

# Enable AOF persistence
appendonly yes
appendfsync everysec

# Set data directory
dir /data
EOF

# Start Redis server in the background
redis-server /redis.conf --daemonize yes

# Wait for Redis to be ready
echo "Waiting for Redis to be ready..."
while ! redis-cli ping > /dev/null 2>&1; do
  sleep 1
done
echo "Redis is ready. Seeding data..."

# Check if data already exists
EXISTS=$(redis-cli EXISTS user1)
if [ "$EXISTS" -eq 0 ]; then
  echo "No existing data found. Seeding Redis..."
  # Seed Redis with initial data

  redis-cli SET item1:user1 0
  redis-cli SET item2:user1 0
  redis-cli SET item3:user1 0
  redis-cli SET item4:user1 0
  redis-cli SET item5:user1 0
  redis-cli SET item6:user1 0
  redis-cli SET item7:user1 0
  redis-cli SET item8:user1 0
  redis-cli SET item9:user1 0
  redis-cli SET item10:user1 0
  redis-cli SET item11:user1 0
  redis-cli SET item12:user1 0
  redis-cli SET item13:user1 0
  redis-cli SET item14:user1 0
  redis-cli SET item15:user1 0
  redis-cli SET item16:user1 0
  redis-cli SET item17:user1 0
  redis-cli SET item18:user1 0
  redis-cli SET item19:user1 0
  redis-cli SET item20:user1 0
  redis-cli SET item21:user1 0
  redis-cli SET item22:user1 0
  redis-cli SET item23:user1 0
  redis-cli SET item24:user1 0
  redis-cli SET item25:user1 0
  redis-cli SET item26:user1 0
  redis-cli SET item27:user1 0
  redis-cli SET item28:user1 0
  redis-cli SET item29:user1 0
  redis-cli SET item30:user1 0
  redis-cli SET item31:user1 0
  redis-cli SET item32:user1 0
  redis-cli SET item33:user1 0
  redis-cli SET item34:user1 0
  redis-cli SET item35:user1 0
  redis-cli SET item36:user1 0
  redis-cli SET item37:user1 0
  redis-cli SET item38:user1 0
  redis-cli SET item39:user1 0
  redis-cli SET item40:user1 0
  redis-cli SET item1:user2 0
  redis-cli SET item2:user2 0
  redis-cli SET item3:user2 0
  redis-cli SET item4:user2 0
  redis-cli SET item5:user2 0
  redis-cli SET item6:user2 0
  redis-cli SET item7:user2 0
  redis-cli SET item8:user2 0
  redis-cli SET item9:user2 0
  redis-cli SET item10:user2 0
  redis-cli SET item11:user2 0
  redis-cli SET item12:user2 0
  redis-cli SET item13:user2 0
  redis-cli SET item14:user2 0
  redis-cli SET item15:user2 0
  redis-cli SET item16:user2 0
  redis-cli SET item17:user2 0
  redis-cli SET item18:user2 0
  redis-cli SET item19:user2 0
  redis-cli SET item20:user2 0
  redis-cli SET item21:user2 0
  redis-cli SET item22:user2 0
  redis-cli SET item23:user2 0
  redis-cli SET item24:user2 0
  redis-cli SET item25:user2 0
  redis-cli SET item26:user2 0
  redis-cli SET item27:user2 0
  redis-cli SET item28:user2 0
  redis-cli SET item29:user2 0
  redis-cli SET item30:user2 0
  redis-cli SET item31:user2 0
  redis-cli SET item32:user2 0
  redis-cli SET item33:user2 0
  redis-cli SET item34:user2 0
  redis-cli SET item35:user2 0
  redis-cli SET item36:user2 0
  redis-cli SET item37:user2 0
  redis-cli SET item38:user2 0
  redis-cli SET item39:user2 0
  redis-cli SET item40:user2 0
  redis-cli SET item1:user3 0
  redis-cli SET item2:user3 0
  redis-cli SET item3:user3 0
  redis-cli SET item4:user3 0
  redis-cli SET item5:user3 0
  redis-cli SET item6:user3 0
  redis-cli SET item7:user3 0
  redis-cli SET item8:user3 0
  redis-cli SET item9:user3 0
  redis-cli SET item10:user3 0
  redis-cli SET item11:user3 0
  redis-cli SET item12:user3 0
  redis-cli SET item13:user3 0
  redis-cli SET item14:user3 0
  redis-cli SET item15:user3 0
  redis-cli SET item16:user3 0
  redis-cli SET item17:user3 0
  redis-cli SET item18:user3 0
  redis-cli SET item19:user3 0
  redis-cli SET item20:user3 0
  redis-cli SET item21:user3 0
  redis-cli SET item22:user3 0
  redis-cli SET item23:user3 0
  redis-cli SET item24:user3 0
  redis-cli SET item25:user3 0
  redis-cli SET item26:user3 0
  redis-cli SET item27:user3 0
  redis-cli SET item28:user3 0
  redis-cli SET item29:user3 0
  redis-cli SET item30:user3 0
  redis-cli SET item31:user3 0
  redis-cli SET item32:user3 0
  redis-cli SET item33:user3 0
  redis-cli SET item34:user3 0
  redis-cli SET item35:user3 0
  redis-cli SET item36:user3 0
  redis-cli SET item37:user3 0
  redis-cli SET item38:user3 0
  redis-cli SET item39:user3 0
  redis-cli SET item40:user3 0
  redis-cli SET item1:user4 0
  redis-cli SET item2:user4 0
  redis-cli SET item3:user4 0
  redis-cli SET item4:user4 0
  redis-cli SET item5:user4 0
  redis-cli SET item6:user4 0
  redis-cli SET item7:user4 0
  redis-cli SET item8:user4 0
  redis-cli SET item9:user4 0
  redis-cli SET item10:user4 0
  redis-cli SET item11:user4 0
  redis-cli SET item12:user4 0
  redis-cli SET item13:user4 0
  redis-cli SET item14:user4 0
  redis-cli SET item15:user4 0
  redis-cli SET item16:user4 0
  redis-cli SET item17:user4 0
  redis-cli SET item18:user4 0
  redis-cli SET item19:user4 0
  redis-cli SET item20:user4 0
  redis-cli SET item21:user4 0
  redis-cli SET item22:user4 0
  redis-cli SET item23:user4 0
  redis-cli SET item24:user4 0
  redis-cli SET item25:user4 0
  redis-cli SET item26:user4 0
  redis-cli SET item27:user4 0
  redis-cli SET item28:user4 0
  redis-cli SET item29:user4 0
  redis-cli SET item30:user4 0
  redis-cli SET item31:user4 0
  redis-cli SET item32:user4 0
  redis-cli SET item33:user4 0
  redis-cli SET item34:user4 0
  redis-cli SET item35:user4 0
  redis-cli SET item36:user4 0
  redis-cli SET item37:user4 0
  redis-cli SET item38:user4 0
  redis-cli SET item39:user4 0
  redis-cli SET item40:user4 0


  echo "Redis seeding complete."
else
  echo "Existing Redis data found, skipping seed."
fi

redis-cli CONFIG SET notify-keyspace-events KEA

# Keep the container running
tail -f /dev/null