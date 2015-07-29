app.controller('ProductsCtrl', ['$scope', '$product', 'Search', 'Product', function ($scope, $product, Search, Product) {
  var products = this;

  $scope.$watch(function () {
    return Search.filter
  }, function (params) {
    Search.start(params)
  }, true)

}]);