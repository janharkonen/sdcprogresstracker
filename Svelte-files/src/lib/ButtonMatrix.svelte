<script lang="ts">
  let { usersData, handleClick } = $props();
  import ButtonRow from '$lib/ButtonRow.svelte';
</script>

<div class="grid gap-4">
  {#each [1, 2, 3, 4, 5, 6] as item}
    <ButtonRow 
      {item}
      {usersData}
      {handleClick}
    />
  {/each}
</div>