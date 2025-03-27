<script lang="ts">
  let { redisKey, value, socket } = $props();
  const bgColor = $derived(
    Number(value) === 1 ? 'bg-red-400' :
    Number(value) === 2 ? 'bg-yellow-400' :
    Number(value) === 3 ? 'bg-green-400' :
                  'bg-gray-400'
  );

  function handleClick() {
    if (!socket || socket.readyState !== WebSocket.OPEN) {
      console.error('WebSocket is not connected');
      return;
    }
    const newValue = String((Number(value) + 1) % 4);
    try {
      socket.send(JSON.stringify({ action: 'update', key: redisKey, value: newValue }));
    } catch (err) {
      console.error('Error sending message: ',err)
    }
  }
</script>

<button 
  class="{bgColor} text-white font-bold py-2 px-4 rounded shadow-md border border-gray-300"
  onmousedown={handleClick}>
  {value}
</button>

<style>
  button {
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.2s ease;
  }

  button:hover {
    transform: scale(1.05); /* Lätt förstoring vid hover för bättre användarupplevelse */
  }

  button:active {
    transform: scale(0.95); /* Liten intryckningseffekt vid klick */
  }
</style>