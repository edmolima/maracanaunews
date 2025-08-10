import { defineConfig } from 'eslint/config';
import tseslint from '@typescript-eslint/eslint-plugin';
import tsparser from '@typescript-eslint/parser';
import prettier from 'eslint-config-prettier';

export default defineConfig([
  {
	files: ['**/*.ts', '**/*.tsx'],
	languageOptions: {
	  parser: tsparser,
	  parserOptions: {
		sourceType: 'module',
	  },
	},
	plugins: {
	  '@typescript-eslint': tseslint,
	},
	rules: {
	  ...tseslint.configs.recommended.rules,
	  semi: 'error',
	  'prefer-const': 'error',
	},
  },
  prettier,
]);