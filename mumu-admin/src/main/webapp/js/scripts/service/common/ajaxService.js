define([ 'app' ], function(app) {
	app.service('ajaxService', ['$http', '$q', function($http, $q) {
		var me = this;
		me.ajaxPost = function(url, params) {
		    var delay = $q.defer(); 
			$http({
				method : "post",
				url : url,
				data : params
			}).success(function(data) {
				delay.resolve(data);
			}).error(function (data) {  
	            delay.reject(data);  
	        }); 
			return delay.promise; 
		}
	}]);
});
