env       = process.env.NODE_ENV || 'development'
path      = require('path')
rootPath  = path.normalize __dirname + '/../../'


config =

  development:
    rootPath  : rootPath
    
  production:
    rootPath  : rootPath

module.exports = config[env]