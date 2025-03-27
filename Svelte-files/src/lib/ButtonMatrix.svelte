<script lang="ts">
  import Button from "./Button.svelte";
  let { rows, cols, matrixData, socket } = $props();
  const userCount = 4
  const itemCount = 40

</script>

<div class="container mx-auto py-8 px-4">
  <h1 class="text-2xl font-bold mb-6">User-Item Grid</h1>

  <div class="overflow-auto">
    <table class="max-w-400 border-collapse">
      <thead>
        <tr class="bg-muted/50">
          <th class="sticky left-0 bg-muted/50 p-3 text-left font-medium border">Items / Users</th>
            {#each {length: userCount }, col}
              <th class="p-3 w-32 text-left font-medium border">
                {cols[col]}
              </th>
            {/each}
        </tr>
      </thead>
      <tbody>
        {#each { length: itemCount }, row}
          <tr class="hover:bg-muted/20">
            <td class="sticky left-0 bg-background p-3 font-medium border">{rows[row]}</td>
            {#each {length: userCount }, col}
              {@const redisKey=`item${row+1}:user${col+1}`}
              <td class="p-2 border text-center">
              <Button 
                {redisKey}
                value={matrixData[redisKey]}
                {socket}
              />
              </td>
            {/each}
          </tr>
        {/each}
      </tbody>
    </table>
  </div>
</div>