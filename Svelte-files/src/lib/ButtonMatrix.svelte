<script lang="ts">
  let { usersData, handleClick } = $props();
  import ButtonRow from '$lib/ButtonRow.svelte';
</script>

<div>
  {#each [1, 2, 3, 4, 5, 6] as item}
    <ButtonRow 
      item={item} 
      usersData={usersData} 
      handleClick={handleClick} 
    />
  {/each}
</div>