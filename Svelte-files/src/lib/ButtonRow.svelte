<script lang="ts">
  import Button from '$lib/Button.svelte';
  
  export let item: number;
  export let usersData: { [key: string]: number };
  export let handleClick: (buttonKey: string) => void;
</script>

<div class='button-row'>
  {#each [1, 2] as user}
    {@const key=`item${item}:user${user}`}
    <Button 
      value={usersData[key]} 
      handleClick={() => handleClick(key)} 
    />
  {/each}
</div>

<style>
  .button-row {
    display: flex;
    gap: 10px; /* Adds spacing between buttons */
  }
</style>