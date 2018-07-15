define(['app', 'permissionService', 'flowableNodeService', 'urlConstants','operateUtil', 'tableUtil'], function (app) {
    app.controller('expenseProgressController',['$scope',
    								 'permissionService',
    								 'flowableNodeService',
    								 'urlConstants', 
    								 'operateUtil', 
    								 'tableUtil',
    								 'layer', 
    					   function ($scope, 
    							     permissionService,
    							     flowableNodeService,
    								 urlConstants, 
    								 operateUtil,
    								 tableUtil,
    								 layer){
    	
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
    	 * 审核流程
    	 */
    	$scope.aduit = function(id){
    		tableUtil.setSubmitData($scope, id);
    		$scope.submitData.expenseViewUrl = urlConstants.EXPENSE_EXPENSE_VIEW_URL  + "/" + id;
    		operateUtil.openLayer({
				scope: $scope,
				layerprops:{
					title: '报销审核',
					area: ['1000px','780px'],
                    contentUrl: urlConstants.EXPENSE_ADUIT_PAGE_URL
                }
			});
    	}
    	
    	/**
    	 * 审核通过
    	 */
    	$scope.pass = function(){
    		operateUtil.doSubmit({
    			scope: $scope, 
    			url: urlConstants.EXPENSE_PASS_URL
    		});
    	}
    	
    	/**
    	 * 审核不通过
    	 */
    	$scope.unPass = function(){
    		operateUtil.doSubmit({
    			scope: $scope, 
    			url: urlConstants.EXPENSE_UNPASS_URL
    		});
    	}
    	
    	/**
    	 * 回退任务
    	 */
    	$scope.rollback = function(id){
    		tableUtil.setSubmitData($scope, id);
    		$scope.submitData.expenseViewUrl = urlConstants.EXPENSE_EXPENSE_VIEW_URL  + "/" + id;
    		operateUtil.openLayer({
				scope: $scope,
				layerprops:{
					title: '报销回退',
					area: ['1000px','720px'],
                    contentUrl: urlConstants.EXPENSE_ROLL_BACK_PAGE_URL
                }
			},getTargetIds);
    	}
    	
    	/**
    	 * 获取当前流程可回退到的节点
    	 */
    	function getTargetIds(){
    		flowableNodeService.getTargetIds($scope);
    	}
    	
    	/**
    	 * 回退提交
    	 */
    	$scope.rollbackSubmit = function(){
    		operateUtil.doSubmit({
    			scope: $scope, 
    			url: urlConstants.EXPENSE_ROLL_BACK_URL,
    			params:{
    				taskId:$scope.submitData.id,
    				targetKey: $scope.submitData.targetNode ? $scope.submitData.targetNode.nodeCode : ""
    			}
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
		   $scope.submitData = {}; // 操作的数据
		   
		   $scope.tableOptions = {
   		        url: urlConstants.EXPENSE_TASk_LIST_URL, //请求地址
   		        method: 'POST', //方式
   		        async: false,
   		        id: 'listReload', //生成 Layui table 的标识 id，必须提供，用于后文刷新操作
   		        cols: [[
   	    		      {type:'numbers', title: '任务编号', width: '10%', align: 'center', valign: 'middle',},
   	    		      {field:'name', title: '任务名称', align: 'center', valign: 'middle', sort: true},
   	    		      {field:'money', title: '申请金额',  align: 'center', valign: 'middle', sort: true},
   	    		      {field:'expenseDesc', title: '任务描述',  align: 'center', valign: 'middle', sort: true},
   	    		      {field:'createTimeFormat', title: '申请时间',  align: 'center', valign: 'middle', sort: true},
   	    		      {field:'assigneeName', title: '申请人',   align: 'center', valign: 'middle', sort: true},
   	    		      {off:'true',title: '操作', visible: true, width: '25%', align: 'center', valign: 'middle', templet: function(data){
   	    		    	  var button = '';
   	    		    	  if((data.selfFlag && data.isSubmit)){
   	    		    		  buttons = '<button type="button" class="btn btn-success button-margin operationBtn" ng-click="execute('+ data.id + ')">' + 
   	    		    		  				'<i class="fa fa-check"></i>&nbsp;启动</button>';
	    	  			  }else{
	    	  				  buttons = '<button type="button" class="btn btn-success button-margin operationBtn" ng-click="aduit('+ data.id + ')">' + 
	    	  				  	       		'<i class="fa fa-check"></i>&nbsp;审核</button>' + 
    	  				  	       	   '<button type="button" class="btn btn-danger button-margin operationBtn" ng-click="rollback('+ data.id + ')">' + 
    	  				  	       	   		'<i class="fa fa-backward"></i>&nbsp;回退</button>';
	    	  			  }
   	    		    	  return button + buttons;
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
			   $scope.table.init('enpense_progress', $scope.tableOptions);
    	   });
		   operateUtil.compileButton($scope);
	   }
	   
    }]);
}); 



