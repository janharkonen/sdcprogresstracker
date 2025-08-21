<script lang="ts">
	import '../app.css';
	
	let { children } = $props();
</script>

<svelte:head>
	<link rel="icon" href="https://picapi.janharkonen.fi/api/pics/6d0f03d78e4645fca50b61dfc3d0d0d9.png" type="image/x-icon">
	<link rel="shortcut icon" href="https://picapi.janharkonen.fi/api/pics/6d0f03d78e4645fca50b61dfc3d0d0d9.png" type="image/x-icon">
</svelte:head>

<div class="container mx-auto py-8 px-4 max-w-250 text-xs md:text-lg">
	<h1 class="text-2xl md:text-3xl pb-8 font-bold text-center">SDC Taitomerkki</h1>
	{@render children()}
</div>
