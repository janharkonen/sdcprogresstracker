import tailwindcss from "@tailwindcss/vite";
import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig } from 'vite';

export default defineConfig({
	plugins: [sveltekit(), tailwindcss()],
	server: {
		allowedHosts: ['sdc.janharkonen.fi'],
		watch: {
			usePolling: true,  // Helps with file watching in Docker
		},
		hmr: {
			host: '0.0.0.0',
			port: 5173, 
		}
	},
	optimizeDeps: {
		// Exclude problematic dependencies from optimization
		exclude: [
			'@tailwindcss/vite',
			'@sveltejs/kit',
			'@sveltejs/vite-plugin-svelte'
		]
	},
	build: {
		// Improve build performance
		reportCompressedSize: false,
		cssMinify: 'lightningcss'
	}
});
