exports.config = {
  "modules": [
    "copy",
    "server",
    "jshint",
    "csslint",
    "require",
    "minify-js",
    "minify-css",
    "live-reload",
    "bower",
    "coffeescript",
    "less",
    "jade"
  ],
  "template": {
    "outputFileName": "javascripts/admin-templates"
  },
  require: {
    commonConfig: 'admin-requirejs-config'
  }
}