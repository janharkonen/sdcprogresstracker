<script lang="ts">
  let { itemName, itemNum, matrixData, handleClick } = $props();
  import Button from '$lib/Button.svelte';
  import { getUserCount } from '$lib/dataUtils';
  const userCount = getUserCount(matrixData)
  const countArray = Array.from(Array(userCount), (_, i) => i + 1) 
</script>

<div class="flex gap-4 items-center">
  <div class="w-16 font-bold text-right">{itemName}:</div>
  {#each countArray as userNum}
    {@const key = `item${itemNum}:user${userNum}`}
    <Button 
      value={matrixData[key] ?? 0}
      handleClick={() => handleClick(key)}
    />
  {/each}
</div>

<style>
</style>