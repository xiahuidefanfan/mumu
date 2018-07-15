define([ 'app','ajaxService','urlConstants'], function(app) {
	app.service('flowableNodeService', ['ajaxService', 'urlConstants', function(ajaxService, urlConstants) {
		var me = this;

		/**
		 * 获取权限树
		 * scope:作用域 
		 */
		me.getTargetIds = function(scope){
			 me.scope = scope;
			 ajaxService.ajaxPost(urlConstants.FLOWABLE_TARGET_IDS_URL, me.scope.submitData.id).then(function(result){
	    		 me.scope.nodes = result.data;
			});
		}
		
	}]);
});
