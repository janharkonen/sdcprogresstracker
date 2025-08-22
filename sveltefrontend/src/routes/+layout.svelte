<script lang="ts">
	import '../app.css';
	
	let { children } = $props();
</script>

<svelte:head>
	<link rel="icon" href="https://picapi.janharkonen.fi/api/pics/6d0f03d78e4645fca50b61dfc3d0d0d9.png" type="image/x-icon">
	<link rel="shortcut icon" href="https://picapi.janharkonen.fi/api/pics/6d0f03d78e4645fca50b61dfc3d0d0d9.png" type="image/x-icon">
</svelte:head>

<script lang="ts" module>
	function handleScroll() {
		const header = document.querySelector('header');
		if (!header) return;
		
		const currentScrollPos = window.scrollY;
		
		if (currentScrollPos === 0) {
			// At the top - show header
			header.style.transform = 'translateY(0)';
		} else {
			// Not at the top - hide header
			header.style.transform = 'translateY(-100%)';
		}
	}
</script>

<svelte:window on:scroll={handleScroll} />

<header class="p-2 text-l sm:text-2xl sticky top-0 z-50 w-full bg-gray-100/80 backdrop-blur-sm shadow-md h-12 sm:h-16 transition-transform duration-300">
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
<div class="container mx-auto max-w-250 text-xs md:text-lg">
	{@render children()}
</div>

<style>
</style>
