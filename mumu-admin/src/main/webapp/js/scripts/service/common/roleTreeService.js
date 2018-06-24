define([ 'app', 'ajaxService', 'urlConstants', 'jquery.excheck'], function(app) {
	app.service('roleTreeService', ['ajaxService', 'urlConstants', function(ajaxService, urlConstants) {
		var me = this;
		
		/**
		 * 获取角色列表及角色树数据
		 * scope:作用域 
		 * callback: 回调函数，主要解决异步问题
		 */
		me.getRoleTree = function(scope, callback ){
			 me.scope = scope;
			 var zNodes = [];// 角色树节点数据 
			 ajaxService.ajaxPost(urlConstants.ROLE_LIST_URL).then(function(result){
	    		 angular.forEach(result.data, function(role, index){
	    			var zNode = {};
	    			zNode.id = role.id;
	    			if(me.scope.roleTreePable){
	    				// 角色树是否展示为父子级结构
	    				zNode.pId = role.pid;
	    			}
	    			zNode.name = role.name;
	    			zNode.open = role.pid == role.id ? true : false;
	    			zNodes[index] = zNode;
	    		});
	    		if(callback){
	    			callback(zNodes);
	    		}
			});
		}

		/**
		 * 显示角色树
		 */
		me.showRoleTree = function(rolezNodes){
			// 取消错误提示
			me.scope.editForm.chosedRoleName.$dirty = false;
			
       		// 复选框树编辑时，由于用户已被设置过角色，此时要会写在页面上
			if(me.scope.roleTreeCheckable){
				if(me.scope.submitData && me.scope.submitData.id){
	       			var chosedUserRoleIds = me.scope.submitData.roleid.split(",");
	       			angular.forEach(rolezNodes, function(node, outindex){
	       				angular.forEach(chosedUserRoleIds, function(chosedUserRoleId, inindex){
			       			if(chosedUserRoleId == node.id){
			       				node.checked = true;
			       			}
	       				});
	       			});
	       		}
			}
       		
       		$.fn.zTree.init($("#roleTree"), me.getRoleZNodeSetting(me.scope.chooseRoleTree), rolezNodes);
       	    $("#roleMenu").css({
       	        'position': 'absolute',
   	    	    'left': '104px',
   	    	    'top': '34px',
   	    	    'z-index': '9999'
       	    }).slideDown("fast");
       	    $("body").bind("mousedown", hideRoleTree);
		}
		
		/**
    	 * 添加、编辑页面-鼠标事件，用于显隐角色树
    	 */
    	function hideRoleTree(event) {
    		if(!me.scope.submitData || !me.scope.submitData.roleid){
    			me.scope.editForm.chosedRoleName.$dirty = true;
    			me.scope.$apply();
    		}
    	    if (!(event.target.id == "menuBtn" || event.target.id == "roleMenu" || $(
    	            event.target).parents("#roleMenu").length > 0)) {
    	    	hideRoleSelectTree();
    	    }
    	}
		
    	/**
    	 * 添加、编辑页面-隐藏角色选择的树
    	 */
    	function hideRoleSelectTree() {
    	    $("#roleMenu").fadeOut("fast");
    	    $("body").unbind("mousedown", hideRoleTree);
    	}
		
		
		/**
		 * callback:点击选择触发事件 
		 */
		me.getRoleZNodeSetting = function(callback) {
			if(me.scope.roleTreeCheckable){ // 复选框角色树
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
				return { // 普通角色树
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
		};
	}]);
});
