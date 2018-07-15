define(['app', 'urlConstants','operateUtil', 'tableUtil'], function (app) {
    app.controller('flowableNodeController',['$scope',
    								 'urlConstants', 
    								 'operateUtil', 
    								 'tableUtil',
    								 'layer', 
    					   function ($scope, 
    								 urlConstants, 
    								 operateUtil,
    								 tableUtil,
    								 layer){
    	
    	/**
    	 * 主页面-清除筛选条件
    	 */
    	$scope.clear = function(){
    		$scope.searchItem = angular.copy($scope.defaultSearchItem);
    		$scope.reloadTable();
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
   		        url: urlConstants.FLOWABLE_NODE_LIST, //请求地址
   		        method: 'POST', //方式
   		        async: false,
   		        id: 'listReload', //生成 Layui table 的标识 id，必须提供，用于后文刷新操作
   		        cols: [[
   		        	  {checkbox: true, fixed: true},
   	    		      {field:'procDefId', title: '流程定义id', align: 'center', valign: 'middle', sort: true},
   	    		      {field:'nodeCode', title: '节点编码',  align: 'center', valign: 'middle', sort: true},
	    		      {field:'nodeName', title: '节点名称',  align: 'center', valign: 'middle', sort: true},
   	    		      {field:'positionMsg', title: '节点位置',   align: 'center', valign: 'middle', sort: true},
   	    		      {field:'canBackToMsg', title: '是否可被回退到',   align: 'center', valign: 'middle', sort: true},
   	    		      {field:'createtimeFormat', title: '创建时间',  width:'15%', align: 'center', valign: 'middle', sort: true},
   	    		      {field:'orderNum', title: '节点排序',  align: 'center', valign: 'middle', sort: true},
   	    		      {field:'nodeDesc', title: '备注', width:'20%', align: 'center', valign: 'middle', sort: true},
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
		   }
   	   }
		   
	   /**
	    * 展示主页面数据
	    */
	   function showMain(){
		   layui.use('table', function(){
    		   $scope.table = layui.table;
    		   // 初始化表格
			   $scope.table.init('node_table', $scope.tableOptions);
    	   });
	   }
	   
    }]);
}); 



