<script lang="ts">
  import { onMount, onDestroy } from 'svelte';
  import ButtonMatrix from '$lib/ButtonMatrix.svelte';
  import Randomizer from '$lib/Randomizer.svelte';
  import { itemList, userList } from '$lib/tableData';

  let socket = $state<WebSocket | null>(null);
  let matrixData = $state<Record<string, string>>({});
  let isConnected = $state(false);
  let isDataLoaded = $state(false);  // Add a new state to track if data is loaded

  onMount(() => {
    const wsUrl = import.meta.env.VITE_APP_WEBSOCKET_URL;
    console.log(wsUrl)
    socket = new WebSocket(wsUrl);

    socket.onopen = () => {
      console.log('WebSocket connected');
      isConnected = true;
    };

    socket.onmessage = (event) => {
      const message = JSON.parse(event.data);
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
<div class="container mx-auto py-8 px-4 max-w-250 text-xs md:text-lg">
<ButtonMatrix
  rows={itemList}
  cols={userList}
  {matrixData} 
  {socket}
  />
<Randomizer rows={itemList}/>
</div>
{/if}