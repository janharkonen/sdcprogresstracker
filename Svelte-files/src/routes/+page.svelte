<script>
  import { writable } from 'svelte/store';
  
  // Create a writable store for panel1
  export let panel1 = writable(0);
  
  // Connect to the WebSocket server
  const socket = new WebSocket('ws://localhost:8080');
  
  // Listen for messages from the WebSocket server
  socket.addEventListener('message', (event) => {
    // Parse the value as a number before updating the store
    const numValue = parseFloat(event.data);
    console.log('Received from WebSocket:', event.data, 'Parsed as:', numValue);
    
    // Only update if it's a valid number
    if (!isNaN(numValue)) {
      panel1.set(numValue);
    } else {
      console.error('Received invalid numeric data:', event.data);
    }
  });
  
  // Connection status handling
  socket.addEventListener('open', () => {
    console.log('WebSocket connection established');
  });
  
  socket.addEventListener('error', (error) => {
    console.error('WebSocket error:', error);
  });
  
  socket.addEventListener('close', () => {
    console.log('WebSocket connection closed');
  });
  
  // Function to increment the counter
  function incrementCounter() {
    // Send an increment command to the server
    if (socket.readyState === WebSocket.OPEN) {
      const message = JSON.stringify({
        action: 'increment',
        key: 'item1:user1'
      });
      console.log('Sending message to server:', message);
      socket.send(message);
    } else {
      console.error('WebSocket not connected, readyState:', socket.readyState);
      // For reference: 0 = CONNECTING, 1 = OPEN, 2 = CLOSING, 3 = CLOSED
    }
  }

  let panel2 = 0;
  let panel3 = 0;
  let panel4 = 0;
</script>

<div>
  <p>Row 1: {$panel1}</p>
  <button on:click={incrementCounter}>add one</button>
  <p>Row 2: {panel2}</p>
  <p>Row 3: {panel3}</p>
  <p>Row 4: {panel4}</p>
</div>
