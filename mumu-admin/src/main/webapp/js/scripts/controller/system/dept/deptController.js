define(['app', 'deptTreeService', 'permissionService', 'urlConstants','operateUtil', 'treeTableUtil','bootstrapTreeTable'], function (app) {
    app.controller('deptController',['$scope', 
    								 'deptTreeService',
    								 'permissionService',
    								 'urlConstants', 
    								 'operateUtil', 
    								 'treeTableUtil',
    								 'layer', 
    					   function ($scope, 
    							     deptTreeService,
    							     permissionService,
    								 urlConstants, 
    								 operateUtil, 
    								 treeTableUtil,
    								 layer) {
    	
    	/**
    	 * 添加部门
    	 */
    	$scope.openAdd = function(){
    		operateUtil.openLayer(
				{
    				scope: $scope,
    				layerprops:{
    					title: '部门添加',
    					area: ['800px','auto'],
                        contentUrl: urlConstants.DEPT_ADD_PAGE_URL
                    }
    			}
			);
    	}
    	
    	/**
    	 * 提交添加
    	 */
    	$scope.addSubmit = function(){
    		operateUtil.doSubmit({
    			scope: $scope, 
    			url: urlConstants.DEPT_ADD_URL
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
    					area: ['800px','auto'],
                        contentUrl: urlConstants.DEPT_UPDATE_PAGE_URL
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
    			url: urlConstants.DEPT_UPDATE_URL
    		});
		}
    	
    	/**
    	 * 删除部门
    	 */
    	$scope.deleteDept = function(){
    		operateUtil.confirmSubmit({
 				scope:$scope,
 				url: urlConstants.DEPT_DELETE_URL,
 				tableType: 'tree',
 				msg: '确定要删除选中的部门吗？'
 				
 			})
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
    	    $scope.parDeptName = "";
    	}
    	
    	/**
    	 * 添加、编辑页面显示部门树
    	 */
    	$scope.showDeptTree = function() {
    		deptTreeService.getDeptTree($scope,deptTreeService.showDeptTree);
    	}
    	
    	/**
    	 * 点击选中父部门(用于回调)
    	 */
    	$scope.chooseDeptTree = function(event, treeId, treeNode) {
    		if(null != treeNode){
    			// 父部门id要单独设置
	    		$scope.submitData.pid = treeNode.id;
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
		    permission();// 按钮权限
    	}
    	
	   /**
	    * 设置变量及常量
	    */
	   function setDefaultVars(){
		   $scope.rootDeptPid = 0;
		   $scope.depts = [];// 列表展示数据
		   $scope.defaultSearchItem = {
			   name: ''   
		   };// 搜索初始值
		   $scope.searchItem = angular.copy($scope.defaultSearchItem);
		   $scope.submitData = {}; // 选中的部门
		   $scope.buttonPermission = {
				   add:false,
				   update:false,
				   delete:false
		   }
		   $scope.buttons = ['/dept/add','/dept/update','/dept/delete'];
		   
		   $scope.tableOptions = {
				 tableId: 'deptTable' ,// 选取记录返回的值
	             code: 'fullname',// 用于设置父子关系
	             parentCode: 'pName',// 用于设置父子关系
	             url: urlConstants.DEPT_LIST_URL,//请求数据的ajax的url
	             ajaxParams: $scope.searchItem, //请求数据的ajax的data属性
	             columns: [
	                 {field: 'selectItem', radio: true},
	                 {title: 'id', field: 'id', align: 'center'},
	                 {title: '部门简称', field: 'simplename', width: '12%'},
	                 {title: '部门全称', field: 'fullname', width: '18%', align: 'center'},
	                 {title: '上级部门', field: 'pName', align: 'center'},
	                 {title: '备注', field: 'tips', align: 'center'},
	                 {title: '排序', field: 'num', align: 'center'}],	//列数组
	             height: 540,
	    	}
    	   
    	   /**
    	    * 刷新表格
    	    */
    	    $scope.reloadTable = function(){
    		   	 treeTableUtil.reloadTable($scope);
    	    }
	    } 
		   
	    function showMain(){
		   $scope.table = treeTableUtil.treeTable($scope);
	    }	
	   
	   /**
	    * 按钮权限
	    */
	   function permission(){
		   permissionService.hasPermission($scope);
	   }
    }]);
}); 



