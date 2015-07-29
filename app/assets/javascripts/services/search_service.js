app.service('Search', ['Product', '$product', function (Product, $product) {
  var Search = this;

  Search.start = function (params) {
    Product.list = $product.query(params);
  }
}])