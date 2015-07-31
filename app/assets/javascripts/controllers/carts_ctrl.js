app.controller('CartsCtrl', ['$scope', '$http', 'Product', '$location', function ($scope, $http, Product, $location) {
  var carts = this;

  carts.order = {};

  carts.createOrder = function () {
    var order = {
      address: carts.order.address,
      phone: carts.order.phone,
      fullname: carts.order.fullname
    }

    $http.post(Routes.orders_path(), {order: order})
      .success(function () {
        carts.showAddressForm = false
        Product.getCart();
      })
  }

  $scope.$watch(function () {
    return $location.search().tab
  }, function (tab) {
    carts.tab = tab;
    if (tab == 'cart') {
      Product.getCart();
    } else if (tab == 'orders') {
      Product.getOrders();
    }
  })
}])