app.controller('ProductsCtrl', ['$scope', '$product', 'Search', function ($scope, $product, Search) {
  var products = this;

  products.list = $product.query();

  $scope.$watch(function () {
    return Search.filter
  }, function (val) {
    products.list = $product.query({filter: val})
  }, true)
}]);