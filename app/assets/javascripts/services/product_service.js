app.service('Product', ['$product', '$http', '$rootScope', function ($product, $http, $rootScope) {
  var Product = this;

  Product.inCart = gon.product_ids || JSON.parse(localStorage.getItem("cart")) || [];

  $rootScope.$watch(function () {
    return Product.inCart
  }, function (val) {
    if (_.isArray(val))
      Product.countInCart = _.reduce(val, function(memo, num){ return memo+ num.count; }, 0)
  }, true)

  Product.addToCart = function (id, count) {
    Product.inCart.push({id: id, count: count});
    
    localStorage.setItem("cart", JSON.stringify(Product.inCart));
    $http.post(Routes.carts_path(), {id: id, count: count})
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