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
    const redisSubClient = await createRedisClient();
    const redisPubClient = await createRedisClient();
    
    wss.on('listening', () => {
      console.log('WebSocket server is listening on port 8080');
    });
    
    wss.on('error', (err) => {
      console.error('WebSocket server error:', err);
    });
    
    wss.on('connection', async (ws) => {
      console.log('Client connected');
     
      const keys = await redisPubClient.keys('item*:user*');
      
      const keyValues = await keys.reduce(async (accPromise, key) => {
        const acc = await accPromise;
        const value = await redisPubClient.get(key);
        acc[key] = parseInt(value, 10);
        return acc;
      }, Promise.resolve({}));
      ws.send(JSON.stringify({ type: 'initial_data', data: keyValues }));
      
      keys.forEach(async (key) => {
        await redisSubClient.subscribe(`__keyspace@0__:${key}`, async () => {
          const newValue = await redisPubClient.get(key);
          wss.clients.forEach(client => {
            if (client.readyState === WebSocket.OPEN) {
              client.send(JSON.stringify({ key, value: newValue }));
            }
          });
        });
      });
      
      try {
        // Handle messages from the client
        ws.on('message', async (data) => {
          const { action, key, value } = JSON.parse(data); 
          if (action === 'update') {
            await redisPubClient.set(key, value);
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