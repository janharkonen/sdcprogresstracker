<script lang="ts">
  let { matrixData, handleClick } = $props();
  import ButtonRow from '$lib/ButtonRow.svelte';
</script>

<div class="grid gap-4">
  {#each Object.keys(matrixData) as itemKey}
    <ButtonRow
      {itemKey}
      itemData = {matrixData[itemKey]}
      {handleClick}
    />
  {/each}
</div>