module.exports = {
  test: {
    globals: true,
    environment: 'node',
    coverage: {
      reporter: ['text', 'json', 'html'],
    },
    tsconfig: require('path').resolve(
      __dirname,
      '../tsconfig/tsconfig.test.json'
    ),
  },
};
