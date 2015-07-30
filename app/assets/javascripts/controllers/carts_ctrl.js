app.controller('CartsCtrl', ['$scope', '$http', 'Product', function ($scope, $http, Product) {
  var carts = this;

  Product.updateCart();
}])