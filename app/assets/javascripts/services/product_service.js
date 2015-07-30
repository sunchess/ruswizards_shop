app.service('Product', ['$product', '$http', '$rootScope', function ($product, $http, $rootScope) {
  var Product = this;
  Product.inCart = JSON.parse(localStorage.getItem("cart")) || [];

  $rootScope.$watch(function () {
    return Product.inCart
  }, function (val) {
    if (val && val.length) {
      Product.countInCart = 0;
      Product.totalCartPrice = 0;
      _.each(val, function (product) {
        Product.countInCart += product.count;
        Product.totalCartPrice += product.price * product.count;
      })
    }
  }, true);

  Product.addToCart = function (product, count) {
    product.count = count;
    var index = _.findIndex(Product.inCart, function (el) {
      return el.id == product.id
    });
    
    if (index!=undefined) {
      Product.inCart[index].count += count;
    } else {
      Product.inCart.push(product);
    }
    
    localStorage.setItem("cart", JSON.stringify(Product.inCart));
    $http.post(Routes.carts_path(), {id: product.id, count: count})
  }

  Product.deleteFromCart = function ($index, id) {
    if (confirm("Вы уверены?")) {
      $http.delete(Routes.cart_path(id))
        .success(function () {
          Product.inCart.splice($index, 1);
        })
    }
  }

  Product.updateCart = function () {
    $http.get(Routes.carts_path({format: 'json'}))
      .success(function (res) {
        Product.inCart = res;
      })
  }

}]);

app.factory('$product', ['$resource', function ($resource) {
  var productPath = Routes.product_path(":id",  {format: 'json'});

  return $resource(productPath, {id: '@id'});
}])