import adapter from '@sveltejs/adapter-node';
import { vitePreprocess } from '@sveltejs/vite-plugin-svelte';

/** @type {import('@sveltejs/kit').Config} */
const config = {
	// Consult https://svelte.dev/docs/kit/integrations
	// for more information about preprocessors
	preprocess: vitePreprocess(),

	compilerOptions: {
		runes: true
	},

	kit: {
		// Using adapter-node explicitly configured
		adapter: adapter({
			// Output to build directory
			out: 'build',
			// Don't precompress assets (can cause issues in some Docker setups)
			precompress: false,
			// Generate a standalone server with embedded dependencies
			// This makes it more self-contained for Docker
			envPrefix: 'VITE_',
		}),
		alias: {
			$lib: 'src/lib'
		}
	}
};

export default config;