define([ 'app' ], function(app) {
	app.service('ajaxService', function($http) {
		var me = this;
		me.ajaxPost = function(url, data, success) {
			$http({
				method : "post",
				url : url,
				data : data
			}).success(function(data) {
				success(data);
			})
		}
	});
});
