define(['app'], function(app) {
	app.service('tableUtil', function () {
		var me = this;
		/**
		 * 获取table配置
		 */
		me.tableOptions = function(scope){
			if(!scope){
				return;
			}
			var currTableOptions = angular.merge({
   		        method: 'POST', //方式
   		        id: 'listReload', //生成 Layui table 的标识 id，必须提供，用于后文刷新操作，笔者该处出过问题
   	    		even: false, // 样式
   			    height: 570,
   		        where: scope.searchItem, //请求后端接口的条件
   		        response: {
   		            statusName: 'statusCode', //状态字段名称
   		            statusCode: '200', //状态字段成功值
   		            msgName: 'errorMessage', //消息字段
   		            countName: 'dataCount', //总数字段
   		            dataName: 'data' //数据字段
   		        },
	   		    done: function(res, curr, count, table){
	   		    	scope.currpage = curr;
	   		    	scope.dataTable = table;
	   		    	delete table.config.where.page;
	   		    	if(curr > 1 && res.data.length == 0){
	   		    		table.config.where.page = curr - 1;
	   		    		scope.reloadTable();
	   		    	}
	   		    }
			},scope.tableOptions);
			
			return currTableOptions;
		}	
		
		/**
		 * 重载表格
		 */
		me.reloadTable = function (scope) {
     		scope.table.reload("listReload", { //此处是上文提到的 初始化标识id
     			where: scope.searchItem
     		});
     	}
    
		/**
		 * 转到第一页
		 */
     	me.toFirstPage = function(scope){
     		if($("[data-page=1]").length > 0){
     			scope.dataTable.config.where = scope.searchItem;
     			$("[data-page=1]")[0].click();
     		}else{
     			scope.table.reload("listReload", { //此处是上文提到的 初始化标识id
     				where: scope.searchItem
     			});
     		}
     	}
		
	});
});