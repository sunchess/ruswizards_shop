app.service('Product', ['$product', '$http', function ($product, $http) {
  var Product = this;

  Product.addToCart = function (id, count) {
    var product_ids = []
    _.each(_.range(count), function () {
      product_ids.push(id)
      Product.inCart.push(id);
    });
    localStorage.setItem("cart", JSON.stringify(Product.inCart));
    $http.post(Routes.carts_path(), {product_ids: product_ids})
  }

  Product.deleteToCart = function (id, count) {
    var product_ids = []
    _.each(_.range(count), function () {
      product_ids.splice(id, 1)
      Product.inCart.splice(id, 1)
    });
    localStorage.setItem("cart", JSON.stringify(Product.inCart));

    $http.delete(Routes.users_cart_path(), {product_ids: product_ids})
  }

}]);

app.factory('$product', ['$resource', function ($resource) {
  var productPath = Routes.product_path(":id",  {format: 'json'});

  return $resource(productPath, {id: '@id'});
}])