app.controller('ProductsCtrl', ['$scope', '$http', 'Search', '$routeParams', '$product', 'Product', function ($scope, $http, Search, $routeParams, $product, Product) {
  var products = this;

  Product.getCategories()

  $scope.$watch(function () {
    return Search.filter
  }, function (params) {
    Search.start({filter: params})
  }, true)

  if ($routeParams.id) {
    products.product = $product.get({id: $routeParams.id});
  } else {
    Product.getCart();
  }
  
}]);