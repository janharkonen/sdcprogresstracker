<script lang="ts">
  let { usersData, handleClick } = $props();
  import ButtonRow from '$lib/ButtonRow.svelte';
  import { getItemNum } from '$lib/dataUtils';
  const itemCount = getItemNum(usersData)

</script>

<div class="grid gap-4">
  {#each Array.from(Array(itemCount), (_, i) => i + 1) as itemnum}
    <ButtonRow 
      {itemnum}
      {usersData}
      {handleClick}
    />
  {/each}
</div>