app.config(['$routeProvider', function ($routeProvider) {  
  $routeProvider
    .when('/', {
      templateUrl: Routes.products_path(),
      controller: 'ProductsCtrl as products',
      reloadOnSearch: false
    })
    .otherwise({
      redirectTo: '/'
    })
}]);