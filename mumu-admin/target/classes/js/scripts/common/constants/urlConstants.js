define(['app'], function(app) {
	app.constant('urlConstants',{
		LOGOUT_URL:	'/doLogout',                                          // 退出登陆
		LOGIN_PAGE_URL: '/login.html',                                    // 登陆地址
		INIT_MAIN_URL: '/initMain',                                       // 加载主页
		HAS_PERMISSION_URL: '/permission',                                // 权限地址
		
		MENU_LIST_URL: '/menu/list',                                      // 菜单管理
		MENU_UPDATE_PAGE_URL: '../views/system/menu/menu_update.html',    // 菜单更新
		
		MGR_LIST_URL: '/mgr/list',                                   	  // 用户列表
		MGR_ADD_URL: '/mgr/add',                                   	      // 用户添加
		MGR_UPDATE_URL: '/mgr/update',							     	  // 用户更新
		MGR_DELETE_URL: '/mgr/delete',							      	  // 用户删除
		MGR_RESET_PASSWORD_URL: '/mgr/reset',					     	  // 用户重置
		MGR_FREEZE_URL: '/mgr/freeze',                               	  // 用户冻结
		MGR_UNFREEZE_URL: '/mgr/unfreeze',                          	  // 用户解冻             
		MGR_ADD_PAGE_URL: '../views/system/user/user_add.html',           // 用户更新
		MGR_UPDATE_PAGE_URL: '../views/system/user/user_update.html',     // 用户添加
		
		DEPT_LIST_URL: '/dept/list',									  // 部门列表
		DEPT_ADD_URL: '/dept/add',                            	          // 部门添加
		DEPT_UPDATE_URL: '/dept/update',						     	  // 部门更新
		DEPT_DELETE_URL: '/dept/delete',						     	  // 部门删除
	    DEPT_ADD_PAGE_URL: '../views/system/dept/dept_add.html',          // 部门添加
	    DEPT_UPDATE_PAGE_URL: '../views/system/dept/dept_update.html',    // 部门更新
	    
	    ROLE_LIST_URL: '/role/list',                                      // 角色列表                          
	    ROLE_ADD_URL: '/role/add',                     					  // 角色添加
	    ROLE_UPDATE_URL: '/role/update',								  // 角色更新
	    ROLE_DELETE_URL: '/role/delete',                                  // 角色删除
	    ROLE_AUTHORITY_URL: '/role/authority',                            // 权限获取
	    ROLE_SET_AUTHORITY_URL: '/role/setAuthority',                     // 设置权限
	    ROLE_ADD_PAGE_URL: '../views/system/role/role_add.html',          // 角色添加
	    ROLE_UPDATE_PAGE_URL: '../views/system/role/role_update.html',    // 角色更新
	    ROLE_ASSIGN_PAGE_URL: '../views/system/role/role_assign.html',    // 权限分配
	    
	    LOG_DELETE_URL: '/log/delete',                                    // 日志删除
	    LOG_DELETEALL_URL: '/log/deleteAll',                              // 日志清除
	    LOG_LIST_URL: '/log/list',                                        // 日志列表
        LOG_DETAIL_URL: '../views/system/log/log_detail.html',            // 日志详情
	    	
	    
	});
});
