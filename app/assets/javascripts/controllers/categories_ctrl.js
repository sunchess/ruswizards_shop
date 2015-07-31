app.controller('CategoriesCtrl', ['$scope', '$http', '$location', 'Product', function ($scope, $http, $location, Product) {
  var categories = this;

  Product.getCategories(true);

  categories.create = function () {
    $http.post(Routes.categories_path({format: 'json'}), {category: categories.form})
      .success(function () {
        $location.path('/categories')
      })
  }
}])