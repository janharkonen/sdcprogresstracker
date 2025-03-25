<script lang="ts">
  let { itemnum, usersData, handleClick } = $props();
  import Button from '$lib/Button.svelte';
</script>

<div class="flex gap-4 items-center">
  <div class="w-8 font-bold text-right">{itemnum}:</div>
  {#each [1, 2] as user}
    {@const key = `item${itemnum}:user${user}`}
    <Button 
      value={usersData[key] ?? 0}
      handleClick={() => handleClick(key)}
    />
  {/each}
</div>

<style>
</style>