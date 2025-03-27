<script lang="ts">
	import '../app.css';
	let { children } = $props();
</script>

<div class="container mx-auto p-4">
  <h1 class="text-2xl font-bold mb-4">SDC Taitomerkki</h1>
	{@render children()}
</div>
