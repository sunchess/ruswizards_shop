app.controller('ProductsCtrl', ['$scope', '$http', 'Search', '$routeParams', '$product', 'Product', function ($scope, $http, Search, $routeParams, $product, Product) {
  var products = this;

  $scope.$watch(function () {
    return Search.filter
  }, function (params) {
    Search.start({filter: params})
  }, true)

  products.getCategories = function () {
    $http.get(Routes.categories_path())
      .success(function (res) {
        products.categories = res;
      })
  }


  if ($routeParams.id) {
    products.product = $product.get({id: $routeParams.id});
  } else {
    Product.updateCart('cart');
  }
  
}]);