<script lang="ts">
  import { onMount, onDestroy } from 'svelte';
  import ButtonMatrix from '$lib/ButtonMatrix.svelte';

  let socket = $state<WebSocket | null>(null);
  let matrixData = $state<Record<string, number>>({});
  let isConnected = $state(false);

  onMount(() => {
    socket = new WebSocket(import.meta.env.VITE_WEBSOCKET_URL);

    socket.onopen = () => {
      console.log('WebSocket connected');
      isConnected = true;
    };

    socket.onmessage = (event) => {
      const message = JSON.parse(event.data);
      if (message.type === 'initial_data') {
        matrixData = { ...message.data };
      } else {
        matrixData = { 
          ...matrixData, 
          [message.key]: parseInt(message.value)
        };
      }
    };

    socket.onerror = (err) => {
      console.error('WebSocket error:', err);
      isConnected = false;
    };

    socket.onclose = () => {
      console.log('WebSocket disconnected');
      isConnected = false;
      socket = null;
    };
  });

  onDestroy(() => {
    if (socket && socket.readyState < 2) { // 0 = CONNECTING, 1 = OPEN
      socket.close();
    }
  });

  function handleClick(key: string) {
    if (!socket || socket.readyState !== WebSocket.OPEN) {
      console.error('WebSocket is not connected');
      return;
    }
    
    const newValue = (matrixData[key] + 1) % 4;
    try {
      socket.send(JSON.stringify({ action: 'update', key: key, value: newValue }));
    } catch (err) {
      console.error('Error sending message: ',err)
    }
  }
</script>
  
<div class="container mx-auto p-4">
  <h1 class="text-2xl font-bold mb-4">Progress tracker</h1>
  
  {#if !isConnected}
    <div class="bg-yellow-100 p-4 rounded mb-4">
      Connecting to server...
    </div>
  {/if}
  
  <ButtonMatrix
    matrixData={matrixData} 
    {handleClick}
  />
</div>