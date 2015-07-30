app.controller('ProductsCtrl', ['$scope', '$http', 'Search', function ($scope, $http, Search) {
  var products = this;

  $scope.$watch(function () {
    return Search.filter
  }, function (params) {
    Search.start({filter: params})
  }, true)

  products.getCategories = function () {
    $http.get(Routes.categories_path())
      .success(function (res) {
        products.categories = res;
      })
  }
  
}]);