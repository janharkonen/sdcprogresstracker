<script lang="ts">
    let { socket, progressState, row, column } = $props();

    let state = $derived((BigInt(progressState) >> BigInt(2 * (column+4*row) )) & 0b11n);

    const bgColor = $derived(
        Number(state) === 1 ? 'bg-red-400' :
        Number(state) === 2 ? 'bg-yellow-400' :
        Number(state) === 3 ? 'bg-green-400' :
                  'bg-gray-400'
    );
</script>

<button class="{bgColor} text-white font-bold w-full h-full rounded shadow-md border border-gray-300">
    {state}
</button>
