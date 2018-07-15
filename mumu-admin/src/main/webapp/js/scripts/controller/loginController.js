var loginApp = angular.module('loginApp', ['ui.router']);
loginApp.controller('loginController',['$scope', '$http', '$location',
	function($scope, $http, $location) {
	$scope.doLogin = function() {
		$scope.loginErrorMsg = "";
		
		// 获取用户名
		var account = $scope.account;
		var password = $scope.password;
		var data = {
			"account" : account,
			"password" : password
		}
		$http({
			method : "post",
			url : "/doLogin",
			data : data
		}).success(function(resp) {
			$scope.showLoginError = false;
			var returnRouter = "";
			if(window.location.href.indexOf('=') > -1){
				returnRouter = window.location.href.substring(window.location.href.indexOf('=') + 1);
			}
			window.location = "/views/index.html#" + returnRouter;
		}).error(function(resp){
			// 提示用户名或密码错误
			$scope.showLoginError = true;
			$scope.loginErrorMsg = resp.message;
		});
	}
}]);

