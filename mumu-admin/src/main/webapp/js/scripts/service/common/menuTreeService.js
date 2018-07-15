define([ 'app','ajaxService','urlConstants', 'jquery.excheck' ], function(app) {
	app.service('menuTreeService', ['ajaxService', 'urlConstants', function(ajaxService, urlConstants) {
		var me = this;

		/**
		 * 获取权限树
		 * scope:作用域 
		 */
		me.getAuthorityTree = function(scope){
			 me.scope = scope;
			 var zNodes = [];// 菜单树节点数据 
			 ajaxService.ajaxPost(urlConstants.ROLE_AUTHORITY_URL, me.scope.submitData).then(function(result){
	    		 angular.forEach(result.data.menus, function(menu, index){
	    			var zNode = {};
	    			zNode.realId = menu.id;
	    			zNode.id = menu.code;
	    			zNode.pId = menu.pcode;
	    			zNode.name = menu.name;
	    			zNode.open = menu.pcode == '0' ? true : false;
	    			angular.forEach(result.data.authorities, function(authority, index){
	    				if(menu.id == authority){
	    					zNode.checked = true;
	    				}
	    			});
	    			zNodes[index] = zNode;
	    		});
	    		 $.fn.zTree.init($("#menuTree"), me.getMenuZNodeSetting(me.scope.chooseMenuTree), zNodes);
	        		$("#menuMenu").css({
	        	        'position': 'absolute',
	    	    	    'left': '104px',
	    	    	    'top': '34px',
	    	    	    'z-index': '9999'
	        	    }).slideDown("fast");
			});
		}
		
		/**
		 * 获取菜单树
		 * scope:作用域 
		 */
		me.getMenuTree = function(scope){
			 me.scope = scope;
			 var zNodes = [];// 菜单树节点数据 
			 ajaxService.ajaxPost(urlConstants.MENU_LIST_URL, me.scope.submitData).then(function(result){
	    		 angular.forEach(result.data, function(menu, index){
	    			var zNode = {};
	    			zNode.realId = menu.id;
	    			zNode.id = menu.code;
	    			zNode.pId = menu.pcode;
	    			zNode.name = menu.name;
	    			zNode.open = menu.pcode == '0' ? true : false;
	    			zNodes[index] = zNode;
	    		});
	    		 showMenuTree(zNodes);
			});
		}
		
		/**
		 * 展示菜单树实现方法
		 */
		 function showMenuTree(zNodes){
       		$.fn.zTree.init($("#menuTree"), me.getMenuZNodeSetting(me.scope.chooseMenuTree), zNodes);
       		$("#menuMenu").css({
       	        'position': 'absolute',
   	    	    'left': '104px',
   	    	    'top': '34px',
   	    	    'z-index': '9999'
       	    }).slideDown("fast");
       	    $("body").bind("mousedown", hideMenuTree);
		}
		 
		 /**
    	 * 添加、编辑页面-隐藏菜单选择的树
    	 */
    	function hideMenuSelectTree() {
    	    $("#menuMenu").fadeOut("fast");
    	    $("body").unbind("mousedown", hideMenuTree);
    	}
    	
    	/**
    	 * 添加、编辑页面-鼠标事件，用于显隐菜单树
    	 */
    	function hideMenuTree(event) {
    		if(!me.scope.submitData || !me.scope.submitData.pcode){
    			me.scope.editForm.pcodeName.$dirty = true;
    			me.scope.$apply();
    		}
    	    if (!(event.target.id == "menuBtn" || event.target.id == "menuMenu" || $(
    	            event.target).parents("#menuMenu").length > 0)) {
    	    	hideMenuSelectTree();
    	    }
    	}
		
		/**
		 * * onMouseDown:点击选中触发事件 
		 */
		me.getMenuZNodeSetting = function (callback){
			
			if(me.scope.menuTreeCheckable){ // 复选框菜单树
				return {
						check: {
							enable: true
						},
						data: {
							simpleData: {
								enable: true
							}
						},
						callback: {
							onCheck: callback
						}
						
					}
			}else{
				return { // 普通菜单树
					data: {
						key: {
							title:"name"
						},
						simpleData: {
							enable: true
						}
					},
					callback: {
						onMouseDown: callback
					}
				};
			}
		}
	}]);
});
