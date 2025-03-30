<script lang="ts">
  import { onMount } from 'svelte';
  
  let { rows } = $props();
  let randomIndex = $state(0);
  let randomItem = $derived(rows[randomIndex]);
  let isAnimating = $state(false);
  
  function changeRandomIndex() {
    if (!rows || rows.length === 0) return 'No items available';
    randomIndex = Math.floor(Math.random() * rows.length);
  }

  function handleClick() {
    isAnimating = true;
    
    // Create animation effect by rapidly changing values
    let iterations = 0;
    const maxIterations = 15;
    const interval = setInterval(() => {
      changeRandomIndex();
      iterations++;
      
      if (iterations >= maxIterations) {
        clearInterval(interval);
        isAnimating = false;
      }
    }, 75);
  }

  onMount(() => {
    // Initialize with a random item if rows is available
    if (rows && rows.length > 0) {
      changeRandomIndex();
    }
  });
</script>

<div class="container mx-auto px-4 my-6">
  <div class="bg-gradient-to-r from-indigo-100 to-purple-100 rounded-xl shadow-lg overflow-hidden">
    <div class="p-6">
      
      <div class="flex flex-col md:flex-row items-center gap-4">
        <button
          class="bg-indigo-600 hover:bg-indigo-700 text-white font-bold py-3 px-6 rounded-lg shadow-md transition-all duration-300 transform hover:scale-105 active:scale-95 disabled:opacity-70 disabled:cursor-not-allowed"
          onmousedown={handleClick}
          disabled={isAnimating}
        >
          {isAnimating ? 'Selecting...' : 'Get Random Item'}
        </button>
        
        <div class="bg-white p-4 rounded-lg shadow-inner min-h-14 min-w-48 flex items-center justify-center border border-gray-200">
          <p class={`${isAnimating ? 'text-indigo-600 animate-pulse' : 'text-gray-800'}`}>
            {randomIndex}. {randomItem}
          </p>
        </div>
      </div>
    </div>
  </div>
</div>

<style>
  button {
    cursor: pointer;
    transition: all 0.3s ease;
  }
  
  button:focus {
    outline: 2px solid rgba(99, 102, 241, 0.5);
    outline-offset: 2px;
  }
  
  @keyframes pulse {
    0%, 100% { opacity: 1; }
    50% { opacity: 0.6; }
  }
  
  .animate-pulse {
    animation: pulse 1.5s cubic-bezier(0.4, 0, 0.6, 1) infinite;
  }
</style>