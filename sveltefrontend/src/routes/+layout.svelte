<script lang="ts">
	import '../app.css';
	
	let { children } = $props();
</script>

<svelte:head>
	<link rel="icon" href="https://picapi.janharkonen.fi/api/pics/6d0f03d78e4645fca50b61dfc3d0d0d9.png" type="image/x-icon">
	<link rel="shortcut icon" href="https://picapi.janharkonen.fi/api/pics/6d0f03d78e4645fca50b61dfc3d0d0d9.png" type="image/x-icon">
</svelte:head>

<header class="p-2 text-l sm:text-2xl sticky top-0 z-50 w-full bg-gray-100/80 backdrop-blur-sm shadow-md h-12 sm:h-16">
	<div class="flex flex-row items-center h-full">
	  	<div class="flex-1 flex justify-start items-center gap-2">
			<img src="https://picapi.janharkonen.fi/api/pics/6d0f03d78e4645fca50b61dfc3d0d0d9.png" alt="SDC Taitomerkki" class="max-h-12 sm:max-h-16 aspect-ratio">
			<p>SDC Taitomerkki</p>
	  	</div>
		<!--
	  	<div class="flex justify-center">
			contact
	  	</div>
	  	
	  	<div class="flex-1 flex justify-end">
			dark mode
	  	</div>-->
	</div>
</header>
<div class="container py-8 sm:px-4 max-w-250 text-xs md:text-lg bg-red-500">
	{@render children()}
</div>

<style>
	div {
		background-color: var(--table-color);
	}
</style>
