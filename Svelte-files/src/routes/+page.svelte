<script lang="ts">
  import Button from '$lib/Button.svelte';
  import { writable } from 'svelte/store';
  
  export let panel1 = writable(0);
  let socket = new WebSocket(import.meta.env.VITE_WEBSOCKET_URL);
  
  socket.addEventListener('message', (event) => {
    panel1.set(event.data);
  });
  
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
</script>

<div>
  <p>Row 1: {$panel1}</p>
  <Button socket={socket}></Button>
</div>
