define([ 'app' ], function(app) {
	app.directive('demo', function() {
		return {
			restrict : 'EA',
			replace : true,
			transclude : true,
			scope:{
				myname:'=myname'
			},
			template : '<span> <span ng-transclude></span> {{myname}}</span>',
			controller : [ '$scope', function($scope){
				console.log($scope.myname);
				this.test = function(){
					alert("hehe");
				}
			}],
			link:function(scope,element,attrs,contr){
				console.log(scope);
			}
		}
	});
});
