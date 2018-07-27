define(['app','dialogFactory','webuploader'], function(app) {
	app.factory('webUploadFactory',['dialogFactory', function (dialogFactory) {
	
		var webUploadFactory = {}
		
		var $WebUpload = function(pictureId) {
			this.pictureId = pictureId;
			this.uploadBtnId = pictureId + "BtnId";
			this.uploadPreId = pictureId + "PreId";
			this.uploadUrl = '/mgr/upload';
			this.fileSizeLimit = 100 * 1024 * 1024;
			this.picWidth = 800;
			this.picHeight = 800;
	        this.uploadBarId = null;
		};
		$WebUpload.prototype = {
			/**
			 * 初始化webUploader
			 */
			init : function() {
				debugger;
				var uploader = this.create();
				this.bindEvent(uploader);
				return uploader;
			},
			
			/**
			 * 创建webuploader对象
			 */
			create : function() {
				var webUploader = web_uploader.create({
					auto : true,
					pick : {
						id : '#' + this.uploadBtnId,
						multiple : false,// 只上传一个
					},
					accept : {
						title : 'Images',
						extensions : 'gif,jpg,jpeg,bmp,png',
	                    mimeTypes : 'image/gif,image/jpg,image/jpeg,image/bmp,image/png'
					},
					swf : dialogFactory.ctxPath
							+ '/static/js/plugins/webuploader/Uploader.swf',
					disableGlobalDnd : true,
					duplicate : true,
					server : this.uploadUrl,
					fileSingleSizeLimit : this.fileSizeLimit
				});
				
				return webUploader;
			},
	
			/**
			 * 绑定事件
			 */
			bindEvent : function(bindedObj) {
				var me =  this;
				bindedObj.on('fileQueued', function(file) {
					var $li = $('<div><img width="100px" height="100px"></div>');
					var $img = $li.find('img');
	
					$("#" + me.uploadPreId).html($li);
	
					// 生成缩略图
					bindedObj.makeThumb(file, function(error, src) {
						if (error) {
							$img.replaceWith('<span>不能预览</span>');
							return;
						}
						$img.attr('src', src);
					}, me.picWidth, me.picHeight);
				});
	
				// 文件上传过程中创建进度条实时显示。
				bindedObj.on('uploadProgress', function(file, percentage) {
	                $("#"+me.uploadBarId).css("width",percentage * 100 + "%");
				});
	
				// 文件上传成功，给item添加成功class, 用样式标记上传成功。
				bindedObj.on('uploadSuccess', function(file,response) {
					dialogFactory.success("上传成功");
					$("#" + me.pictureId).val(response);
				});
	
				// 文件上传失败，显示上传出错。
				bindedObj.on('uploadError', function(file) {
					dialogFactory.error("上传失败");
				});
	
				// 其他错误
				bindedObj.on('error', function(type) {
					if ("Q_EXCEED_SIZE_LIMIT" == type) {
						dialogFactory.error("文件大小超出了限制");
					} else if ("Q_TYPE_DENIED" == type) {
						dialogFactory.error("文件类型不满足");
					} else if ("Q_EXCEED_NUM_LIMIT" == type) {
						dialogFactory.error("上传数量超过限制");
					} else if ("F_DUPLICATE" == type) {
						dialogFactory.error("图片选择重复");
					} else {
						dialogFactory.error("上传过程中出错");
					}
				});
	
				// 完成上传完了，成功或者失败
				bindedObj.on('uploadComplete', function(file) {
				});
			},
	
	        /**
	         * 设置图片上传的进度条的id
	         */
	        setUploadBarId: function (id) {
	            this.uploadBarId = id;
	        }
		}
		webUploadFactory.getWebUpload = function(pictureId){
			return new $WebUpload(pictureId);
		}
		return webUploadFactory;
	}]);
})