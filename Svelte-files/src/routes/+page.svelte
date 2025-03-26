<script lang="ts">
  import { onMount, onDestroy } from 'svelte';
  import ButtonMatrix from '$lib/ButtonMatrix.svelte';
  import { initialData } from '$lib/dataUtils';

  let socket = $state<WebSocket | null>(null);
  let matrixData = $state<Record<string, Record<string, string>>>(initialData);
  let isConnected = $state(false);
  let isDataLoaded = $state(false);  // Add a new state to track if data is loaded

  $inspect(matrixData)
  onMount(() => {
    socket = new WebSocket(import.meta.env.VITE_WEBSOCKET_URL);

    socket.onopen = () => {
      console.log('WebSocket connected');
      isConnected = true;
    };

    socket.onmessage = (event) => {
      const message = JSON.parse(event.data);
      if (message.type === 'initial_data') {
        Object.keys(matrixData).forEach(itemKey => {
          const itemData = matrixData[itemKey]
          Object.keys(itemData)
          .filter(key => key !== 'itemname')
          .forEach((userKey) => {
            const redisKey = `${itemKey}:${userKey}`
            matrixData = {
              ...matrixData,
              [itemKey]: {
                ...matrixData[itemKey],
                [userKey]: message.data[redisKey]
              }
            }      
          })
        });
        isDataLoaded = true;
      } else {
        const itemKey = message.key.split(':')[0]
        const userKey = message.key.split(':')[1]
        matrixData = { 
          ...matrixData, 
          [itemKey]: {
            ...matrixData[itemKey],
            [userKey]: message.value
          }
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

  function handleClick(redisKey: string) {
    if (!socket || socket.readyState !== WebSocket.OPEN) {
      console.error('WebSocket is not connected');
      return;
    }
    const itemKey = redisKey.split(':')[0]
    const userKey = redisKey.split(':')[1]
    const newValue = String((Number(matrixData[itemKey][userKey]) + 1) % 4);
    try {
      socket.send(JSON.stringify({ action: 'update', key: redisKey, value: newValue }));
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
  {:else if !isDataLoaded}
    <div class="bg-blue-100 p-4 rounded mb-4">
      Loading data...
    </div>
  {:else}
  <ButtonMatrix
    {matrixData} 
    {handleClick}
  />
  {/if}
</div>