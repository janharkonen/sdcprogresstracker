const WebSocket = require('ws');
const redis = require('redis');

const createRedisClient = async () => {
  const client = redis.createClient({url: process.env.REDIS_URL});   
  client.on('error', (err) => {
    console.error('Redis error:', err);
  });
  await client.connect();
  console.log('Connected to Redis'); 
  return client;
};

async function runServer() {
  try {
    const wss = new WebSocket.Server({ port: 8080 });
    const redisClient = await createRedisClient();
    
    const subscribedKeys = new Map(); 
    
    wss.on('listening', () => {
      console.log('WebSocket server is listening on port 8080');
    });
    
    wss.on('error', (err) => {
      console.error('WebSocket server error:', err);
    });
    
    wss.on('connection', async (ws) => {
      console.log('Client connected');
      
      try {
        // Handle messages from the client
        ws.on('message', async (data) => {
          const { action, key } = JSON.parse(data);
  
          if (action === 'subscribe') {
            // Subscribe the client to the Redis key
            if (!subscribedKeys.has(key)) {
              await redisClient.subscribe(`__keyspace@0__:${key}`, async (message) => {
                const newValue = await redisClient.get(key);
                wss.clients.forEach(client => {
                  if (client.readyState === WebSocket.OPEN) {
                    client.send(JSON.stringify({ key, value: newValue }));
                  }
                });
              });
              subscribedKeys.set(key, true);
            }
          }
  
          if (action === 'update') {
            await redisClient.set(key, data.value);
          }
        });
        
        ws.on('close', async () => {
          console.log('Client disconnected');
        });
      } catch (err) {
        console.error('Error in connection handler:', err);
      }
    });
  } catch (err) {
    console.error('Failed to start server:', err);
  }
}

runServer();