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
      .when('/categories', {
        templateUrl: Routes.categories_path(),
        controller: 'CategoriesCtrl as categories',
        reloadOnSearch: false
      })
      .when('/category/new', {
        templateUrl: Routes.new_category_path(),
        controller: 'CategoriesCtrl as categories',
        reloadOnSearch: false
      })
      .when('/categories/:id/edit', {
        templateUrl: Routes.edit_category_path('id'),
        controller: 'CategoriesCtrl as categories',
        reloadOnSearch: false
      })

  $routeProvider
    .otherwise({
      redirectTo: '/'
    })
}]);