<script lang="ts">
    import { writable } from 'svelte/store';
    let value = writable(3);
    export let socket: WebSocket;

    socket.addEventListener('message', (event) => {
        value.set(event.data);
    });

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
</script>

<button on:click={incrementCounter}>
    {$value}
</button>