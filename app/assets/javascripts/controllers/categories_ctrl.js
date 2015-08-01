app.controller('CategoriesCtrl', ['$scope', 'Category', '$routeParams', function ($scope, Category, $routeParams) {
  var categories = this;

  categories.list = Category.all(true);

  if ($routeParams.category_id) {
    categories.form = Category.get({id: $routeParams.category_id})
  }
}])