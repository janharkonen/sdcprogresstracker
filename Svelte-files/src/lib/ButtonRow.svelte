<script lang="ts">
  import Button from '$lib/Button.svelte';
  
  export let item: number;
  export let usersData: { [key: string]: number };
  export let handleClick: (buttonKey: string) => void;
</script>

<div class='button-row'>
  {#each [1, 2] as user}
    <Button 
      value={usersData[`item${item}:user${user}`]} 
      on:click={() => handleClick(`item${item}:user${user}`)} 
    />
  {/each}
</div>

<style>
  .button-row {
    display: flex;
    gap: 10px; /* Adds spacing between buttons */
  }
</style>