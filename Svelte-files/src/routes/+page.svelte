<script lang="ts">
  import { onMount } from 'svelte';
  import ButtonMatrix from '$lib/ButtonMatrix.svelte';

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
    let newValue = (Number(usersData[buttonKey]) + 1) % 4;
    socket.send(JSON.stringify({ action: 'update', key: buttonKey, value: newValue }));
  }

  console.log(usersData);
</script>
  
<div>
  <div>
    <!-- keys in are always in this format -->
    <!-- 'item[rownumber]:user[columnnumber]'' -->
    <!-- for example 'item9:user3' -->
    <ButtonMatrix
      {usersData} 
      {handleClick} 
    />
  </div>
</div>