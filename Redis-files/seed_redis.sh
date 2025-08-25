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
EXISTS=$(redis-cli EXISTS seedexists)
if [ "$EXISTS" -eq 0 ]; then
  echo "No existing data found. Seeding Redis..."
  # Seed Redis with initial data
  redis-cli SET seedexists 1
  redis-cli SET taitomerkki:1 "Elli Dunbar"
  redis-cli SET taitomerkki:2 "Happy Together"
  redis-cli SET taitomerkki:3 "Harvoin mä ryypyn saan"
  redis-cli SET taitomerkki:4 "Hauen laulu"
  redis-cli SET taitomerkki:5 "Hiiden orjien laulu"
  redis-cli SET taitomerkki:6 "Hiprakassa"
  redis-cli SET taitomerkki:7 "Hämärän ääniä"
  redis-cli SET taitomerkki:8 "In these Delightful Pleasant Groves"
  redis-cli SET taitomerkki:9 "Isänmaalle"
  redis-cli SET taitomerkki:10 "Jesu Dulcis"
  redis-cli SET taitomerkki:11 "Joulun virsi, elämän virsi"
  redis-cli SET taitomerkki:12 "Juhannus"
  redis-cli SET taitomerkki:13 "Kaksi laulua kuolemasta"
  redis-cli SET taitomerkki:14 "Keinu"
  redis-cli SET taitomerkki:15 "Kuu"
  redis-cli SET taitomerkki:16 "Kuutamolla"
  redis-cli SET taitomerkki:17 "Käy isänmaataan kohti \'ain"
  redis-cli SET taitomerkki:18 "Gut Singer und ein Organist"
  redis-cli SET taitomerkki:19 "Ljuva flicka"
  redis-cli SET taitomerkki:20 "Madrigaali"
  redis-cli SET taitomerkki:21 "Sjöfararen vid milan"
  redis-cli SET taitomerkki:22 "Metsämiehen laulu"
  redis-cli SET taitomerkki:23 "Nattlig madonna"
  redis-cli SET taitomerkki:24 "Now is the Month of Maying"
  redis-cli SET taitomerkki:25 "Nuijamiesten marssi"
  redis-cli SET taitomerkki:26 "Onnelliset"
  redis-cli SET taitomerkki:27 "Hiien hiilien sekahan"
  redis-cli SET taitomerkki:28 "Santa Maria"
  redis-cli SET taitomerkki:29 "Se nukku"
  redis-cli SET taitomerkki:30 "Soita somer, helkä hiekka"
  redis-cli SET taitomerkki:31 "Sortunut ääni"
  redis-cli SET taitomerkki:32 "Suvi-llan vieno tuuli"
  redis-cli SET taitomerkki:33 "Tanssista palataan"
  redis-cli SET taitomerkki:34 "Tanssit"
  redis-cli SET taitomerkki:35 "Tre sånger om kärleken"
  redis-cli SET taitomerkki:36 "Trinklied aus dem 16. Jahrhundert"
  redis-cli SET taitomerkki:37 "Tuutulaulu"
  redis-cli SET taitomerkki:38 "Uti vår hage"
  redis-cli SET taitomerkki:39 "Veljesten paluu Jukolaan"
  redis-cli SET taitomerkki:40 "Virta venhettä vie"
  redis-cli SET laulajat:sdc:1 "Martti"
  redis-cli SET laulajat:sdc:2 "Eelis"
  redis-cli SET laulajat:sdc:3 "Keinis"
  redis-cli SET laulajat:sdc:4 "Jan"

  echo "Redis seeding complete."
else
  echo "Existing Redis data found, skipping seed."
fi

redis-cli CONFIG SET notify-keyspace-events KEA

# Keep the container running
tail -f /dev/null