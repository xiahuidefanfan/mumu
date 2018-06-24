define([ 'app', 'ajaxService', 'urlConstants' ], function(app) {
	app.service('permissionService', ['ajaxService', 'urlConstants', function(ajaxService, urlConstants) {
		var me = this;
		me.hasPermission = function(scope){
			 ajaxService.ajaxPost(urlConstants.HAS_PERMISSION_URL, scope.buttons).then(function(result){
				 scope.buttonPermission = result.data;
			 });
		}
	}]);
});
