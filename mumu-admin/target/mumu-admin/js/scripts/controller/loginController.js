var app = angular.module('login', []);
app.controller('loginController',function($scope, $location, loginService) {
	$scope.doLogin = function() {
		// 获取用户名
		var account = $scope.account;
		var password = $scope.password;
		var data = {
			"account" : account,
			"password" : password
		}
		$http({
			method : "post",
			url : url,
			data : data
		}).success(function(data) {
			alert(data);
		})
	}
});

