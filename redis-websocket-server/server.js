const WebSocket = require('ws');
const redis = require('redis');

// Create a Redis client
const redisClient = redis.createClient();

redisClient.on('error', (err) => {
  console.error('Redis error:', err);
});

redisClient.on('connect', () => {
  console.log('Connected to Redis');
});

// Create a WebSocket server
const wss = new WebSocket.Server({ port: 8080 });

wss.on('listening', () => {
  console.log('WebSocket server is listening on ws://localhost:8080');
});

wss.on('error', (err) => {
  console.error('WebSocket server error:', err);
});

// Listen for new WebSocket connections
wss.on('connection', (ws) => {
  console.log('Client connected');

  // Subscribe to Redis key changes
  const subscriber = redis.createClient();
  subscriber.subscribe('__keyevent@0__:set');

  subscriber.on('message', (channel, key) => {
    if (key === 'item1:user1') {
      // Fetch the updated value from Redis
      redisClient.get(key, (err, value) => {
        if (err) return console.error('Error getting value from Redis:', err);
        // Send the updated value to the WebSocket client
        ws.send(value);
      });
    }
  });

  ws.on('close', () => {
    console.log('Client disconnected');
    subscriber.quit();
  });
});