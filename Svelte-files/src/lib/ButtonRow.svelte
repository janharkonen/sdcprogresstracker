<script lang="ts">
  let { itemnum, matrixData, handleClick } = $props();
  import Button from '$lib/Button.svelte';
  import { getUserCount } from '$lib/dataUtils';
  const userCount = getUserCount(matrixData)
  const numArray = Array.from(Array(userCount), (_, i) => i + 1) 
</script>

<div class="flex gap-4 items-center">
  <div class="w-8 font-bold text-right">{itemnum}:</div>
  {#each numArray as user}
    {@const key = `item${itemnum}:user${user}`}
    <Button 
      value={matrixData[key] ?? 0}
      handleClick={() => handleClick(key)}
    />
  {/each}
</div>

<style>
</style>