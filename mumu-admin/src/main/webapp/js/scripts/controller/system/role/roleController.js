define(['app', 'menuTreeService', 'permissionService', 'roleTreeService', 'urlConstants', 
		'operateUtil', 'treeTableUtil','bootstrapTreeTable'], function (app) {
    app.controller('roleController',['$scope',
    								 'menuTreeService',
    								 'permissionService',
    								 'roleTreeService',
    								 'urlConstants', 
    								 'operateUtil', 
    								 'treeTableUtil',
    								 'layer', 
    					   function ($scope, 
    							     menuTreeService,
    							     permissionService,
    							     roleTreeService,
    								 urlConstants, 
    								 operateUtil,
    								 treeTableUtil,
    								 layer){
    	
    	
    	/**
    	 * 添加部门
    	 */
    	$scope.openAdd = function(){
    		operateUtil.openLayer(
				{
    				scope: $scope,
    				layerprops:{
    					title: '角色添加',
    					area: ['800px','auto'],
                        contentUrl: urlConstants.ROLE_ADD_PAGE_URL
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
    			url: urlConstants.ROLE_ADD_URL
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
    					title: '角色修改',
    					area: ['800px','auto'],
                        contentUrl: urlConstants.ROLE_UPDATE_PAGE_URL
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
    			url: urlConstants.ROLE_UPDATE_URL
    		});
		}
    	
    	/**
    	 * 删除角色
    	 */
    	$scope.deleteRole = function(){
    		operateUtil.confirmSubmit({
 				scope:$scope,
 				url: urlConstants.ROLE_DELETE_URL,
 				tableType: 'tree',
 				msg: '确定要删除选中的角色吗？'
 				
 			})
    	}
    	
    	/**
    	 * 分配权限
    	 */
    	$scope.openAssign = function(){
    		operateUtil.openLayer(
				{
    				scope: $scope,
    				layerprops:{
    					title: '权限分配',
    					area:['322px', '480px'],
                        contentUrl: urlConstants.ROLE_ASSIGN_PAGE_URL
                    },
                    tableType: 'tree',
                    setChosed: true
    			},
    			getAuthorityTree
			);
    	}
    	
    	/**
    	 * 获取权限树
    	 */
    	function getAuthorityTree(){
    		menuTreeService.getAuthorityTree($scope)
    	}
    	
    	/**
    	 * 点击设置权限(用于回调)
    	 */
    	$scope.chooseMenuTree = function(event, treeId, treeNode){
    		var roleTree = $.fn.zTree.getZTreeObj("menuTree");
    		if(null != treeNode){
    			var checkedNodeIds = [];
    			var checkedNodes = roleTree.getCheckedNodes();
    			angular.forEach(checkedNodes, function(node, index){
    				checkedNodeIds[index] = node.realId;
    			});
    			$scope.authority.ids = checkedNodeIds.join(",");
    		}
    	}
    	
    	/**
    	 * 提交设置好的权限
    	 */
    	$scope.setAuthority = function(){
    		$scope.authority.roleId = $scope.submitData.id;
    		operateUtil.doSubmit({
    			scope: $scope, 
    			url: urlConstants.ROLE_SET_AUTHORITY_URL,
    			params: $scope.authority
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
    	 * 显示角色树（父子级select树）
    	 */
    	$scope.showRoleTree = function(){
    		roleTreeService.getRoleTree($scope, roleTreeService.showRoleTree);
    	}
    	
    	/**
    	 * 点击设置角色(用于回调)
    	 */
    	$scope.chooseRoleTree = function(event, treeId, treeNode){
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
		   $scope.menuTreeCheckable = true; // 权限树展示成复选框样式
		   $scope.defaultSearchItem = {
			   name: ''   
		   };// 搜索初始值
		   $scope.searchItem = angular.copy($scope.defaultSearchItem);
		   $scope.roleTreeCheckable = false; // 角色设置展示的角色树是否显示复选框,即是否支持多选
   	       $scope.roleTreePable = true; // 角色树是否展示为父子级结构
		   $scope.submitData = {}; // 选中的角色
		   $scope.authority = {};
		   $scope.buttonPermission = {
				   add:false,
				   update:false,
				   delete:false,
				   setAuthority:false
		   }
		   $scope.buttons = ['/role/add','/role/update','/role/delete','/role/setAuthority'];
		   
		   $scope.tableOptions = {
			    tableId: 'roleTable' ,// 选取记录返回的值
			    code: 'id',// 用于设置父子关系
	            parentCode: 'pid',// 用于设置父子关系
   		        url: urlConstants.ROLE_LIST_URL, //请求地址
   		        ajaxParams: $scope.searchItem, //请求数据的ajax的data属性
   		        columns: [
	        		  {field: 'selectItem', radio: true},
   	    		      {field:'id', title: 'id', align: 'center'},
   	    		      {field:'name', title: '角色名称'},
   	    		      {field:'tips', title: '角色编码', align: 'center'},
   	    		      {field:'pName', title: '上级角色', align: 'center'},
   	    		      {field:'num', title: '排序', align: 'center'}
   	    		    ],
   			    height: 570,
   		   };
		   
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
	   
	   /**
	    * 按钮权限
	    */
	   function permission(){
		   permissionService.hasPermission($scope);
	   }
    }]);
}); 



