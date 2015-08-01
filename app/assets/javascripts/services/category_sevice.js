app.service('Category', ['$category', '$location', function ($category, $location) {
  var Category = this,
      open_categories = function () {
        $location.path('/categories')
      }

  Category.all = function  (withProducts) {
    return $category.query({with_products: withProducts})
  }

  Category.get = $category.get;

  Category.save = function (id, form) {
    if (id) {
      $category.update({id: id, category: form}, open_categories);
    } else {
      $category.save({category: form}, open_categories);
    }
  }

  Category.destroy = function (id) {
    if (confirm('Вы уверены, что хотите удалить категорию и все вложенные в нее продукты?'))
      $category.remove({id: id}, open_categories);
  }

}]);

app.factory('$category', ['$resource', function ($resource) {
  return $resource(Routes.category_path(':id', {format: 'json'}), {id: "@id"},{
    'update': { method:'PUT' }
  })
}])