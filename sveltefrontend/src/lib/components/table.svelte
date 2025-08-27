<script lang="ts">
    import { StateButton } from "$lib";
    
    let { songlist, singerlist, progressState, socket } = $props();
    const colCount = $derived(singerlist.length);
</script>

<table class="table-fixed w-full">
    <thead class="sticky top-0 bg-yellow-200 z-10">
        <tr class="h-8 sm:h-12">
            <th class="w-1/3"></th>
            {#each singerlist as singer}
            <th class="w-1/6">{singer}</th>
            {/each}
        </tr>
    </thead>
    {#if songlist}
    <tbody>
        {#each songlist as song, i}
            <tr class="h-10 sm:h-14 hover:bg-yellow-200">
                    <td 
                    id={`song-${i}`}
                    class="h-full px-2 sm:px-4 whitespace-nowrap overflow-hidden text-ellipsis relative"
                    title={song}
                    >
                        <span class="font-bold text-xs sm:text-base text-yellow-600">
                            {i + 1}. 
                        </span>
                        <span class="font-bold text-xs sm:text-base overflow-wrap whitespace-normal text-gray-700">
                            {song}
                        </span>
                    </td>
                    {#each singerlist as _, j}
                    <td class="h-10 sm:h-14 p-0.25">
                        <StateButton 
                            socket={socket}
                            progressState={progressState}
                            row={i}
                            column={j}
                            colCount={colCount}
                        />
                    </td>
                    {/each}
                </tr>
            {/each}
        </tbody>
    {/if}
</table>