import tailwindcss from '@tailwindcss/vite';
import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig } from 'vite';

export default defineConfig({
	plugins: [
		tailwindcss({
			content: {
				files: ['./src/**/*.{svelte,js,ts,html}'],
				transform: {
					svelte: (content) => {
						// Remove Svelte component tags during scanning to prevent parsing errors
						return content.replace(/<[^>]*>/g, '');
					}
				}
			}
		}),
		sveltekit()
	]
});
