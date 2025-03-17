<script lang="ts">
  import ButtonRow from '$lib/ButtonRow.svelte';
  export let usersData: { [key: string]: number };
  export let handleClick: (buttonKey: string) => void;
</script>

<div>
  {#each [1, 2, 3, 4, 5, 6] as item}
    <ButtonRow 
      {item} 
      {usersData} 
      {handleClick} 
    />
  {/each}
</div>