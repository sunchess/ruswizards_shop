app.service('Sign', ['$http', function ($http) {
  var Sign = this;

  Sign.in = function () {
    var params = {
      email: Sign.email,
      password: Sign.password
    }
    $http.post(Routes.user_session_path(), params)
      .success(function (res) {
        console.log("Успешно авторизованы", res)
      })
      .error(function (res) {
        console.log("Ошибка авторизации", res)
      })
  }
}])