<script lang="ts">
  import { onMount } from 'svelte';
  import Button from '$lib/Button.svelte';

  let socket: WebSocket;
  let buttonValues: { [key: string]: number } = {};

  onMount(() => {
    socket = new WebSocket('ws://localhost:8080');

    socket.onopen = () => {
      console.log('WebSocket connected');
      buttonValues = { 
        'item1:user1': 0,
        'item2:user1': 0,
        'item3:user1': 0,
        'item4:user1': 0,
      };
    };

    socket.onmessage = (event) => {
      const { key, value } = JSON.parse(event.data);
      buttonValues[key] = parseInt(value, 10);
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