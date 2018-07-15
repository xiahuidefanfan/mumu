define(['app', 'deptTreeService', 'permissionService', 'urlConstants','operateUtil', 'tableUtil'], function (app) {
    app.controller('logController',['$scope', 
    								 'deptTreeService', 
    								 'permissionService',
    								 'urlConstants', 
    								 'operateUtil', 
    								 'tableUtil',
    								 'layer', 
    					   function ($scope, 
    							     deptTreeService, 
    							     permissionService,
    								 urlConstants, 
    								 operateUtil, 
    								 tableUtil,
    								 layer) {
    	
    	
     	/**
    	 * 查看日志详情
    	 */
    	$scope.openDetail = function(){
    		operateUtil.infoDetail('日志详情', $scope, 'regularMessage');
	    }
    	
	     /**
     	 * 删除日志
     	 */
     	 $scope.deleteLog = function(){
     		 operateUtil.confirmSubmit({
 				scope: $scope,
 				url: urlConstants.LOG_DELETE_URL,
 				multiple: true,
 				msg: '确定要删除选中的日志吗？'
 			});
     	 }
    	
     	 /**
      	 * 删除日志
      	 */
      	 $scope.deleteAllLog = function(){
      		 operateUtil.confirmSubmit({
  				scope: $scope,
  				url: urlConstants.LOG_DELETEALL_URL,
  				msg: '确定要清除日志吗？',
  				noNeedCheckd: true
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
		    permission();
    	}
    	
	   /**
	    * 设置变量及常量
	    */
	   function setDefaultVars(){
		   $scope.rootDeptPid = 0;
		   $scope.depts = [];// 列表展示数据,
		   $scope.defaultSearchItem = {
			   beginTime: '',
		       endTime: '',
		       logName: '',
			   logType: '0'
		   };// 搜索初始值
		   $scope.searchItem = angular.copy($scope.defaultSearchItem);
		   $scope.submitData = {}; // 选中的部门
		   $scope.buttonPermission = {
				   detail:false,
				   delete:false,
				   deleteAll: false
		   }
		   $scope.buttons = ['/log/detail','/log/delete','/log/deleteAll'];
		   
		   $scope.tableOptions = {
   		        url: urlConstants.LOG_LIST_URL, //请求地址
   		        cols: [[
   	    		      {checkbox: true, fixed: true},
   	    		      {field:'id', title: 'id', align: 'center', valign: 'middle', sort: true},
   	    		      {field:'logtype', title: '日志类型', align: 'center', valign: 'middle', sort: true},
   	    		      {field:'logname', title: '日志名称', align: 'center', valign: 'middle', sort: true},
   	    		      {field:'userName', title: '用户名称', align: 'center', valign: 'middle', sort: true},
   	    		      {field:'classname', title: '类名', align: 'center', valign: 'middle', sort: true},
   	    		      {field:'method', title: '方法名', align: 'center', valign: 'middle', sort: true},
   	    		      {field:'createtime', title: '时间', align: 'center', valign: 'middle', sort: true},
	    		      {field:'message', title: '具体消息', align: 'center', valign: 'middle', sort: true},
   	    		    ]],
   		        page: true, //是否分页
	       };
		   
		   /**
		    * 刷新表格
		    */
		   $scope.reloadTable = function(){
			   tableUtil.reloadTable($scope);
		   }
		   
		   /**
		    * 跳转到第一页
		    */
           $scope.toFirstPage = function(){
        	   tableUtil.toFirstPage($scope);
    	   }
   	   }
		   
	   /**
	    * 展示主页面数据
	    */
	   function showMain(){
		   layui.use('table', function(){
    		   $scope.table = layui.table;
    		   // 初始化表格
			   $scope.table.init('log_table', tableUtil.tableOptions($scope));
    	   });
		   layui.use('laydate', function(){
			   var laydate = layui.laydate;
			   //注册开始日期
			   laydate.render({
			     elem: '#beginTime',
			     done:function(value){
     			    	$scope.searchItem.beginTime = value;
     			    }
			   });
			   // 注册结束日期
			   laydate.render({
			     elem: '#endTime',
			     done:function(value){
     			    	$scope.searchItem.endTime = value;
     			    }
			   });
			   
		   });
	   }
	   
	   /**
	    * 按钮权限
	    */
	   function permission(){
		   permissionService.hasPermission($scope);
	   }
	   
    }]);
}); 



