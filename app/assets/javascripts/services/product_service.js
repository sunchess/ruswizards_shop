app.service('Product', ['$product', '$http', '$rootScope', function ($product, $http, $rootScope) {
  var Product = this;

  $rootScope.$watch(function () {
    return Product.inCart
  }, function (val) {
    if (val && val.length) {
      Product.countInCart = 0;
      Product.totalCartPrice = 0;
      _.each(val, function (product) {
        count = parseInt(product.count);
        Product.countInCart += count;
        Product.totalCartPrice += product.price * count;
      })
    }
  }, true);

  Product.addToCart = function (product, count) {
    $http.post(Routes.carts_path(), {id: product.id, count: count})
      .success(function (res) {
        Product.inCart = res;
      })
  }

  Product.deleteFromCart = function ($index, id) {
    if (confirm("Вы уверены?")) {
      $http.delete(Routes.cart_path(id))
        .success(function (res) {
          Product.inCart = res.user_products;
        })
    }
  }

  Product.getCart = function () {
    $http.get(Routes.carts_path({format: 'json'}))
      .success(function (res) {
          Product.inCart = res;
      })
  }

  Product.getOrders = function () {
    $http.get(Routes.orders_path({format: 'json'}))
      .success(function (res) {
          Product.inCart = res;
      })
  }

  Product.updateCount = function (id, count) {
    $http.put(Routes.cart_path(id), function (res) {
      // body...
    })
  }

  Product.getCategories = function (withProducts) {
    $http.get(Routes.categories_path({format: "json"}), {params: {with_products: withProducts}})
      .success(function (res) {
        Product.categories = res;
      })
  }

}]);

app.factory('$product', ['$resource', function ($resource) {
  var productPath = Routes.product_path(":id",  {format: 'json'});

  return $resource(productPath, {id: '@id'});
}])