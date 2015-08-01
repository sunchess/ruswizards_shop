app.controller('UsersCtrl', ['$http', function ($http) {
  var users = this;

  $http.get(Routes.manage_path({format: 'json'}))
    .success(function (res) {
      users.list = res;
    })

  users.ban = function (id, banned) {
    $http.put(Routes.manage_path({format: 'json'}), {id: id, banned: banned})
  }
}])