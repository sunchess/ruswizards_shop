app.config(['$routeProvider', function ($routeProvider) {  
  $routeProvider
    .when('/', {
      templateUrl: Routes.products_path(),
      controller: 'ProductsCtrl as products',
      reloadOnSearch: false
    })
    .when('/products/:id', {
      templateUrl: Routes.product_path(0),
      controller: 'ProductsCtrl as products',
      reloadOnSearch: false
    })
    .when('/carts', {
      templateUrl: Routes.carts_path(),
      controller: 'CartsCtrl as carts',
      reloadOnSearch: false
    })
    .when('/delivery', {
      templateUrl: Routes.delivery_path(),
    })
    .when('/contacts', {
      templateUrl: Routes.contacts_path(),
    })

  if (gon.user.is_admin)
    $routeProvider
      .when('/manage-catalog', {
        templateUrl: Routes.manage_catalog_products_path(),
        controller: 'ProductsCtrl as products',
        reloadOnSearch: false
      })

  $routeProvider
    .otherwise({
      redirectTo: '/'
    })
}]);