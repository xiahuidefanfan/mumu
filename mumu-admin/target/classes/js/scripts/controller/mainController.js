define(['app', 'ajaxService', 'urlConstants'], function (app) {
    app.controller('mainController',['$scope', 'ajaxService', 'urlConstants', function (
    		$scope, ajaxService, urlConstants) {
    	$scope.avatar = "";
    	$scope.titles = {};
    	
    	/**
    	 * 初始化主页面
    	 */
    	ajaxService.ajaxPost(urlConstants.INIT_MAIN_URL, {}).then(function(result){
    		$scope.avatar = result.data.avatar;
        	$scope.titles = result.data.titles;
        	$scope.shiroUser = result.data.shiroUser;
		});
    	
    	/**
    	 * 点击菜单栏
    	 */
    	$scope.changeTitle = function(title){
    		$scope.currentTitle = ($scope.currentTitle && $scope.currentTitle == title) ? "" : title;
    	}
    	
    	/**
    	 * 退出系统
    	 */
    	$scope.logout = function(){
    		ajaxService.ajaxPost(urlConstants.LOGOUT_URL, {}).then(function(){
    			window.location = urlConstants.LOGIN_PAGE_URL;
    		});
    	}
    	
    }]);
}); 
