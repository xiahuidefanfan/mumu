define([ 'routes', 'loader', 'angularAMD', 'ui-bootstrap', 'angular-sanitize', 'ui.route', 
	     'bootstrap', 'angular', 'jquery.ztree', 'layer', 'ng-layer', 'layui'], function(config, loader, angularAMD) {
	
	var app = angular.module("app", ['ngSanitize', 'ui.bootstrap', 'ui.router', 'ng-layer']);
	
	app.config(function($stateProvider, $urlRouterProvider) {
		// 配置路由
		if (config.routes != undefined) {
			angular.forEach(config.routes, function(route, path) {
				$stateProvider.state(path, {
					templateUrl : route.templateUrl,
					url : route.url,
					resolve : loader(route.dependencies)
				// allowAnonymous: route.allowAnonymous
				});
			});
		}
		// 默认路由
		if (config.defaultRoute != undefined) {
			$urlRouterProvider.when("", config.defaultRoute);
		}
	})

	return angularAMD.bootstrap(app);
});
