<script lang="ts">
    import { increaseState, getState } from "$lib";

    let { socket, progressState, row, column, colCount } = $props();

    let position = $derived(row * colCount + column);
    let state = $derived(getState(progressState, position));

    const bgColor = $derived(
        Number(state) === 1 ? 'bg-red-400' :
        Number(state) === 2 ? 'bg-yellow-400' :
        Number(state) === 3 ? 'bg-green-400' :
                  'bg-gray-400'
    );

    function handleClick() {
        const newProgressState = increaseState(progressState, position);
        socket.send(newProgressState);
    }
</script>


<style>
  button {
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.2s ease;
  }
  
  button:hover {
    transform: scale(1.03);
  }
  
  button:active {
    transform: scale(0.97);
  }
</style>

<button onmousedown={handleClick} 
class="{bgColor} text-white w-full h-full font-bold rounded"
>
  {state}
</button>