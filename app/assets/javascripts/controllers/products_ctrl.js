app.controller('ProductsCtrl', ['$scope', '$routeParams', 'Product', 'Search', 'Category', function ($scope, $routeParams, Product, Search, Category) {
  var products = this;
  products.product = {photo: {}};
  products.categories = Category.all();

  $scope.$watch(function () { return Search.filter }, function (params) {
    Search.start({filter: params})
  }, true)

  if ($routeParams.product_id) {
    products.product = Product.get({id: $routeParams.product_id});
  } else {
    Product.getCart();
  }

  products.save = function () {
    var fd = new FormData(),
        headers = {
          transformRequest: angular.identity,
          headers: {'Content-Type': undefined}
        };

    fd.append('formdata', true);
    if (products.product.file)
      fd.append('photo', products.product.file);
    if (products.product.title)
      fd.append('title', products.product.title);
    if (products.product.description)
      fd.append('description', products.product.description);
    if (products.product.price)
      fd.append('price', products.product.price);

    if ($routeParams.category_id) {
      fd.append('category_id', $routeParams.category_id);
      Product.create(fd);
    } else if (!$routeParams.category_id && $routeParams.product_id) {
      Product.update($routeParams.product_id, fd);
    }
  }
  
}]);