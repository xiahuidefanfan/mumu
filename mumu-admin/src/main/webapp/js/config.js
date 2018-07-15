require.config({
    //配置总路径
    baseUrl : "../js/scripts",
 
    paths : {
        // 其他模块会依赖他
        'ui.route':'../lib/angular-plugins/angular-ui-router/angular-ui-router.min',
        'angular' : '../lib/angular/angular.min',
        'angular-route' : '../lib/angular-route/angular-route',
        'angularAMD' : '../lib/angular-plugins/angularAMD',
        'ngDialog': '../lib/ngDialog/ngDialog.min',
        'angular-sanitize':'../lib/angular-plugins/angular-sanitize.min',
        'blockUI':'../lib/angular-plugins/angular-block-ui/angular-block-ui',
        'ngload':'../lib/angular-plugins/ngload',
        'ui-bootstrap':'../lib/angular-plugins/angular-ui-bootstrap/ui-bootstrap-tpls-0.12.1.min',
        'css' : '../lib/requirejs/css.min',
        'ueditorConfig' : '../lib/ueditor/ueditor.config',
        'ueditorAll' : '../lib/ueditor/ueditor.all.min',
        'jquery' : '../lib/jquery.min',
        'jquery.ui': '../lib/jquery-ui.min',
        'jquery.ztree': '../lib/ztree/jquery.ztree.core.min',
        'jquery.excheck': '../lib/ztree/jquery.ztree.excheck.min',
        'bootstrapTreeTable': '../lib/jquery-treegrid/extension/jquery.treegrid.extension',
        'jquery.treegrid': '../lib/jquery-treegrid/js/jquery.treegrid.min',
        'metisMenu': '../lib/metisMenu/jquery.metisMenu',
        'slimscroll': '../lib/slimscroll/jquery.slimscroll.min',
        'bootstrap': '../lib/bootstrap.min',
        'layer': '../lib/layer/layer',
        'ng-layer': '../lib/angular-plugins/ng-layer',
        'layui' : '../lib/layui/layui',
        'pace': '../lib/pace/pace.min',
        'hplus': '../lib/hplus',
        'contabs': '../lib/contabs',
        'dialogFactory': 'common/factory/dialogFactory',
        'operateUtil': 'common/util/operateUtil',
        'tableUtil': 'common/util/tableUtil',
        'treeTableUtil': 'common/util/treeTableUtil',
        'urlConstants': 'common/constants/urlConstants',
        'equalTo': 'directive/valid/equalTo',
        'ajaxService': 'service/common/ajaxService',
        'deptTreeService': 'service/common/deptTreeService',
        'roleTreeService': 'service/common/roleTreeService',
        'menuTreeService': 'service/common/menuTreeService',
        'permissionService': 'service/common/permissionService',
        'flowableNodeService': 'service/common/flowableNodeService'
    },
 
    shim : {
        // 表明该模块依赖angular
        'angularAMD' : [ 'angular'],
        'angular-route' : [ 'angular'],
        'ng-layer':[ 'angular'],
        'ui.route':['angular'],
        'ui-bootstrap' : [ 'angular'],
        'blockUI' : [ 'angular'],
        'angular-sanitize' : [ 'angular'],
        'ueditorConfig' : ['jquery'],
        'ueditorAll' : ['jquery'],
        'wdatePicker' : ['jquery'],
        'layer':['jquery'],
        'bootstrap' : ['jquery'],
        'metisMenu': ['jquery'],
        'slimscroll': ['jquery'],
        'hplus': ['jquery'],
        'contabs':['jquery'],
        'jquery.ztree': ['jquery'],
        'jquery.excheck': ['jquery'],
        'bootstrapTreeTable': ['jquery','jquery.treegrid']
    },
    urlArgs : "v=" + new Date().getTime(),
    // 启动程序 js/scripts/app.js
    deps : [ 'app' ]
});