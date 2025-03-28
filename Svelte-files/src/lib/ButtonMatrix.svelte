<script lang="ts">
  import Button from "./Button.svelte";
  let { rows, cols, matrixData, socket } = $props();
  const userCount = 4;
  const itemCount = 40;
</script>

<div class="container mx-auto py-8 px-4 max-w-250">
  <div class="overflow-auto rounded-lg shadow-md border border-gray-200">
    <table class="w-full border-collapse bg-white text-xs md:text-lg">
      <thead>
        <tr class="bg-gray-100">
          <th class="sticky left-0 z-10 bg-gray-100 p-3 md:min-w-36 text-left font-semibold"></th>
          {#each Array(userCount) as _, col}
            <th class="p-3 text-center font-semibold min-w-15">
              {cols[col]}
            </th>
          {/each}
        </tr>
      </thead>
      <tbody>
        {#each Array(itemCount) as _, row}
          <tr class="hover:bg-gray-50 transition-colors">
            <td class="sticky z-10 p-3 font-medium wrap max-w-32">{row+1}. {rows[row]}</td>
            {#each Array(userCount) as _, col}
              {@const redisKey=`item${row+1}:user${col+1}`}
              <td class="p-0 text-center transition-all h-12">
                <div class="w-full h-full">
                  <Button 
                    redisKey={redisKey}
                    value={matrixData[redisKey]}
                    {socket}
                  />
                </div>
              </td>
            {/each}
          </tr>
        {/each}
      </tbody>
    </table>
  </div>
</div>

<style>
  /* Custom scrollbar for better user experience */
  :global(::-webkit-scrollbar) {
    width: 8px;
    height: 8px;
  }
  
  :global(::-webkit-scrollbar-track) {
    background: #f1f1f1;
    border-radius: 10px;
  }
  
  :global(::-webkit-scrollbar-thumb) {
    background: #c1c1c1;
    border-radius: 10px;
  }
  
  :global(::-webkit-scrollbar-thumb:hover) {
    background: #a8a8a8;
  }
  
  /* For Firefox */
  :global(html) {
    scrollbar-width: thin;
    scrollbar-color: #c1c1c1 #f1f1f1;
  }
</style>