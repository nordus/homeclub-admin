// Generated by CoffeeScript 1.7.1
(function() {
  var bodyParser, compress, engines, envConfig, errorHandler, express, favicon, methodOverride;

  express = require('express');

  engines = require('consolidate');

  favicon = require('static-favicon');

  bodyParser = require('body-parser');

  methodOverride = require('method-override');

  compress = require('compression');

  errorHandler = require('errorhandler');

  envConfig = require('./server/config/env-config');

  exports.startServer = function(config, callback) {
    var app, port, router, server, viewOptions, _ref, _ref1;
    port = config.server.port || process.env.PORT;
    app = express();
    server = config.httpServer || app.listen(port, function() {
      return console.log("Express server listening on port %d in %s mode", server.address().port, app.settings.env);
    });
    app.set('port', port);
    app.set('views', "" + envConfig.rootPath + "/views");
    app.engine(config.server.views.extension, engines[config.server.views.compileWith]);
    app.set('view engine', config.server.views.extension);
    app.use(favicon());
    app.use(methodOverride());
    app.use(compress());
    app.use(express["static"](config.watch.compiledDir));
    if (app.get('env') === 'development') {
      app.use(errorHandler());
    }
    viewOptions = {
      reload: ((_ref = config.liveReload) != null ? _ref.enabled : void 0) != null ? config.liveReload.enabled : void 0,
      optimize: (_ref1 = config.isOptimize) != null ? _ref1 : false,
      cachebust: process.env.NODE_ENV !== "production" ? "?b=" + ((new Date()).getTime()) : ''
    };
    router = express.Router();
    router.route('/homeclub').get(function(req, res) {
      return res.render('homeclub', viewOptions);
    });
    router.route('/carrier').get(function(req, res) {
      return res.render('carrier/carrier', viewOptions);
    });
    app.use(router);
    if (callback) {
      return callback(server);
    } else {
      config.liveReload.additionalDirs = config.liveReload.additionalDirs.concat(["" + envConfig.rootPath + "public/javascripts", "" + envConfig.rootPath + "views"]);
      return app;
    }
  };

}).call(this);