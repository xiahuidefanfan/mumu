define(['app', 'dictTreeService', 'permissionService', 'urlConstants','operateUtil', 'treeTableUtil', 'bootstrapTreeTable'], function (app) {
    app.controller('dictController',['$scope', 
    								 'dictTreeService',
    								 'permissionService',
    								 'urlConstants', 
    								 'operateUtil', 
    								 'treeTableUtil',
    								 'layer', 
    					   function ($scope, 
    							     dictTreeService,
    							     permissionService,
    								 urlConstants, 
    								 operateUtil, 
    								 treeTableUtil,
    								 layer) {
    	
	    /**
	     * 主页面-添加字典打开弹框
	     */
	    $scope.openAdd = function(){
	    	operateUtil.openLayer(
    			{
    				scope: $scope,
    				layerprops:{
    					title: '字典添加',
    					area: ['808px','auto'],
                        contentUrl: urlConstants.DICT_ADD_PAGE_URL
                    }
    			}
			);
		     }
	    
	    /**
 	     *  添加-提交任务
 	     */
 	     $scope.addSubmit = function(){
 	    	 operateUtil.doSubmit({
 	    		 scope:$scope, 
 	    		 url: urlConstants.DICT_ADD_URL
 	    	 });
 	     }
    	
    	/**
    	 * 提交添加
    	 */
    	$scope.addSubmit = function(){
    		operateUtil.doSubmit({
    			scope: $scope, 
    			url: urlConstants.DICT_ADD_URL
    		});
		}
    	
    	/**
    	 * 修改部门，弹框展示
    	 */
    	$scope.openUpdate = function(){
    		operateUtil.openLayer(
				{
    				scope: $scope,
    				layerprops:{
    					title: '部门修改',
    					area: ['808px','auto'],
                        contentUrl: urlConstants.DICT_UPDATE_PAGE_URL
                    },
                    setChosed: true,
                    tableType: 'tree'
    			}
			);
	    }
    	
    	/**
    	 * 提交修改
    	 */
    	$scope.updateSubmit = function(){
    		operateUtil.doSubmit({
    			scope: $scope, 
    			url: urlConstants.DICT_UPDATE_URL
    		});
		}
    	
	     /**
     	 * 删除字典
     	 */
     	 $scope.deleteDict = function(){
     		 operateUtil.confirmSubmit({
 				scope: $scope,
 				url: urlConstants.DICT_DELETE_URL,
 				multiple: true,
 				tableType: 'tree',
 				msg: '确定要删除选中的字典吗？'
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
    	
    	/**
    	 * 添加、编辑页面显示字典树
    	 */
    	$scope.showDictTree = function() {
    		dictTreeService.getDictTree($scope,dictTreeService.showDictTree);
    	}

    	/**
    	 * 点击选中父字典(用于回调)
    	 */
    	$scope.chooseDictTree = function(event, treeId, treeNode) {
    		if(null != treeNode){
    			// 父部门id要单独设置
	    		$scope.submitData.pId = treeNode.id;
    			$scope.submitData.pName = treeNode.name;
    			$scope.$apply();
    		}
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
		   $scope.submitData = {}; // 选中的部门
		   $scope.tableOptions = {
				   tableId: 'dictTable',// 选取记录返回的值
	               code: 'id',// 用于设置父子关系
	               parentCode: 'pId',// 用于设置父子关系
	               url: urlConstants.DICT_LIST_URL,//请求数据的ajax的url
	               ajaxParams: $scope.searchItem, //请求数据的ajax的data属性
	               columns: [
	            	  {field: 'selectItem', radio: true},
	                  {title: 'id', field: 'id', visible: false, align: 'center', valign: 'middle'},
	                  {title: '名称', field: 'name', align: 'center', valign: 'middle', sortable: true},
	                  {title: '编码', field: 'code', align: 'center', valign: 'middle', sortable: true},
	                  {title: '父级名称', field: 'pName', align: 'center', valign: 'middle', sortable: true},
	                  {title: '排序', field: 'num', align: 'center', valign: 'middle', sortable: true},
	                  {title: '备注', field: 'tips', align: 'center', valign: 'middle', sortable: true},
	               ],
	             height: 540,
	       }
		   
		   /**
		    * 刷新表格
		    */
		   $scope.reloadTable = function(){
			   treeTableUtil.reloadTable($scope);
		   }
   	   }
		   
	   /**
	    * 展示主页面数据
	    */
	   function showMain(){
		   $scope.table = treeTableUtil.treeTable($scope);
	   }
	   
    }]);
}); 



