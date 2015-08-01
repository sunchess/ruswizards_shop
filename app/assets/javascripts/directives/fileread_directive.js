app.directive('fileread', ['$parse', function ($parse) {
  return {
    scope: {
      fileread: "=",
      src: "=src"
    },
    restrict: 'A',
    link: function($scope, element, attrs) {  
      element.bind('change', function(){
        $scope.fileread = element[0].files[0];

        var reader = new FileReader();
        reader.onload = function (e) {
          $scope.src = e.target.result;
          $scope.$apply();
        }

        reader.readAsDataURL($scope.fileread);
        
        $scope.$apply()
      });
    }
  };
}]);