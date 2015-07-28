app.controller('ProductsCtrl', ['$scope', '$product', function ($scope, $product) {
  var products = this;

  products.list = $product.query();
}]);