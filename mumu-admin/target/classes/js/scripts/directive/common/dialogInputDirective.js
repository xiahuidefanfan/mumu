define([ 'app' ], function(app) {
	app.directive('dialogInputDirective', function() {
		 return {
	        restrict: 'EA',
	        scope: {
	        	model: '=attrModel',
	        	form: '@attrForm',
	            name: '@attrName',
	            labelName:'@attrLabelName',
	            required: '@attrRequired',
	            errorMsg:'@attrErrorMsg'
	        },
	        replace: true,
	        template: "<div ng-class={'form-group':true,'has-feedback':true,'has-error':true>"+
	        		  "formValidate.account>"+
	        		  "<label class='col-sm-3 control-label'>{{labelName}}</label>"+ 
	        		  "<div class='col-sm-9'>" +
	        		  "<input class='form-control' ng-model='model' name='{{name}}' ng-required='required'>"+ 
	        		  "<small style='display: block;color:#ed5565' ng-if='formValidate.account'>"+ 
    		  		  "{{errorMsg}}</small>" + 
	        		  "<div class='hr-line-dashed'></div>"
	     }
	});
});	
