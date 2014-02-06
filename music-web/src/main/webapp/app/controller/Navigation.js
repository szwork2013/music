'use strict';

/**
 * Navigation controller.
 */
App.controller('Navigation', function($rootScope, $scope, User, $state) {
  // Returns true if the user is admin
  $scope.$watch('userInfo', function(userInfo) {
    $scope.isAdmin = userInfo && userInfo.base_functions && userInfo.base_functions.indexOf('ADMIN') != -1;
  });
  
  // Load user data
  User.userInfo().then(function(data) {
    $rootScope.userInfo = data;
  });
  
  // User logout
  $scope.logout = function($event) {
    User.logout().then(function() {
      User.userInfo(true).then(function(data) {
        $rootScope.userInfo = data;
      });
      $state.transitionTo('login');
    });
    $event.preventDefault();
  };

  // Watch search query
  $scope.$watch('query', function(newval) {
    if (typeof newval == 'undefined') {
      return;
    }

    if (newval.length >= 3) {
      var isSearchView = $state.current.name == 'main.search';
      $state.go('main.search', {
        query: newval
      }, {
        location: isSearchView ? 'replace' : true,
        notify: !isSearchView
      });
    }
  });

  // Listen for state changes to sync the search form
  $rootScope.$on('$stateChangeStart',
      function(event, toState, toParams, fromState){
        if (fromState.name == 'main.search') {
          $scope.query = '';
        }
        if (toState.name == 'main.search') {
          $scope.query = toParams.query;
        }
      });
});