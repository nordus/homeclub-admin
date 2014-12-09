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
    "jade",
    "web-package"
  ],
  "bower": {
    "copy": {
      "unknownMainFullCopy": true
    }
  },
  template: {
    output: [{
      folders:["javascripts/carrier/templates"],
      outputFileName: "javascripts/carrier-templates"
    },
      {
        folders:["javascripts/homeclub/templates"],
        outputFileName: "javascripts/homeclub-templates"
      }]
  },
  require: {
     commonConfig: 'admin-requirejs-config'
  },
  minifyJS: {
    mangleNames: false
  }
}