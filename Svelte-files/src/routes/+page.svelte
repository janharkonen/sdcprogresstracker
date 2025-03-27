<script lang="ts">
  import { onMount, onDestroy } from 'svelte';
  import ButtonMatrix from '$lib/ButtonMatrix.svelte';
  import { itemList, userList } from '$lib/tableData';

  let socket = $state<WebSocket | null>(null);
  let matrixData = $state<Record<string, string>>({});
  let isConnected = $state(false);
  let isDataLoaded = $state(false);  // Add a new state to track if data is loaded

  $inspect(matrixData)
  $inspect(matrixData['item1:user3'])
  onMount(() => {
    socket = new WebSocket(import.meta.env.VITE_WEBSOCKET_URL);

    socket.onopen = () => {
      console.log('WebSocket connected');
      isConnected = true;
    };

    socket.onmessage = (event) => {
      const message = JSON.parse(event.data);
      console.log(message.data)
      if (message.type === 'initial_data') {
        matrixData = {...message.data}
        isDataLoaded = true;
      } else {
        matrixData = { 
          ...matrixData, 
          [message.key]: message.value
        }
      };
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

</script>
  
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
  rows={itemList}
  cols={userList}
  {matrixData} 
  {socket}
/>
{/if}