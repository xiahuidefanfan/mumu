define(['app'], function (app) {
    app.controller('demoController', function ($scope) {
    	console.log('demoController');
    	$scope.msg = "hello demoController";
    });
}); 
