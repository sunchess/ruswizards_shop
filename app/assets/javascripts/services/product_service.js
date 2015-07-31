app.service('Product', ['$product', '$http', '$rootScope', function ($product, $http, $rootScope) {
  var Product = this;

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
    
    if (index!=-1) {
      Product.inCart[index].count += count;
    } else {
      Product.inCart.push(product);
    }
    $http.post(Routes.carts_path(), {id: product.id, count: count})

    if (!gon.user.info){
      localStorage.setItem("cart", JSON.stringify(Product.inCart));
    }
  }

  Product.deleteFromCart = function ($index, id) {
    if (confirm("Вы уверены?")) {
      Product.inCart.splice($index, 1);
      if (gon.user.info)
        $http.delete(Routes.cart_path(id));
      else
        localStorage.setItem("cart", Product.inCart)
    }
  }

  Product.resetCart = function () {
    $http.post(Routes.reset_carts_path(), {products: Product.inCart})
      .success(function () {
        localStorage.setItem("cart", "[]");
      })
  }

  Product.updateCart = function (tab) {
    $http.get(Routes.carts_path({format: 'json'}), {params: {tab: tab}})
      .success(function (res) {
        Product.inCart = res.length ? res : JSON.parse(localStorage.getItem("cart") || "[]");
        if (!res.length && Product.inCart.length && gon.user) {
          Product.resetCart();
        }
      })
  }

}]);

app.factory('$product', ['$resource', function ($resource) {
  var productPath = Routes.product_path(":id",  {format: 'json'});

  return $resource(productPath, {id: '@id'});
}])