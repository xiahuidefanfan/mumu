define(['app', 'permissionService', 'urlConstants','operateUtil', 'tableUtil'], function (app) {
    app.controller('expenseController',['$scope',
    								 'permissionService',
    								 'urlConstants', 
    								 'operateUtil', 
    								 'tableUtil',
    								 'layer', 
    					   function ($scope, 
    							     permissionService,
    								 urlConstants, 
    								 operateUtil,
    								 tableUtil,
    								 layer){
    	/**
    	 * 报销添加
    	 */
    	$scope.openAdd = function(){
			operateUtil.openLayer({
				scope: $scope,
				layerprops:{
					title: '报销添加',
					area: ['600px','auto'],
                    contentUrl: urlConstants.EXPENSE_ADD_PAGE_URL
                }
			});
    	}
    	
    	/**
    	 * 提交添加
    	 */
    	$scope.addSubmit = function(){
    		operateUtil.doSubmit({
    			scope: $scope, 
    			url: urlConstants.EXPENSE_ADD_URL
    		});
		}
    	
    	/**
    	 * 删除报销单
    	 */
    	$scope.deleteExpense = function(){
    		operateUtil.confirmSubmit({
 				scope:$scope,
 				url: urlConstants.EXPENSE_DELETE_URL,
 				multiple: true,
 				msg: '确定要删除选中的报销单吗？'
 				
 			})
    	}
    	
    	/**
    	 * 报销详情
    	 */
    	$scope.openDetail = function(id){
    		tableUtil.setSubmitData($scope, id);
    		$scope.submitData.expenseViewUrl = urlConstants.EXPENSE_EXPENSE_VIEW_URL  + "/" + id;
    		operateUtil.openLayer(
				{
    				scope: $scope,
    				layerprops:{
    					title: '报销详情',
    					area: $scope.submitData.isEnd ? ['1000px','400px'] : ['1000px','800px'],
                        contentUrl: urlConstants.EXPENSE_DETAIL_PAGE_URL
                    }
    			}
			);
    	}
    	
    	/**
    	 * 报销修改
    	 */
    	$scope.openUpdate = function(id){
    		tableUtil.setSubmitData($scope, id);
    		operateUtil.openLayer(
				{
    				scope: $scope,
    				layerprops:{
    					title: '报销修改',
    					area: ['600px','auto'],
                        contentUrl: urlConstants.EXPENSE_UPDATE_PAGE_URL
                    }
    			}
			);
    	}
    	
    	/**
    	 * 报销修改
    	 */
    	$scope.updateSubmit = function(){
    		operateUtil.doSubmit({
    			scope: $scope, 
    			url: urlConstants.EXPENSE_UPDATE_URL
    		});
    	}
    	
    	/**
    	 * 启动流程
    	 */
    	$scope.execute = function(id){
    		tableUtil.setSubmitData($scope, id);
    		operateUtil.confirmSubmit({
     			scope: $scope,
 				url: urlConstants.EXPENSE_EXECUTE_URL,
 				noNeedCheckd: true,
 				params: $scope.submitData.processId,
 				msg: '确定要启动该报销流程吗？'
     		});
    	}
    	
    	/**
    	 * 主页面-清除筛选条件
    	 */
    	$scope.clear = function(){
    		$scope.searchItem = angular.copy($scope.defaultSearchItem);
    		$scope.reloadTable();
    	}
    	
    	/**
    	 * 关闭窗口
    	 */
    	$scope.closeLayer = function(){
    		layer.close($scope.layerIndex);
    		$scope.clearSelected();
    	}
    	
    	/**
    	 * 清除选中的记录
    	 */
    	$scope.clearSelected = function(){
    		$scope.submitData = {};
    	}

    	// 页面初始化
    	init();
    	
    	/**
    	 * 页面初始化
    	 */
    	function init(){
    	    setDefaultVars();// 设置变量及常量
		    showMain();// 展示主页面数据
    	}
    	
	   /**
	    * 设置变量及常量
	    */
	   function setDefaultVars(){
		   $scope.defaultSearchItem = {
			   name: ''   
		   };// 搜索初始值
		   $scope.searchItem = angular.copy($scope.defaultSearchItem);
		   $scope.submitData = {}; // 待操作的数据
		   
		   $scope.tableOptions = {
   		        url: urlConstants.EXPENSE_LIST_URL, //请求地址
   		        method: 'POST', //方式
   		        async: false,
   		        id: 'listReload', //生成 Layui table 的标识 id，必须提供，用于后文刷新操作，笔者该处出过问题
   		        cols: [[
   	    		      {checkbox: true, fixed: true},
   	    		      {type:'numbers', title: '报销编号', width: '10%', align: 'center', valign: 'middle',},
   	    		      {field:'money', title: '报销金额（元）', align: 'center', valign: 'middle', sort: true},
   	    		      {field:'expenseDesc', title: '报销描述',  align: 'center', valign: 'middle', sort: true},
   	    		      {field:'applicant', title: '流程发起人',  align: 'center', valign: 'middle', sort: true},
   	    		      {field:'stateName', title: '报销状态',   align: 'center', valign: 'middle', sort: true},
   	    		      {field:'createtimeFormat', title: '创建时间', align: 'center', valign: 'middle', sort: true},
   	    		      {off:'true',title: '操作', field:'operation', visible: true, width: '28%', templet: function(data){
   	    		    	var button =  '<button type="button" class="btn btn-info button-margin operationBtn" ng-click="openDetail('+ data.id + ')">' +
    		    				      		'<i class="fa fa-file-text"></i>&nbsp;查看</button>';
   	    		    	if(data.canSubmit){
   	    		    		var buttons = '<button type="button" class="btn btn-info button-margin operationBtn" ng-click="openUpdate('+ data.id + ')">' +
	                       				  	'<i class="fa fa-edit"></i>&nbsp;修改</button>' +
	                       				  '<button type="button" class="btn btn-success button-margin operationBtn" ng-click="execute('+ data.id + ')">' + 
	                       				  	'<i class="fa fa-play-circle"></i>&nbsp;启动</button>';
   	    		    		button = button + buttons;
   	    		    	}
    		    	    return button;
   	    		      }} 
   	    		    ]],
   	    		even: false, // 样式
   			    height: 570,
   		        page: false, //是否分页
   		        where: $scope.searchItem, //请求后端接口的条件
   		        response: {
   		            statusName: 'statusCode', //状态字段名称
   		            statusCode: '200', //状态字段成功值
   		            msgName: 'errorMessage', //消息字段
   		            dataName: 'data' //数据字段
   		        }
   		   };
		   
		   
		   /**
		    * 刷新表格
		    */
		   $scope.reloadTable = function(){
			   tableUtil.reloadTable($scope);
			   operateUtil.compileButton($scope);
		   }
   	   }
		   
	   /**
	    * 展示主页面数据
	    */
	   function showMain(){
		   layui.use('table', function(){
    		   $scope.table = layui.table;
    		   // 初始化表格
			   $scope.table.init('enpense_table', $scope.tableOptions);
    	   });
		   operateUtil.compileButton($scope);
	   }
	   
	   
    }]);
}); 



