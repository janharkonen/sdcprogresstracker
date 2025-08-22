<script lang="ts">
    let { songlist, progressState } = $props();
</script>

<table class="table-fixed flex justify-center">
    <thead class="sticky top-0">
        <tr>
            <th></th>
            <th>Progress</th>
            <th>State</th>
        </tr>
    </thead>
    {#if songlist}
        <tbody>
            {#each songlist as song}
                <tr>
                    <td>{song}</td>
                    <td>{progressState}</td>
                </tr>
            {/each}
        </tbody>
    {/if}
</table>