<script lang="ts">
  import { onMount } from 'svelte';
  import Button from '$lib/Button.svelte';

  let socket: WebSocket;
  let buttonValues: { [key: string]: number } = {};

  onMount(() => {
    socket = new WebSocket(import.meta.env.VITE_WEBSOCKET_URL);

    socket.onopen = () => {
      console.log('WebSocket connected');
    };

    socket.onmessage = (event) => {
      const message = JSON.parse(event.data);
      if (message.type === 'initial_data') {
        buttonValues = message.data;
      } else {
        buttonValues[message.key] = message.value;
      }
    };

    socket.onerror = (err) => console.error('WebSocket error:', err);

    socket.onclose = () => console.log('WebSocket disconnected');
  });

  function handleClick(buttonKey: string) {
    buttonValues[buttonKey]++; // Instant UI update
    socket.send(JSON.stringify({ action: 'update', key: buttonKey, value: buttonValues[buttonKey] }));
  }
</script>

<div>
  {#each Object.entries(buttonValues) as [key, value]}
    <Button value={value} on:click={() => handleClick(key)} />
  {/each}
</div>