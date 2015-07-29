app.run(['$rootScope', function ($rootScope) {

  $rootScope.findById = function (obj, id) {
    return _.find(obj, function (val) {
      return val.id == id
    })
  }

  $rootScope.guid = function () {
    function s4() {
      return Math.floor((1 + Math.random()) * 0x10000)
        .toString(16)
        .substring(1);
    }
    return s4() + s4() + '-' + s4() + '-' + s4() + '-' +
      s4() + '-' + s4() + s4() + s4();
  }
}])

