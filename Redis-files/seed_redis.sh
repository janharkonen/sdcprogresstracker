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
redis-cli SET user1 "käyttäjä 1"
redis-cli SET user2 "käyttäjä 2"
redis-cli SET user3 "käyttäjä 3"
redis-cli SET user4 "käyttäjä 4"

redis-cli SET item1 "rivi 1"
redis-cli SET item2 "rivi 2"
redis-cli SET item3 "rivi 3"
redis-cli SET item4 "rivi 4"
redis-cli SET item5 "rivi 5"
redis-cli SET item6 "rivi 6"
redis-cli SET item7 "rivi 7"
redis-cli SET item8 "rivi 8"
redis-cli SET item9 "rivi 9"
redis-cli SET item10 "rivi 10"
redis-cli SET item11 "rivi 11"
redis-cli SET item12 "rivi 12"
redis-cli SET item13 "rivi 13"
redis-cli SET item14 "rivi 14"
redis-cli SET item15 "rivi 15"
redis-cli SET item16 "rivi 16"
redis-cli SET item17 "rivi 17"
redis-cli SET item18 "rivi 18"
redis-cli SET item19 "rivi 19"
redis-cli SET item20 "rivi 20"
redis-cli SET item21 "rivi 21"
redis-cli SET item22 "rivi 22"
redis-cli SET item23 "rivi 23"
redis-cli SET item24 "rivi 24"
redis-cli SET item25 "rivi 25"
redis-cli SET item26 "rivi 26"
redis-cli SET item27 "rivi 27"
redis-cli SET item28 "rivi 28"
redis-cli SET item29 "rivi 29"
redis-cli SET item30 "rivi 30"
redis-cli SET item31 "rivi 31"
redis-cli SET item32 "rivi 32"
redis-cli SET item33 "rivi 33"
redis-cli SET item34 "rivi 34"
redis-cli SET item35 "rivi 35"
redis-cli SET item36 "rivi 36"
redis-cli SET item37 "rivi 37"
redis-cli SET item38 "rivi 38"
redis-cli SET item39 "rivi 39"
redis-cli SET item40 "rivi 40"

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

redis-cli CONFIG SET notify-keyspace-events KEA

echo "Redis seeding complete."

# Keep the container running
tail -f /dev/null