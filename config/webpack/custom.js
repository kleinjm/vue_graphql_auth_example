const path = require('path');
const webpack = require('webpack');
const { VueLoaderPlugin } = require('vue-loader');

module.exports = {
  plugins: [
    // See https://github.com/moment/moment/issues/2979#issuecomment-189899510
    new webpack
      .ContextReplacementPlugin(/\.\/locale$/, 'empty-module', false, /js$/),
    new VueLoaderPlugin(),
  ],
  resolve: {
    modules: [
      path.resolve('./app/javascript/'),
    ],
    alias: {
      '~components': path.resolve('./app/javascript/components'),
      '~configuration': path.resolve('./app/javascript/packs/configuration'),
      '~lib': path.resolve('./app/javascript/lib'),
      '~mixins': path.resolve('./app/javascript/mixins'),
      '~mutations': path.resolve('./app/javascript/mutations'),
      '~pages': path.resolve('./app/javascript/pages'),
      '~queries': path.resolve('./app/javascript/queries'),
      '~store': path.resolve('./app/javascript/store'),
    },
    extensions: ['*', '.js', '.vue', '.json'],
  },
};
