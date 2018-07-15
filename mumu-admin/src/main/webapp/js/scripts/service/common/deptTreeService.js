define([ 'app', 'ajaxService', 'urlConstants' ], function(app) {
	app.service('deptTreeService', ['ajaxService', 'urlConstants', function(ajaxService, urlConstants) {
		var me = this;

		/**
		 * 获取部门及部门树数据
		 * scope:作用域 
		 * callback: 回调函数，主要解决异步问题
		 */
		me.getDeptTree = function(scope, callback ){
			 me.scope = scope;
			 var zNodes = [];// 部门树节点数据 
			 ajaxService.ajaxPost(urlConstants.DEPT_LIST_URL).then(function(result){
	    		 angular.forEach(result.data, function(dept, index){
	    			var zNode = {};
	    			zNode.id = dept.id;
	    			zNode.pId = dept.pid;
	    			zNode.name = dept.simplename;
	    			zNode.fullname = dept.fullname;
	    			zNode.open = true;
	    			zNodes[index] = zNode;
	    		});
	    		if(callback){
	    			// 设置回调主要解决异步问题
	    			callback(zNodes);
	    		}
			});
		}
		
		/**
		 * 展示部门树实现方法
		 */
		 me.showDeptTree = function(zNodes){
			// 取消错误提示
       		me.scope.editForm.chosedDeptName.$dirty = false;
       		$.fn.zTree.init($("#deptTree"), me.getDeptZNodeSetting(me.scope.chooseDeptTree), zNodes);
       	    $("#deptMenu").css({
       	        'position': 'absolute',
   	    	    'left': '104px',
   	    	    'top': '34px',
   	    	    'z-index': '9999'
       	    }).slideDown("fast");
       	    $("body").bind("mousedown", hideDeptTree);
		}
		
		/**
    	 * 添加、编辑页面-隐藏部门选择的树
    	 */
    	function hideDeptSelectTree() {
    	    $("#deptMenu").fadeOut("fast");
    	    $("body").unbind("mousedown", hideDeptTree);
    	}
    	
    	/**
    	 * 添加、编辑页面-鼠标事件，用于显隐部门树
    	 */
    	function hideDeptTree(event) {
    		if(!me.scope.submitData || !me.scope.submitData.deptid){
    			me.scope.editForm.chosedDeptName.$dirty = true;
    			me.scope.$apply();
    		}
    	    if (!(event.target.id == "menuBtn" || event.target.id == "deptMenu" || $(
    	            event.target).parents("#deptMenu").length > 0)) {
    	    	hideDeptSelectTree();
    	    }
    	}
		
		/**
		 * onMouseDown:点击选中触发事件 
		 */
		me.getDeptZNodeSetting = function getDeptZNodeSetting(onMouseDown){
			return {// 部门树配置 
				data: {
					key: {
						title:"fullname"
					},
					simpleData: {
						enable: true
					}
				},
				callback: {
					onMouseDown: onMouseDown
				}
			};
		}
	}]);
});
