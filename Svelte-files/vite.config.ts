import tailwindcss from "@tailwindcss/vite";
import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig } from 'vite';

export default defineConfig({
	plugins: [sveltekit(), tailwindcss()],
	server: {
		allowedHosts: ['sdc.janharkonen.fi'],
	},
	optimizeDeps: {
		exclude: ['@tailwindcss/vite'] // Exclude the problematic dependency
	},
	build: {
		// Improve build performance
		reportCompressedSize: false,
		cssMinify: 'lightningcss'
	}
});
