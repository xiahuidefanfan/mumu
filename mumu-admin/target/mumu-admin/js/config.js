require.config({
    //配置总路径
    baseUrl : "js/scripts",
 
    paths : {
        // 其他模块会依赖他
        'ui.route':'../lib/angular-plugins/angular-ui-router/angular-ui-router.min',
        'angular' : '../lib/angular/angular',
        'angular-route' : '../lib/angular-route/angular-route',
        'angularAMD' : '../lib/angular-plugins/angularAMD',
        'css' : '../lib/requirejs/css.min',
        'jquery' : '../lib/jquery.min',
        'jquery.backstretch' : '../lib/jquery.backstretch.min',
        'ueditorConfig' : '../lib/ueditor/ueditor.config',
        'ueditorAll' : '../lib/ueditor/ueditor.all.min',
        'wdatePicker' : '../lib/My97DatePicker/WdatePicker',
        'blockUI':'../lib/angular-plugins/angular-block-ui/angular-block-ui',
        'ngload':'../lib/angular-plugins/ngload',
        'ui-bootstrap':'../lib/angular-plugins/angular-ui-bootstrap/ui-bootstrap-tpls-0.12.1.min',
        'angular-sanitize':'../lib/angular-plugins/angular-sanitize.min'
    },
 
    shim : {
        // 表明该模块依赖angular
        'angularAMD' : [ 'angular'],
        'angular-route' : [ 'angular'],
        'ui.route':['angular'],
        'ueditorConfig' : ['jquery'],
        'ueditorAll' : ['jquery'],
        'wdatePicker' : ['jquery'],
        'ui-bootstrap' : [ 'angular'],
        'blockUI' : [ 'angular'],
        'angular-sanitize' : [ 'angular' ]
         
    },
    urlArgs : "v=" + new Date().getTime(),
    // 启动程序 js/scripts/app.js
    deps : [ 'app' ]
});