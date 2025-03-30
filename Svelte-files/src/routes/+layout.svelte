<script lang="ts">
	import '../app.css';
	let { children } = $props();
</script>

<div class="container mx-auto py-8 px-4 max-w-250 text-xs md:text-lg">
<h1 class="text-2xl md:text-3xl pb-8 font-bold text-center">SDC Taitomerkki</h1>
{@render children()}
</div>

