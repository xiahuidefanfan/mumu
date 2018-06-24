define([ 'app', "service/LoginService", "css!../../../style/index",
		'ueditorConfig', 'ueditorAll', 'wdatePicker', "directive/demo" ],
		function(app) {
			app.controller('IndexController', function($scope, $location,
					loginService) {
				var editor = new baidu.editor.ui.Editor();
				editor.render("newsEditor");
				 alert("执行的代码")
				$scope.name="hello world";
	
			});
		});
