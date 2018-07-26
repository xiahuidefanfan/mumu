define(['app', 'dictTreeService', 'urlConstants', 'dictConstants', 'operateUtil', 'tableUtil'], function (app) {
    app.controller('bookController',['$scope', 
    								 'dictTreeService',
    								 'urlConstants', 
    								 'dictConstants',
    								 'operateUtil', 
    								 'tableUtil',
    								 'layer', 
    					   function ($scope, 
    							     dictTreeService,
    								 urlConstants, 
    								 dictConstants,
    								 operateUtil, 
    								 tableUtil,
    								 layer) {
    	
    	
    	 /**
	     * 主页面-添加书籍打开弹框
	     */
	    $scope.openAdd = function(){
	    	operateUtil.openLayer(
    			{
    				scope: $scope,
    				layerprops:{
    					title: '书籍添加',
    					area: ['808px','auto'],
                        contentUrl: urlConstants.BOOK_ADD_PAGE_URL
                    }
    			}
			);
	    	$scope.getBookUpperStatus();
	    	$scope.getBookTypes();
	     }
	    
	    /**
 	     *  添加-提交任务
 	     */
 	     $scope.addSubmit = function(){
 	    	 operateUtil.doSubmit({
 	    		 scope:$scope, 
 	    		 url: urlConstants.BOOK_ADD_URL
 	    	 });
 	     }
 	     
     	/**
     	 * 修改书籍，弹框展示
     	 */
     	$scope.openUpdate = function(){
     		operateUtil.openLayer(
 				{
     				scope: $scope,
     				layerprops:{
     					title: '书籍修改',
     					area: ['808px','auto'],
                         contentUrl: urlConstants.BOOK_UPDATE_PAGE_URL
                     },
                     setChosed: true,
     			}
 			);
     		$scope.getBookUpperStatus();
     		$scope.getBookTypes();
 	    }

    	/**
    	 * 提交修改
    	 */
    	$scope.updateSubmit = function(){
    		operateUtil.doSubmit({
    			scope: $scope, 
    			url: urlConstants.BOOK_UPDATE_URL
    		});
		}
    	
    	 /**
     	 * 删除书籍
     	 */
     	 $scope.deleteBook = function(){
     		 operateUtil.confirmSubmit({
 				scope: $scope,
 				url: urlConstants.BOOK_DELETE_URL,
 				multiple: true,
 				msg: '确定要删除选中的书籍吗？'
 			});
     	 }
    	
    	/**
    	 * 获取书籍状态下拉字典
    	 */
    	$scope.getBookUpperStatus = function(){
    		 dictTreeService.getDicts($scope,"bookUpper", dictConstants.BOOK_UPPER);
    	}
    	
    	/**
    	 * 获取书籍类型下拉字典
    	 */
    	$scope.getBookTypes = function(){
    		 dictTreeService.getDicts($scope,"bookType", dictConstants.BOOK_TYPE);
    	}
    	
    	/**
    	 * 推荐为轮播
    	 */
    	$scope.recommendCarousel = function(){
    		operateUtil.confirmSubmit({
      			scope:$scope,
  				url: urlConstants.BOOK_RECOMMEND_CAROUSEL,
  				multiple: true,
  				msg: '确定要推荐为轮播吗？'
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
		   
		   $scope.tableOptions = {
   		        url: urlConstants.BOOK_LIST_URL, //请求地址
   		        cols: [[
   	    		      {checkbox: true, fixed: true},
   	    		      {field:'id', title: 'id', align: 'center', valign: 'middle', sort: true},
   	    		      {field:'bookName', title: '书籍名称', align: 'center', valign: 'middle', sort: true},
   	    		      {field:'owner', title: '所有者', align: 'center', valign: 'middle', sort: true},
   	    		      {field:'price', title: '价格（元）', align: 'center', valign: 'middle', sort: true},
   	    		      {field:'typeName', title: '书籍类型', align: 'center', valign: 'middle', sort: true},
   	    		      {field:'isUpperName', title: '是否上架', align: 'center', valign: 'middle', sort: true},
   	    		      {field:'deleteFlagName', title: '是否删除', align: 'center', valign: 'middle', sort: true},
	    		      {field:'createTimeFormat', title: '创建时间', align: 'center', valign: 'middle', sort: true},
	    		      {field:'updateTimeFormat', title: '修改时间', align: 'center', valign: 'middle', sort: true},
	    		      {field:'tips', title: '书籍简介', align: 'center', valign: 'middle', sort: true},
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



