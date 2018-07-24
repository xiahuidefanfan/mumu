define(['app', 'urlConstants','operateUtil', 'tableUtil'], function (app) {
    app.controller('bookController',['$scope', 
    								 'urlConstants', 
    								 'operateUtil', 
    								 'tableUtil',
    								 'layer', 
    					   function ($scope, 
    								 urlConstants, 
    								 operateUtil, 
    								 tableUtil,
    								 layer) {
    	
    	
     	/**
    	 * 查看书籍详情
    	 */
    	$scope.openDetail = function(){
    		operateUtil.infoDetail('书籍详情', $scope, 'regularMessage');
	    }
    	
	     /**
     	 * 删除书籍
     	 */
     	 $scope.deleteLog = function(){
     		 operateUtil.confirmSubmit({
 				scope: $scope,
 				url: urlConstants.LOG_DELETE_URL,
 				multiple: true,
 				msg: '确定要删除选中的书籍吗？'
 			});
     	 }
    	
     	 /**
      	 * 删除书籍
      	 */
      	 $scope.deleteAllLog = function(){
      		 operateUtil.confirmSubmit({
  				scope: $scope,
  				url: urlConstants.LOG_DELETEALL_URL,
  				msg: '确定要清除书籍吗？',
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
    	}
    	
	   /**
	    * 设置变量及常量
	    */
	   function setDefaultVars(){
		   $scope.defaultSearchItem = {
		   };// 搜索初始值
		   $scope.searchItem = angular.copy($scope.defaultSearchItem);
		   
		   $scope.tableOptions = {
   		        url: urlConstants.BOOK_LIST_URL, //请求地址
   		        cols: [[
   	    		      {checkbox: true, fixed: true},
   	    		      {field:'id', title: 'id', align: 'center', valign: 'middle', sort: true},
   	    		      {field:'bookName', title: '书籍名称', align: 'center', valign: 'middle', sort: true},
   	    		      {field:'owner', title: '所有者', align: 'center', valign: 'middle', sort: true},
   	    		      {field:'type', title: '书籍类型', align: 'center', valign: 'middle', sort: true},
   	    		      {field:'isUpper', title: '是否上架', align: 'center', valign: 'middle', sort: true},
   	    		      {field:'deleteFlag', title: '是否删除', align: 'center', valign: 'middle', sort: true},
	    		      {field:'createTime', title: '创建时间', align: 'center', valign: 'middle', sort: true},
	    		      {field:'updateTime', title: '修改时间', align: 'center', valign: 'middle', sort: true},
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
			   $scope.table.init('book_table', tableUtil.tableOptions($scope));
    	   });
	   }
	   
    }]);
}); 



