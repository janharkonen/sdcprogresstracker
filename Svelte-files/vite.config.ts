import tailwindcss from "@tailwindcss/vite";
import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig } from 'vite';

export default defineConfig({
	plugins: [sveltekit(), tailwindcss()],
	server: {
		allowedHosts: ['sdc.janharkonen.fi'],
		fs: {
			// Allow serving files from one level up the project root
			allow: ['..']
		}
	},
	envPrefix: 'APP_',
	optimizeDeps: {
		// Exclude dependencies that might be causing issues with optimization
		exclude: ['svelte/internal', '@sveltejs/kit', 'svelte']
	},
	// Add better caching and dependency handling for Docker environments
	cacheDir: './.vite',
	build: {
		// Improve build reliability
		emptyOutDir: true,
		// Add source maps for better debugging
		sourcemap: true
	}
});