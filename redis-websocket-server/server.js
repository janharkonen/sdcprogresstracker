const WebSocket = require('ws');
const redis = require('redis');

//const createRedisClient = async () => {
//  const redisUrl = process.env.REDIS_URL;
//  const client = redis.createClient({
//    url: redisUrl
//  });   
//  client.on('error', (err) => {
//    console.error('Redis error:', err);
//  });
//  await client.connect();
//  console.log('Connected to Redis'); 
//  return client;
//};

async function runServer() {
  try {
    //const redisClient = await createRedisClient();
    const wss = new WebSocket.Server({ port: 8080 });
    
    wss.on('listening', () => {
      console.log('WebSocket server is listening on ws://node-websocket:8080');
    });
    
    wss.on('error', (err) => {
      console.error('WebSocket server error:', err);
    });
    
    wss.on('connection', async (ws) => {
      console.log('Client connected');
      
      try {
        // Handle messages from the client
        ws.on('message', async (data) => {
          console.log('Received message:', data);
          ws.send(420);
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