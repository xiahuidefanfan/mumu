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
    	 * 获取权限树
    	 */
    	$scope.getMenuTree = function(){
    		menuTreeService.getMenuTree($scope)
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
                 {title: '层级', field: 'levels', align: 'center'},
                 {title: '是否是菜单', field: 'isMenuName', align: 'center'},
                 {title: '状态', field: 'statusName', align: 'center'}],	//列数组
             height: 540,
    	}
    	
    	$scope.searchItem = {
    			
    	}
    	
    	init();
    	function init(){
    		$scope.table = treeTableUtil.treeTable($scope);
    	}
    	
    }]);
}); 



