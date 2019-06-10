// Dependencies:
// eslint
// babel-eslint
// eslint-plugin-import
// eslint-plugin-react
// eslint-plugin-jsx-a11y
// eslint-config-airbnb
// eslint-import-resolver-node

module.exports = {
  env: {
    browser: true,
    commonjs: true,
    es6: true,
    node: true,
  },
  extends: [
    'eslint:recommended',
    'plugin:react/recommended',
    'airbnb',
  ],
  parser: 'babel-eslint',
  parserOptions: {
    ecmaVersion: 2018,
    ecmaFeatures: {
      experimentalObjectRestSpread: true,
      jsx: true,
      classes: true,
    },
    sourceType: 'module',
  },
  plugins: ['import', 'react'],
  rules: {
    indent: ['error', 2],
    quotes: ['error', 'single'],
    semi: ['error', 'never'],
    camelcase: 0,
    'max-len': 0,
    'no-plusplus': ['error', { allowForLoopAfterthoughts: true }],
    'object-curly-newline': 0,
    'arrow-body-style': 0,
    'no-multiple-empty-lines': ['error', { max: 1, maxEOF: 0, maxBOF: 0 }],
    'import/no-unresolved': [2, { commonjs: true }],
    'react/jsx-one-expression-per-line': 0,
    'react/no-array-index-key': 1,
  },
}
