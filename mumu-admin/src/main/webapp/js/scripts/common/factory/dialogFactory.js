define(['app'], function(app) {
	app.factory('dialogFactory', function () {
		var ctxPath = "";
		var dialogFactory = {};
		dialogFactory.addCtx = function (ctx) {
	        if (this.ctxPath == "") {
	            this.ctxPath = ctx;
	        }
	    },
	    dialogFactory.confirm = function (tip, ensure, cancel) {//询问框
	        parent.layer.confirm(tip, {
	            btn: ['确定', '取消']
	        }, function (index) {
	            ensure();
	            parent.layer.close(index);
	        }, function (index) {
	        	cancel();
	            parent.layer.close(index);
	        });
	    },
	    dialogFactory.log = function (info) {
	        console.log(info);
	    },
	    dialogFactory.alert = function (info, iconIndex) {
	        parent.layer.msg(info, {
	            icon: iconIndex
	        });
	    },
	    dialogFactory.info = function (info) {
	        dialogFactory.alert(info, 0);
	    },
	    dialogFactory.success = function (info) {
	        dialogFactory.alert(info, 1);
	    },
	    dialogFactory.error = function (info) {
	        dialogFactory.alert(info, 2);
	    },
	    
	    dialogFactory.infoDetail = function (title, info) {
	        var display = "";
	        if (typeof info == "string") {
	            display = info;
	        } else {
	            if (info instanceof Array) {
	                for (var x in info) {
	                    display = display + info[x] + "<br/>";
	                }
	            } else {
	                display = info;
	            }
	        }
	        parent.layer.open({
	            title: title,
	            type: 1,
	            move:false,
	            area: ['950px', '600px'], //宽高
	            content: '<div style="padding: 20px;">' + display + '</div>'
	        });
	    },
	    dialogFactory.writeObj = function (obj) {
	        var description = "";
	        for (var i in obj) {
	            var property = obj[i];
	            description += i + " = " + property + ",";
	        }
	        layer.alert(description, {
	            skin: 'layui-layer-molv',
	            closeBtn: 0
	        });
	    },
	    dialogFactory.showInputTree = function (inputId, inputTreeContentId, leftOffset, rightOffset) {
	        var onBodyDown = function (event) {
	            if (!(event.target.id == "menuBtn" || event.target.id == inputTreeContentId || $(event.target).parents("#" + inputTreeContentId).length > 0)) {
	                $("#" + inputTreeContentId).fadeOut("fast");
	                $("body").unbind("mousedown", onBodyDown);// mousedown当鼠标按下就可以触发，不用弹起
	            }
	        };
	
	        if(leftOffset == undefined && rightOffset == undefined){
	            var inputDiv = $("#" + inputId);
	            var inputDivOffset = $("#" + inputId).offset();
	            $("#" + inputTreeContentId).css({
	                left: inputDivOffset.left + "px",
	                top: inputDivOffset.top + inputDiv.outerHeight() + "px"
	            }).slideDown("fast");
	        }else{
	            $("#" + inputTreeContentId).css({
	                left: leftOffset + "px",
	                top: rightOffset + "px"
	            }).slideDown("fast");
	        }
	
	        $("body").bind("mousedown", onBodyDown);
	    },
	    dialogFactory.baseAjax = function (url, tip) {
	        var ajax = new $ax(dialogFactory.ctxPath + url, function (data) {
	            dialogFactory.success(tip + "成功!");
	        }, function (data) {
	            dialogFactory.error(tip + "失败!" + data.responseJSON.message + "!");
	        });
	        return ajax;
	    },
	    dialogFactory.changeAjax = function (url) {
	        return dialogFactory.baseAjax(url, "修改");
	    },
	    dialogFactory.zTreeCheckedNodes = function (zTreeId) {
	        var zTree = $.fn.zTree.getZTreeObj(zTreeId);
	        var nodes = zTree.getCheckedNodes();
	        var ids = "";
	        for (var i = 0, l = nodes.length; i < l; i++) {
	            ids += "," + nodes[i].id;
	        }
	        return ids.substring(1);
	    }
		return dialogFactory;
	});
});
