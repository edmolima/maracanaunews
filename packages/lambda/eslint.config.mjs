import config from '@maracanaunews/eslint-config';

export default config.map((cfg) =>
  cfg.files
    ? {
        ...cfg,
        languageOptions: {
          ...cfg.languageOptions,
          parserOptions: {
            ...(cfg.languageOptions?.parserOptions || {}),
            project: './tsconfig.json',
          },
        },
      }
    : cfg,
);
