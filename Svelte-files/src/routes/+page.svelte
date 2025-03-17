<script lang="ts">
  import { onMount } from 'svelte';
  import Button from '$lib/Button.svelte';

  let socket: WebSocket;
  let usersData: { [key: string]: number } = {};


  onMount(() => {
    socket = new WebSocket(import.meta.env.VITE_WEBSOCKET_URL);

    socket.onopen = () => {
      console.log('WebSocket connected');
    };

    socket.onmessage = (event) => {
      const message = JSON.parse(event.data);
      if (message.type === 'initial_data') {
        usersData = message.data;
      } else {
        usersData[message.key] = message.value;
      }
    };

    socket.onerror = (err) => console.error('WebSocket error:', err);

    socket.onclose = () => console.log('WebSocket disconnected');
  });

  function handleClick(buttonKey: string) {
    const newValue = Number(usersData[buttonKey]) + 1;
    socket.send(JSON.stringify({ action: 'update', key: buttonKey, value: newValue }));
  }

  console.log(usersData);
</script>
  
<div>
  <div>
    <!-- keys in are always in this format -->
    <!-- 'item[rownumber]:user[columnnumber]'' -->
    <!-- for example 'item9:user3' -->
    {#each [1, 2, 3, 4, 5, 6] as item}
      <div class='button-row'>
        {#each [1, 2] as user}
          <Button 
            value={usersData[`item${item}:user${user}`]} 
            on:click={() => handleClick(`item${item}:user${user}`)} 
          />
        {/each}
      </div>
    {/each}
  </div>
</div>

<style>
    .button-row {
        display: flex;
        gap: 10px; /* Adds spacing between buttons */
    }
</style>