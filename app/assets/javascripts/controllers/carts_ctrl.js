app.controller('CartsCtrl', ['$scope', '$http', function ($scope, $http) {
  var carts = this;

  $http.get(Routes.carts_path({format: 'json'}))
    .success(function (res) {
      carts.products = res;
    })

  $scope.$watch(function () {
    return carts.products
  }, function (products) {
    carts.totalPrice = _.reduce(products, function (memo, product) {
      return memo + product.price * product.count
    }, 0)
  }, true)
}])