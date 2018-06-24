define([], function () {
    return {
        defaultRoute: '/form',
        routes: {
            'form': {
                templateUrl: 'views/form.html',
                url: '/form',
                dependencies: ['controller/formController'],
                allowAnonymous: true
            },
            'form.required': {
                templateUrl: 'views/form-required.html',
                url: '/required',
                dependencies: [],
                allowAnonymous: true
            },
            'form.optional': {
                templateUrl: 'views/form-optional.html',
                url: '/optional',
                dependencies: [],
                allowAnonymous: true
            }, 
            'form.confirm': {
                templateUrl: 'views/form-confirm.html',
                url: '/confirm',
                dependencies: [],
                allowAnonymous: true
            },
            'index':{
            	 templateUrl: 'views/index.html',
                 url: '/index',
                 dependencies: ['controller/loginController'],
                 allowAnonymous: true
            }
            
            
        }
    };
});