define(['app'], function(app) {
	app.service('treeTableUtil', function () {
		var me = this;
		/**
		 * table默认配置
		 */
		me.defaultTableOptions = {
		     id: 'id',
             rootCodeValue: null,//设置根节点code值----可指定根节点，默认为null,"",0,"0"
             type: 'post', //请求数据的ajax类型
             dataName: 'data',
             expandColumn: 2,//在哪一列上面显示展开按钮,从0开始
             striped: false,   //是否各行渐变色
             expandAll: true  //是否全部展开
		}
		
		me.treeTable = function(scope){
		     var instance =
		    	 $('#'+ scope.tableOptions.tableId).bootstrapTreeTable(angular.merge(me.defaultTableOptions,scope.tableOptions));
            return instance;
		}
		
	});
});
