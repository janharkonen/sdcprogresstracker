<script lang="ts">
  let { value, handleClick } = $props();

  const bgColor = $derived(
    Number(value) === 1 ? 'bg-red-400' :
    Number(value) === 2 ? 'bg-yellow-400' :
    Number(value) === 3 ? 'bg-green-400' :
                  'bg-gray-400'
  );
</script>

<button 
  class="{bgColor} text-white font-bold py-2 px-4 rounded shadow-md border border-gray-300"
  onclick={handleClick}>
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