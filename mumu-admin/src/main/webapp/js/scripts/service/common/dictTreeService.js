define([ 'app', 'ajaxService', 'urlConstants' ], function(app) {
	app.service('dictTreeService', ['ajaxService', 'urlConstants', function(ajaxService, urlConstants) {
		var me = this;

		/**
		 * 获取字典及字典树数据
		 * scope:作用域 
		 * callback: 回调函数，主要解决异步问题
		 */
		me.getDictTree = function(scope, callback ){
			 me.scope = scope;
			 var zNodes = [];// 字典树节点数据 
			 ajaxService.ajaxPost(urlConstants.DICT_LIST_URL).then(function(result){
	    		 angular.forEach(result.data, function(dict, index){
	    			var zNode = {};
	    			zNode.id = dict.id;
	    			zNode.pId = dict.pId;
	    			zNode.name = dict.name;
	    			zNode.open = dict.pid == 0 ? true:false;
	    			zNodes[index] = zNode;
	    		});
	    		if(callback){
	    			// 设置回调主要解决异步问题
	    			callback(zNodes);
	    		}
			});
		}
		
		/**
		 * 展示字典树实现方法
		 */
		 me.showDictTree = function(zNodes){
			// 取消错误提示
       		me.scope.editForm.chosedDictName.$dirty = false;
       		$.fn.zTree.init($("#dictTree"), me.getDictZNodeSetting(me.scope.chooseDictTree), zNodes);
       	    $("#dictMenu").css({
       	        'position': 'absolute',
   	    	    'left': '100px',
   	    	    'top': '34px',
   	    	    'z-index': '9999'
       	    }).slideDown("fast");
       	    $("body").bind("mousedown", hideDictTree);
		}
		
		/**
    	 * 添加、编辑页面-隐藏字典选择的树
    	 */
    	function hideDictSelectTree() {
    	    $("#dictMenu").fadeOut("fast");
    	    $("body").unbind("mousedown", hideDictTree);
    	}
    	
    	/**
    	 * 添加、编辑页面-鼠标事件，用于显隐字典树
    	 */
    	function hideDictTree(event) {
    		if(!me.scope.submitData || !me.scope.submitData.dictid){
    			me.scope.editForm.chosedDictName.$dirty = true;
    			me.scope.$apply();
    		}
    	    if (!(event.target.id == "menuBtn" || event.target.id == "dictMenu" || $(
    	            event.target).parents("#dictMenu").length > 0)) {
    	    	hideDictSelectTree();
    	    }
    	}
		
		/**
		 * onMouseDown:点击选中触发事件 
		 */
		me.getDictZNodeSetting = function getDictZNodeSetting(onMouseDown){
			return {// 字典树配置 
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
