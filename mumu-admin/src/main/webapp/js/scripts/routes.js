define([], function () {
    return {
        defaultRoute: '/main',
        routes: {
            'main': {
                templateUrl: '/views/common/_main.html',
                url: '/main',
                dependencies: ['controller/mainController'],
                allowAnonymous: true
            },
            'main.notice_msg': {
                templateUrl: '/views/system/notice/noticeMsg.html',
                url: '/notice_msg',
                dependencies: ['controller/system/notice/noticeController'],
                allowAnonymous: true
            },
            'main.menu': { //菜单管理路由
                templateUrl: '/views/system/menu/menu.html',
                url: '/menu',
                dependencies: ['controller/system/menu/menuController'],
                allowAnonymous: true
            },
            'main.dept': { //部门管理路由
                templateUrl: '/views/system/dept/dept.html',
                url: '/dept',
                dependencies: ['controller/system/dept/deptController'],
                allowAnonymous: true
            },
            'main.mgr': { // 用户管理路由
                templateUrl: '/views/system/user/user.html',
                url: '/mgr',
                dependencies: ['controller/system/user/userController'],
                allowAnonymous: true
            },
            'main.role': { // 角色管理路由
                templateUrl: '/views/system/role/role.html',
                url: '/role',
                dependencies: ['controller/system/role/roleController'],
                allowAnonymous: true
            },
            'main.log': { // 角色管理路由
                templateUrl: '/views/system/log/log.html',
                url: '/log',
                dependencies: ['controller/system/log/logController'],
                allowAnonymous: true
            }
            
            
        }
    };
});