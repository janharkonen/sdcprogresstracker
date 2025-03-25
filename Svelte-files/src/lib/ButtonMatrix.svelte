<script lang="ts">
  let { matrixData, handleClick } = $props();
  import ButtonRow from '$lib/ButtonRow.svelte';
  import { getItemCount } from '$lib/dataUtils';
  const itemCount = getItemCount(matrixData)
  const numArray = Array.from(Array(itemCount), (_, i) => i + 1) 
</script>

<div class="grid gap-4">
  {#each numArray as itemnum}
    <ButtonRow 
      {itemnum}
      {matrixData}
      {handleClick}
    />
  {/each}
</div>