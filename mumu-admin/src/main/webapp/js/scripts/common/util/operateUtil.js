define(['app', 'ajaxService', 'dialogFactory'], function(app) {
	app.service('operateUtil', ['ajaxService', 'dialogFactory', 'layer', '$compile','$interval', 
			function (ajaxService, dialogFactory, layer, $compile, $interval) {
		var me = this;
		
		/**
		 * 添加、编辑提交操作
		 */
		me.doSubmit = function(obj){
		   me.scope = obj.scope
 		   // 点击提交时，所有必填输入框都设成修改过
       	   for(property in me.scope.editForm){
       		   if(!property.startsWith("$")){
       			   me.scope.editForm[property].$setDirty();
       		   }
       	   }
       	   // 校验表单是否填写正确
       	   if(me.scope.editForm && !me.scope.editForm.$valid){
       			return false;
       	   }
 		   ajaxService.ajaxPost(obj.url, obj.params || me.scope.submitData).then(
			   dealSuccessResult,
			   dealErrorResult
	   	   );
 	   }
		
		/**
		 * 删除操作
		 */
		me.confirmSubmit = function(obj){
			try {  
				me.doConfirm(obj);
 			} catch(e) {  
 				return false;  
 			}  
		}
		
		/**
		 * confirm 操作封装
		 */
		me.doConfirm = function(obj){
			me.scope = obj.scope
			var requsetParam = [];
			// 操作是否需要先选中数据
			if(!obj.noNeedCheckd){
				if(obj.tableType == 'tree'){
					requsetParam = confirmCheckTreeTable(obj);
				}else{
					requsetParam = confirmCheckNormalTable(obj);
				}
			}
    		// 将选中的记录设置成待修改的元素
    		dialogFactory.confirm (obj.msg, function(){
    			ajaxService.ajaxPost(obj.url, obj.params || requsetParam).then(
					dealSuccessResult,
					dealErrorResult
        		)},
        		function(index){
                	me.scope.closeLayer();
        		}
    		  
    		);
		}
		
		/**
		 * 打开窗口（主要用于添加和编辑）
		 * setChosed : 打开窗口前是否要设置选中值，比如编辑时要会写数据，故编辑窗口要设置为true，添加时不要会写数据，故设置为false
		 */
		me.openLayer = function (obj, callback){
			me.scope = obj.scope;
			if(obj.setChosed){
				if(obj.tableType == 'tree'){
					// 树形table获取选中值
					if(!me.scope.table.bootstrapTreeTable('getSelections')[0]){
						dialogFactory.info("请先选中表格中的某一记录！");
						return false;
					}
					// 先获取选中记录的id
					var id = me.scope.table.bootstrapTreeTable('getSelections')[0].id;
					// 通过id获取到对象
					angular.forEach(me.scope.table.cacheRootNodes, function(item){
						if(item.id == id){
							me.scope.submitData = angular.copy(item);
							return false; 
						}
					});
		    		
				}else{
					// 普通表格获取选中的记录
		    		var checkStatus = me.scope.table.checkStatus('listReload');
		    		// 有且只能选中一条记录进行修改
		    		if(checkStatus.data.length != 1){
		    			dialogFactory.info("请先选中表格中的某一记录！");
		    			return false;
		    		}
		    		// 将选中的记录设置成待修改的元素
		    		me.scope.submitData = angular.copy(checkStatus.data[0]);
				}
			}
			// 打开编辑窗口
    		me.scope.layerIndex = layer.open(angular.merge({
                title: '',
                area: '', //宽高
                move:false,
                contentUrl: '',
                btn:"",
                scope : me.scope,
                cancel:function(){
                	me.scope.closeLayer();
                },
                success:function(){
                	if(callback){
            			callback();
            		}
                }
            },obj.layerprops));
		}
		
		/**
		 * 简单展示信息详情
		 * field: 用于展示的属性
		 */
		me.infoDetail = function(title, scope, field){
			me.scope = scope;
			// 获取到表格中选中的记录
    		var checkStatus = me.scope.table.checkStatus('listReload');
    		// 有且只能选中一条记录进行修改
    		if(checkStatus.data.length != 1){
    			dialogFactory.info("请先选中表格中的某一记录！");
    	        return false;
    		}
    		me.scope.submitData = angular.copy(checkStatus.data[0]);
			dialogFactory.infoDetail(title, scope.submitData[field]);
		}
		
		/**
		 * 按钮编译
		 */
		me.compileButton = function(scope){
			me.scope = scope;
			if(me.scope.timer){
				return;
			}
		    // layui表格渲染的dom需要主动编译，否则按钮点击事件将失效
			me.scope.timer = $interval(function(){
			   if($(".operationBtn").length > 0){
				    $interval.cancel(me.scope.timer);
				    // 重新编译dom
			        angular.forEach($(".operationBtn"),function(element){
					   $compile(element)(me.scope);  
				    })
				    delete me.scope.timer;
			   }
		   }, 200);
		}
		
		/**
		 * 响应200时处理逻辑
		 */
		 function dealSuccessResult(result){
			dialogFactory.success(result.message);
			me.scope.reloadTable();
			me.scope.clearSelected();
		}
		
		/**
		 * 系统错误时（响应非200）
		 */
		 function dealErrorResult(result){
			 dialogFactory.error(result.message);
			 me.scope.clearSelected();
		}
		 
		 /**
		  * confirm 操作时检查是否选中记录-树形表
		  */
		 function confirmCheckTreeTable(obj){
			 var data = me.scope.table.bootstrapTreeTable('getSelections');
			 var requsetParam = [];
			 if(!obj.multiple){
				// 树形table获取选中值
				if(data.length != 1){
					dialogFactory.info("请先选中表格中的某一记录！");
					throw new Error();  
				}else{
					requsetParam = me.scope.table.bootstrapTreeTable('getSelections')[0].id;
					return requsetParam;
				}
			 }else{
				if(data.length >= 1){
    				angular.forEach(data, function(item, index){
    					requsetParam[index] = item.id;
    				});
    				
    				return requsetParam;
    			}else{
    				dialogFactory.info("请先选中表格中的记录！");
    				throw new Error();  
    			}
			 }
		 }
		 
		 /**
		  * confirm 操作时检查是否选中记录-普通表
		  */
		 function confirmCheckNormalTable(obj){
			var checkStatus = me.scope.table.checkStatus('listReload');
			var requsetParam = [];
			// 有且只能选中一条记录进行修改
    		if(!obj.multiple){
    			if(checkStatus.data.length != 1){
    				dialogFactory.info("请先选中表格中的某一记录！");
    				throw new Error();  
    			}else{
    				requsetParam = checkStatus.data[0].id;
    				return requsetParam;
    			}
    		}else{
    			if(checkStatus.data.length >= 1){
    				angular.forEach(checkStatus.data, function(item, index){
    					requsetParam[index] = item.id;
    				});
    				return requsetParam;
    				
    			}else{
    				dialogFactory.info("请先选中表格中的记录！");
    				throw new Error();  
    			}
    		}
		}
		
	}]);
});