define(['app'], function (app) {
    app.controller('helloController', function ($scope) {
    	console.log('login helloController');
    	$scope.message = "Message from HomeCtrl";
    });
}); 
