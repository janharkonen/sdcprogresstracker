<script lang="ts">
	import '../app.css';
	import favicon from '$lib/assets/favicon.svg';
	
	let { children } = $props();
</script>

<svelte:head>
	<link rel="icon" href={favicon} />
</svelte:head>

<div class="container mx-auto py-8 px-4 max-w-250 text-xs md:text-lg">
	<h1 class="text-2xl md:text-3xl pb-8 font-bold text-center">SDC Taitomerkki</h1>
	{@render children()}
</div>
