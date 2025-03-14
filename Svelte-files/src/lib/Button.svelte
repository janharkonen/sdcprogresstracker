<script lang="ts">
    import { onMount } from 'svelte';
    import { writable } from 'svelte/store';

    export let key : string;

    const value = writable(0);
    
    let socket : WebSocket;
    
    onMount(() => {
        socket = new WebSocket(import.meta.env.VITE_WEBSOCKET_URL);
        
        socket.onopen = () => {
          socket.send(JSON.stringify({ action: 'subscribe', key: key }));
        }

        socket.onmessage = (event) => {
          const { key: receivedKey, value: newValue } = JSON.parse(event.data);
          if (receivedKey === key) {
            value.set(newValue);
          }
        };

        return () => {
          socket.close();
        };
    });
    
    const updateValue = () => {
        const newValue = '12';
        socket.send(JSON.stringify({ action: 'update', key, value: newValue }));
    };
</script>


<button on:click={updateValue}>
    {#await $value}
      Loading...
    {:then val}
      {val}
    {/await}
</button>