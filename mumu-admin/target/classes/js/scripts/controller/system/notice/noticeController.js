define(['app', 'ajaxService'], function (app) {
    app.controller('noticeController',['$scope', 'ajaxService', function (
    		$scope, ajaxService) {
    	// 获取通知消息
    	ajaxService.ajaxPost('/notice/msg', {}).then(function(result){
    		$scope.noticeMsgs = result.data;
		});
    }]);
}); 
