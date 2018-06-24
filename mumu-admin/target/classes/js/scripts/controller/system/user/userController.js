define(['app','deptTreeService', 'permissionService', 'roleTreeService', 
		'urlConstants', 'operateUtil','tableUtil', 'equalTo'], function (app) {
    app.controller('userController',['$scope',
    	                             'deptTreeService', 
    	                             'permissionService',
    	                             'roleTreeService', 
                                     'urlConstants', 
                                     'operateUtil', 
                                     'tableUtil',
                                     'layer', 
                            function ($scope, 
                            		  deptTreeService,
                            		  permissionService,
                            		  roleTreeService, 
    			                      urlConstants,
    			                      operateUtil, 
    			                      tableUtil,
    			                      layer){
			
    	    /**
    	     * 主页面-添加用户打开弹框
    	     */
    	    $scope.openAdd = function(){
    	    	operateUtil.openLayer(
	    			{
	    				scope: $scope,
	    				layerprops:{
	    					title: '用户添加',
	    					area: ['800px','auto'],
                            contentUrl: urlConstants.MGR_ADD_PAGE_URL
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
     	    		 url: urlConstants.MGR_ADD_URL
     	    	 });
     	     }
    	    
    	    /**
    	     * 主页面-编辑用户打开弹框
    	     */
    	    $scope.openUpdate = function(){
    	    	operateUtil.openLayer(
	    			{
	    				scope: $scope,
	    				layerprops:{
	    					title: '用户修改',
	    					area: ['800px','auto'],
                            contentUrl: urlConstants.MGR_UPDATE_PAGE_URL
                        },
                        setChosed: true
	    			}
    			);
   		     }
    	    
    	     /**
     	     *  修改页面-提交任务
     	     */
     	     $scope.updateSubmit = function(){
     	    	 operateUtil.doSubmit({
     	    		 scope: $scope, 
     	    		 url: urlConstants.MGR_UPDATE_URL
     	    	 });
     	     }
     	     
     	     /**
         	 * 删除用户
         	 */
         	 $scope.deleteUser = function(){
         		 operateUtil.confirmSubmit({
     				scope: $scope,
     				url: urlConstants.MGR_DELETE_URL,
     				multiple: true,
     				msg: '确定要删除该用户吗？'
     			});
         	 }
         	 
         	 /**
         	  * 重置密码
         	  */
         	 $scope.resetPassword = function(){
         		operateUtil.confirmSubmit({
         			scope: $scope,
     				url: urlConstants.MGR_RESET_PASSWORD_URL,
     				multiple: false,
     				msg: '确定要重置为系统默认密码吗？'
         		});
         	 }
         	 
         	 /**
         	  * 冻结用户
         	  */
         	 $scope.freeze = function(){
         		operateUtil.confirmSubmit({
         			scope:$scope,
     				url: urlConstants.MGR_FREEZE_URL,
     				multiple: false,
     				msg: '确定要冻结该用户吗？'
         		});
         	 }
    	    
         	 /**
         	  * 用户解冻 
         	  */
         	 $scope.unfreeze = function(){
          		operateUtil.confirmSubmit({
          			scope:$scope,
      				url: urlConstants.MGR_UNFREEZE_URL,
      				multiple: false,
      				msg: '确定要解冻该用户吗？'
          		});
          	 }
         	 
	         /**
	          * 主页面-清除筛选条件
	          */
	         $scope.clear = function(){
	    	    $scope.searchItem = angular.copy($scope.defaultSearchItem);
	    	    deptTreeService.getDeptTree($scope, initDeptTreeForSearch);
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
	    	   * 添加、修改弹框-关闭时清除选中
	    	   */
	    	  $scope.clearSelected = function(){
	    		  $scope.submitData = {};
	    	  }
    	   
	    	/**
	    	 * 添加、修改页面-显示部门树
	    	 */
	    	$scope.showDeptTree = function(){
	    		deptTreeService.getDeptTree($scope, deptTreeService.showDeptTree);
	    	}
	    	
	    	/**
	    	 * 添加、编辑页面-点击选中部门
	    	 */
	    	$scope.chooseDeptTree = function(event, treeId, treeNode) {
	    		if(null != treeNode){
		    		$scope.submitData.deptid = treeNode.id;
		    		$scope.submitData.deptName = treeNode.name;
		    		$scope.$apply();
	    		}
			}
	    	
	    	/**
	    	 * 添加、编辑页面-显示角色选择树
	    	 */
	    	$scope.showRoleTree = function(){
    		    $scope.roleTreeCheckable = true; // 角色设置展示的角色树是否显示复选框,即是否支持多选
		    	$scope.roleTreePable = false; // 角色树是否展示为父子级结构
	    		// 初始化组织机构
	    		roleTreeService.getRoleTree($scope, roleTreeService.showRoleTree);
	    	}
	    	
	    	/**
	    	 * 点击设置角色(用于回调)
	    	 */
	    	$scope.chooseRoleTree = function(event, treeId, treeNode){
	    		var roleTree = $.fn.zTree.getZTreeObj("roleTree");
	    		if(null != treeNode){
	    			var checkedNodeIds = [];
	    			var checkedNodeNames = [];
	    			var checkedNodes = roleTree.getCheckedNodes();
	    			angular.forEach(checkedNodes, function(node, index){
	    				checkedNodeIds[index] = node.id;
	    				checkedNodeNames[index] = node.name;
	    			});
	    			$scope.submitData.roleid = checkedNodeIds.join(",");
	    			$scope.submitData.roleName = checkedNodeNames.join(",");
	    			$scope.$apply();
	    		}
	    	}
	    	
    	   /**
    	    * 添加、修改页面-时间控件初始化
    	    */
    	   $scope.initLaydate = function(){
    		   layui.use('laydate', function(){
     			   var laydate = layui.laydate;
     			   //注册开始日期
     			   laydate.render({
     			     elem: '#birthday',
     			     done:function(value){
     			    	$scope.submitData.birthday = value;
     			    }
     			   });
     		    });
    	   }
    	   
		   // 页面初始化 
		   init();
		   function init (){
			   setDefaultVars();// 设置变量及常量
			   showMain();// 展示主页面数据
			   permission();// 按钮权限
		   }
		   
		   /**
		    * 设置变量及常量
		    */
		   function setDefaultVars(){
			// 默认查询条件
	    	   $scope.defaultSearchItem = {
	        		   name : '',
	        		   beginTime: '', 
	        		   endTime:'',
	    			   deptid:''
	           }
	    	   $scope.searchItem = angular.copy($scope.defaultSearchItem);
	    	   $scope.submitData = {};// 修改用户时选择的用户，也是添加时model绑定的，添加和编辑是一个页面
	    	   $scope.buttonPermission = {
					   add:false,
					   update:false,
					   delete:false,
					   reset:false,
					   freeze: false,
					   unfreeze: false
			   }
	    	   $scope.buttons = ['/mgr/add','/mgr/update','/mgr/delete','/mgr/reset','/mgr/freeze','/mgr/unfreeze'];

	       	   $scope.tableOptions = {
	   		        url: urlConstants.MGR_LIST_URL, //请求地址
	   		        cols: [[
	   	    		      {checkbox: true, fixed: true},
	   	    		      {field:'account', title: '账号', align: 'center', valign: 'middle', sort: true},
	   	    		      {field:'name', title: '姓名', align: 'center', valign: 'middle', sort: true},
	   	    		      {field:'sexName', title: '性别', align: 'center', valign: 'middle', sort: true},
	   	    		      {field:'roleName', title: '角色', align: 'center', valign: 'middle', sort: true},
	   	    		      {field:'deptName', title: '部门', align: 'center', valign: 'middle', sort: true},
	   	    		      {field:'email', title: '邮箱', width:180, align: 'center', valign: 'middle', sort: true},
	   	    		      {field:'phone', title: '电话', align: 'center', valign: 'middle', sort: true},
	   	    		      {field:'createtimeFormat', title: '创建时间', width:180, align: 'center', valign: 'middle', sort: true},
	   	    		      {field:'statusName', title: '状态', align: 'center', valign: 'middle', sort: true}
	   	    		    ]],
	   		        page: true //是否分页
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
				   $scope.table.init('mgr_user_table', tableUtil.tableOptions($scope));
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
			   
			   // 初始化组织机构
			   deptTreeService.getDeptTree($scope, initDeptTreeForSearch);
		   }
		   
	       /**
		    * 主页面-展示部门树
		    * 初始化部门树只能当做回调函数传入deptTreeService.getDeptTree（）中，否则因为异步问题，部门树将不能展示
		    */
		   function initDeptTreeForSearch(deptzNodes){
			   $.fn.zTree.init($("#deptTreeForSearch"), deptTreeService.getDeptZNodeSetting(checkDeptForSearch),deptzNodes);
		   }
		   
		   /**
    	    * 主页面-点击部门树，用于查询条件设置
    	    */
	       function checkDeptForSearch(event, treeId, treeNode) {
	    	   if(null != treeNode){
	    		   $scope.searchItem.deptid = treeNode.id;
	    	   }
		   }
	       
	       /**
		    * 按钮权限
		    */
		   function permission(){
			   permissionService.hasPermission($scope);
		   }
    }]);
}); 



