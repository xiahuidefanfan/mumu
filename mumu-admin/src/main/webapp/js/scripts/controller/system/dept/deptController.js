define(['app', 'deptTreeService', 'permissionService', 'urlConstants','operateUtil', 'tableUtil'], function (app) {
    app.controller('deptController',['$scope', 
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
                    setChosed: true
                    
    			},
    			setParDept
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
 				multiple: false,
 				msg: '确定要删除选中数据吗？'
 				
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
    			$scope.parDeptName = treeNode.name;
    			$scope.$apply();
    		}
		}
    	
    	/**
    	 * 获取选中的部门的父部门名称
    	 */
    	function setParDept(){
    		angular.forEach($scope.table.cache.listReload, function(dept, index){
    			if(dept.id == $scope.submitData.pid){
    				$scope.parDeptName = dept.simplename;
    				return false;
    			}
    		});
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
   		        url: urlConstants.DEPT_LIST_URL, //请求地址
   		        method: 'POST', //方式
   		        id: 'listReload', //生成 Layui table 的标识 id，必须提供，用于后文刷新操作，笔者该处出过问题
   		        cols: [[
   	    		      {checkbox: true, fixed: true},
   	    		      {field:'id', title: 'id', align: 'center', valign: 'middle', sort: true},
   	    		      {field:'simplename', title: '部门简称', align: 'center', valign: 'middle', sort: true},
   	    		      {field:'fullname', title: '部门全称', align: 'center', valign: 'middle', sort: true},
   	    		      {field:'pName', title: '上级部门', align: 'center', valign: 'middle', sort: true},
   	    		      {field:'tips', title: '备注', align: 'center', valign: 'middle', sort: true},
   	    		      {field:'num', title: '排序', align: 'center', valign: 'middle', sort: true}
   	    		    ]],
   	    		even: false, // 样式s
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
			   $scope.table.init('dept_table', $scope.tableOptions);
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



