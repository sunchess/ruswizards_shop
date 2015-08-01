app.service('Product', ['$product', '$http', '$rootScope', '$location', function ($product, $http, $rootScope, $location) {
  var Product = this,
      headers = {
        transformRequest: angular.identity,
        headers: {'Content-Type': undefined}
      };

  $rootScope.$watch(function () {
    return Product.inCart
  }, function (val) {
    if (val && val.length) {
      Product.countInCart = 0;
      Product.totalCartPrice = 0;
      _.each(val, function (product) {
        count = parseInt(product.count);
        Product.countInCart += count;
        Product.totalCartPrice += product.price;
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

  Product.get = $product.get;

  Product.create = function (fd) {
    $product.create(fd, function (res) {
      $location.path('/products/'+res.id)
    })
  }

  Product.update = function (id, fd) {
    $product.update({id: id}, fd, function (res) {
      $location.path('/products/'+res.id)
    })
  }

  Product.destroy = function (id) {
    if (confirm('Вы уверены?')) {
      $product.remove({id: id}, function () {
        $location.path('/categories')
      })
    }
  }

}]);

app.factory('$product', ['$resource', function ($resource) {
  var productPath = Routes.product_path(":id",  {format: 'json'});

  return $resource(productPath, {id: '@id'}, {
    update: {method: "put", transformRequest: angular.identity, headers: {'Content-Type': undefined}},
    create: {method: "post", transformRequest: angular.identity, headers: {'Content-Type': undefined}}
  });
}])