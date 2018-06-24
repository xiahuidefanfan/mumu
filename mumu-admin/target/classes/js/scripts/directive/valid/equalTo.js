define([ 'app' ], function(app) {
	app.directive("equalTo", function () {
	    return {
	        require: "ngModel",
	        link: function (scope, ele, attrs, ctrl) {
	            var target = attrs["equalTo"];//获取自定义指令属性键值
	            if (target) {
	                scope.$watch(target, function () {//存在启动监听其值
	                    ctrl.$validate()//每次改变手动调用验证
	                }) 
	                
	                //获取指定模型控制器
	                var targetCtrl = ctrl.$$parentForm[target];
	
	                ctrl.$validators.equalTo = function (modelValue, viewValue) {
	                    var targetValue = targetCtrl.$viewValue;
	                    return targetValue == viewValue;
	                }
	            }
	        }
	    }
    });
});