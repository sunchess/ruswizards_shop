app.service('Sign', ['$http', function ($http) {
  var Sign = this;

  Sign.in = function () {
    var params = {
      email: Sign.email,
      password: Sign.password
    }
    $http.post(Routes.user_session_path(), {user: params})
      .success(function (res) {
        window.location.reload()
      })
  }

  Sign.up = function () {
    var params = {
      email: Sign.email,
      password: Sign.password,
      password_confirmation: Sign.password_confirmation,
      fullname: Sign.fullname
    }
    $http.post(Routes.user_registration_path(), {user: params})
      .success(function (res) {
        window.location.reload()
      })
  }

  Sign.out = function () {
    $http.delete(Routes.destroy_user_session_path())
      .success(function () {
        window.location.reload()
      })
  }
}])