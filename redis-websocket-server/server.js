const WebSocket = require('ws');
const redis = require('redis');

// Create Redis clients with proper connection
const createRedisClient = async () => {
  const client = redis.createClient();
  
  client.on('error', (err) => {
    console.error('Redis error:', err);
  });
  
  // Connect to Redis
  await client.connect();
  console.log('Connected to Redis');
  
  return client;
};

// Main function to run the server
async function runServer() {
  try {
    // Create and connect main Redis client
    const redisClient = await createRedisClient();
    
    // Enable keyspace notifications (K: Keyspace events, E: Keyevent events, A: all commands)
    //await redisClient.configSet('notify-keyspace-events', 'KEA');
    console.log('Redis keyspace notifications enabled');
    
    // Create a WebSocket server
    const wss = new WebSocket.Server({ port: 8080 });
    
    wss.on('listening', () => {
      console.log('WebSocket server is listening on ws://localhost:8080');
    });
    
    wss.on('error', (err) => {
      console.error('WebSocket server error:', err);
    });
    
    // Listen for new WebSocket connections
    wss.on('connection', async (ws) => {
      console.log('Client connected');
      
      try {
        // Send the initial value when client connects
        const initialValue = await redisClient.get('item1:user1');
        if (initialValue) {
          console.log('Sending initial value:', initialValue);
          ws.send(initialValue);
        } else {
          console.log('No initial value found for item1:user1');
        }
        
        // Create a subscriber client
        const subscriber = await createRedisClient();
        
        // Subscribe to Redis key changes
        await subscriber.pSubscribe('__keyevent@*__:set', async (message, channel) => {
          console.log(`Received notification: key=${message}, channel=${channel}`);
          
          // Check if the updated key is the one we're interested in
          if (message === 'item1:user1') {
            try {
              // Fetch the updated value
              const updatedValue = await redisClient.get(message);
              console.log('Key updated with value:', updatedValue);
              
              // Send the updated value to the client
              if (ws.readyState === WebSocket.OPEN) {
                ws.send(updatedValue);
              }
            } catch (err) {
              console.error('Error getting updated value:', err);
            }
          }
        });
        
        ws.on('close', async () => {
          console.log('Client disconnected');
          await subscriber.quit();
        });
      } catch (err) {
        console.error('Error in connection handler:', err);
      }
    });
  } catch (err) {
    console.error('Failed to start server:', err);
  }
}

// Run the server
runServer();