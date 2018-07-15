define(['app', 'deptTreeService', 'permissionService', 'menuTreeService',
		'urlConstants','operateUtil', 'treeTableUtil', 'bootstrapTreeTable'], function (app) {
    app.controller('menuController',['$scope', 
    								 'deptTreeService',
    								 'permissionService',
    								 'menuTreeService',
    								 'urlConstants', 
    								 'operateUtil', 
    								 'treeTableUtil',
    								 'layer', 
    					   function ($scope, 
    							     deptTreeService,
    							     permissionService,
    							     menuTreeService,
    								 urlConstants, 
    								 operateUtil, 
    								 treeTableUtil,
    								 layer) {
    
    	/**
    	 * 添加菜单
    	 */
    	$scope.openAdd = function(){
    		operateUtil.openLayer(
				{
    				scope: $scope,
    				layerprops:{
    					title: '菜单添加',
    					area: ['800px','auto'],
                        contentUrl: urlConstants.MENU_ADD_PAGE_URL
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
    			url: urlConstants.MENU_ADD_URL
    		});
		}
    	
    	/**
	     * 主页面-编辑菜单打开弹框
	     */
	    $scope.openUpdate = function(){
	    	operateUtil.openLayer(
    			{
    				scope: $scope,
    				layerprops:{
    					title: '菜单修改',
    					area: ['800px','auto'],
                        contentUrl: urlConstants.MENU_UPDATE_PAGE_URL
                    },
                    setChosed: true,
                    tableType: 'tree'
    			}
			);
	     }
	    
	     /**
 	     *  修改页面-提交任务
 	     */
 	     $scope.updateSubmit = function(){
 	    	 if($scope.submitData.ismenu != 1){
 	    		 // 如果更新时，将菜单改成非菜单，则删除菜单路由这个属性
 	    		 $scope.submitData.route = "";
 	    	 }
 	    	 operateUtil.doSubmit({
 	    		 scope: $scope, 
 	    		 url: urlConstants.MENU_UPDATE_URL
 	    	 });
 	     }
 	     
 		/**
     	 * 删除菜单
     	 */
     	$scope.deleteMenu = function(){
     		operateUtil.confirmSubmit({
  				scope:$scope,
  				url: urlConstants.MENU_DELETE_URL,
  			    tableType: 'tree',
  				msg: '确定要删除选中的菜单吗？'
  				
  				
  			})
     	}
	    
		/**
    	 * 获取权限树
    	 */
    	$scope.showMenuTree = function(){
    		menuTreeService.getMenuTree($scope)
    	}
	    
	    /**
    	 * 点击设置父级菜单(用于回调)
    	 */
    	$scope.chooseMenuTree = function(event, treeId, treeNode){
    		if(null != treeNode){
	    		$scope.submitData.pcode = treeNode.id;
    			$scope.submitData.pcodeName = treeNode.name;
    			$scope.$apply();
    		}
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
   	    * 添加、修改弹框-关闭时清除选中
   	    */
        $scope.clearSelected = function(){
   		   $scope.submitData = {};
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
			   condition: "",
			   level: ""
           }
    	   $scope.searchItem = angular.copy($scope.defaultSearchItem);
    	   $scope.submitData = {};
    	   $scope.buttonPermission = {
				   add:false,
				   update:false,
				   delete:false
		   }
		   $scope.buttons = ['/menu/add','/menu/update','/menu/delete'];
    	   $scope.tableOptions = {
				 tableId: 'menuTable' ,// 选取记录返回的值
	             code: 'code',// 用于设置父子关系
	             parentCode: 'pcode',// 用于设置父子关系
	             url: urlConstants.MENU_LIST_URL,//请求数据的ajax的url
	             ajaxParams: $scope.searchItem, //请求数据的ajax的data属性
	             columns: [
	                 {field: 'selectItem', radio: true},
	                 {title: 'id', field: 'id', align: 'center'},
	                 {title: '菜单名称', field: 'name', width: '12%'},
	                 {title: '菜单编号', field: 'code', width: '12%', align: 'center'},
	                 {title: '菜单父编号', field: 'pcode', align: 'center'},
	                 {title: '请求地址', field: 'url', width: '15%', align: 'center'},
	                 {title: '菜单路由', field: 'route', width: '15%', align: 'center'},
	                 {title: '层级', field: 'levels', align: 'center'},
	                 {title: '菜单类型', field: 'isMenuName', align: 'center'},
	                 {title: '状态', field: 'statusName', align: 'center'}],	//列数组
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
	    
	    /**
	    * 按钮权限
	    */
	    function permission(){
	    	permissionService.hasPermission($scope);
	    }
    	
    }]);
}); 



