// Generated by CoffeeScript 1.7.1
(function() {
  define(['c/controllers', 's/aggregates'], function(controllers) {
    'use strict';
    return controllers.controller('dashboard', [
      '$scope', 'aggregates', function($scope, aggregates) {
        return $scope.aggregates = aggregates.get();
      }
    ]);
  });

}).call(this);
