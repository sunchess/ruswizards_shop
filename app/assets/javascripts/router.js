app.config(['$routeProvider', function ($routeProvider) {  
  $routeProvider
    .when('/', {
      templateUrl: Routes.products_path(),
      controller: 'ProductsCtrl as products',
      reloadOnSearch: false
    })
    .when('/carts', {
      templateUrl: Routes.carts_path(),
      controller: 'CartsCtrl as carts',
      reloadOnSearch: false
    })
    .otherwise({
      redirectTo: '/'
    })
}]);