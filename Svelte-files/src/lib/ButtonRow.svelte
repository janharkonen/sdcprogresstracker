<script lang="ts">
  let { itemKey, itemData, handleClick } = $props();
  import Button from '$lib/Button.svelte';
</script>

<div class="flex gap-4 items-center">
  <div class="w-16 font-bold text-right">{itemData['itemname']}:</div>
  {#each Object.keys(itemData).filter(key => key !== 'itemname') as userKey}
    {@const redisKey = `${itemKey}:${userKey}`}
    <Button 
      value={itemData[userKey] ?? 0}
      handleClick={() => handleClick(redisKey)}
    />
  {/each}
</div>

<style>
</style>