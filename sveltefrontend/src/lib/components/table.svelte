<script lang="ts">
    import { StateButton } from "$lib";

    let { songlist, singerlist, progressState, socket } = $props();
    const colCount = $derived(singerlist.length);
</script>

<table class="table-fixed w-full">
    <thead class="sticky top-0 bg-yellow-200">
        <tr>
            <th></th>
            {#each singerlist as singer}
                <th>{singer}</th>
            {/each}
        </tr>
    </thead>
    {#if songlist}
        <tbody>
            {#each songlist as song, i}
                <tr>
                    <td>{i + 1}. {song}</td>
                    {#each singerlist as _, j}
                    <td>
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