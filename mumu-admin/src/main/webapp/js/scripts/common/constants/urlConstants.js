define(['app'], function(app) {
	app.constant('urlConstants',{
		LOGOUT_URL:	'/doLogout',                                            		  // 退出登陆
		LOGIN_PAGE_URL: '/login.html',                                      		  // 登陆地址
		INIT_MAIN_URL: '/initMain',                                         		  // 加载主页
		HAS_PERMISSION_URL: '/permission',                                  		  // 权限地址
		
		MENU_LIST_URL: '/menu/list',                                        		  // 菜单列表
		MENU_ADD_URL: '/menu/add',                                          		  // 菜单添加
		MENU_UPDATE_URL: '/menu/update',                                    		  // 菜单更新
	    MENU_DELETE_URL: '/menu/delete',                                    	      // 菜单删除
		MENU_ADD_PAGE_URL: '../views/system/menu/menu_add.html',            		  // 菜单添加
		MENU_UPDATE_PAGE_URL: '../views/system/menu/menu_update.html',      		  // 菜单更新
		
		MGR_LIST_URL: '/mgr/list',                                   	    		  // 用户列表
		MGR_ADD_URL: '/mgr/add',                                   	        		  // 用户添加
		MGR_UPDATE_URL: '/mgr/update',							     	    		  // 用户更新
		MGR_DELETE_URL: '/mgr/delete',							      	    	  	  // 用户删除
		MGR_RESET_PASSWORD_URL: '/mgr/reset',					     	    		  // 用户重置
		MGR_FREEZE_URL: '/mgr/freeze',                               	    		  // 用户冻结
		MGR_UNFREEZE_URL: '/mgr/unfreeze',                          	    		  // 用户解冻             
		MGR_ADD_PAGE_URL: '../views/system/user/user_add.html',             		  // 用户更新
		MGR_UPDATE_PAGE_URL: '../views/system/user/user_update.html',       		  // 用户添加
		
		DEPT_LIST_URL: '/dept/list',									    		  // 部门列表
		DEPT_ADD_URL: '/dept/add',                            	           		      // 部门添加
		DEPT_UPDATE_URL: '/dept/update',						     	    		  // 部门更新
		DEPT_DELETE_URL: '/dept/delete',						     	    		  // 部门删除
	    DEPT_ADD_PAGE_URL: '../views/system/dept/dept_add.html',            		  // 部门添加
	    DEPT_UPDATE_PAGE_URL: '../views/system/dept/dept_update.html',      		  // 部门更新
	    
	    DICT_LIST_URL: '/dict/list',                                                  // 字典列表
	    DICT_ADD_URL: '/dict/add',                            	           		      // 字典添加
	    DICT_UPDATE_URL: '/dict/update',						     	    		  // 字典更新
	    DICT_DELETE_URL: '/dict/delete',                                              // 字典删除
	    DICT_ADD_PAGE_URL: '../views/system/dict/dict_add.html',            		  // 字典添加
	    DICT_UPDATE_PAGE_URL: '../views/system/dict/dict_update.html',      		  // 字典更新
	    
	    ROLE_LIST_URL: '/role/list',                                       			  // 角色列表                          
	    ROLE_ADD_URL: '/role/add',                     					   		      // 角色添加
	    ROLE_UPDATE_URL: '/role/update',								   		 	  // 角色更新
	    ROLE_DELETE_URL: '/role/delete',                                   		 	  // 角色删除
	    ROLE_AUTHORITY_URL: '/role/authority',                              		  // 权限获取
	    ROLE_SET_AUTHORITY_URL: '/role/setAuthority',                       		  // 设置权限
	    ROLE_ADD_PAGE_URL: '../views/system/role/role_add.html',            		  // 角色添加
	    ROLE_UPDATE_PAGE_URL: '../views/system/role/role_update.html',      		  // 角色更新
	    ROLE_ASSIGN_PAGE_URL: '../views/system/role/role_assign.html',      		  // 权限分配
	    
	    LOG_LIST_URL: '/log/list',                                          	      // 日志列表
	    LOG_DELETE_URL: '/log/delete',                                                // 日志删除
	    LOG_DELETEALL_URL: '/log/deleteAll',                                          // 日志清除
        LOG_DETAIL_URL: '../views/system/log/log_detail.html',                        // 日志详情
	    	
        EXPENSE_LIST_URL: '/expense/list',                                  		   // 报销列表
        EXPENSE_ADD_URL: '/expense/add',                                               // 报销添加
        EXPENSE_UPDATE_URL: '/expense/update',                                         // 报销更新
        EXPENSE_DELETE_URL: '/expense/delete',                                         // 报销删除
        EXPENSE_EXECUTE_URL: '/expense/execute',                                       // 报销启动
        EXPENSE_ROLL_BACK_URL: '/expense/rollback',                                    // 报销回退
        EXPENSE_EXPENSE_VIEW_URL: '/expense/expenseView',                              // 报销流程
        EXPENSE_PASS_URL: '/expense/pass',                                    		   // 报销通过
        EXPENSE_UNPASS_URL: '/expense/unPass',                                         // 报销驳回
        EXPENSE_TASk_LIST_URL: '/expense/taskList',                                    // 报销审核
        EXPENSE_ADD_PAGE_URL: '../views/flowable/expense/expense_add.html', 	       // 报销流程
        EXPENSE_ADUIT_PAGE_URL: '../views/flowable/expense/expense_aduit.html',        // 报销审核
        EXPENSE_DETAIL_PAGE_URL: '../views/flowable/expense/expense_detail.html',      // 报销详情
        EXPENSE_UPDATE_PAGE_URL: '../views/flowable/expense/expense_update.html',      // 报销详情
        EXPENSE_ROLL_BACK_PAGE_URL: '../views/flowable/expense/expense_rollback.html', // 报销回退
        
        FLOWABLE_NODE_LIST: '/flowableNode/list',                                      // 流程节点
        FLOWABLE_TARGET_IDS_URL: '/flowableNode/targetIds',                            // 回退节点
        
        
        
        BOOK_LIST_URL: '/book/list',                                                   // 书籍列表
        BOOK_ADD_URL: '/book/add',                                               	   // 书籍添加
        BOOK_UPDATE_URL: '/book/update',                                         	   // 书籍更新
        BOOK_DELETE_URL: '/book/delete',                                         	   // 书籍删除
        BOOK_ADD_PAGE_URL: '../views/weixin/book/book_add.html',     				   // 报销详情
        BOOK_UPDATE_PAGE_URL: '../views/weixin/book/book_update.html',                 // 报销详情
	    
	});
});
