<script lang="ts">
    import { increaseState, getState } from "$lib/functions/stateEncoding";

    let { socket, progressState, row, column, colCount } = $props();

    let state = $derived(getState(progressState, row, column, colCount));

    const bgColor = $derived(
        Number(state) === 1 ? 'bg-red-400' :
        Number(state) === 2 ? 'bg-yellow-400' :
        Number(state) === 3 ? 'bg-green-400' :
                  'bg-gray-400'
    );

    function handleClick() {
        const newProgressState = increaseState(progressState, row, column, colCount);
        socket.send(newProgressState);
    }
</script>

<button onmousedown={handleClick} class="{bgColor} text-white font-bold w-full h-full rounded shadow-md border border-gray-300">
    {state}
</button>

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