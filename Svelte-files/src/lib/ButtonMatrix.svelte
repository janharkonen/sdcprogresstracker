<script lang="ts">
  let { matrixData, itemData, userData, handleClick } = $props();
  import ButtonRow from '$lib/ButtonRow.svelte';
  import { getItemCount } from '$lib/dataUtils';
  const itemCount = getItemCount(matrixData)
  const countArray = Array.from(Array(itemCount), (_, i) => i + 1) 
</script>

<div class="grid gap-4">
  {#each countArray as itemNum}
    {@const itemKey = `item${itemNum}`}
    <ButtonRow
      itemName = {itemData[itemKey]}
      {itemNum}
      {matrixData}
      {handleClick}
    />
  {/each}
</div>