package com.mumu.core.util;

import java.io.ByteArrayInputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import com.google.gson.Gson;
import com.qiniu.common.QiniuException;
import com.qiniu.common.Zone;
import com.qiniu.http.Response;
import com.qiniu.storage.Configuration;
import com.qiniu.storage.UploadManager;
import com.qiniu.storage.model.DefaultPutRet;
import com.qiniu.util.Auth;

public class QiNiuUtil {
	public static String fileUpload() {
		//构造一个带指定Zone对象的配置类
		Configuration cfg = new Configuration(Zone.zone0());
		//...其他参数参考类注释
		UploadManager uploadManager = new UploadManager(cfg);
		//...生成上传凭证，然后准备上传
		String accessKey = "your access key";
		String secretKey = "your secret key";
		String bucket = "your bucket name";
		//默认不指定key的情况下，以文件内容的hash值作为文件名
		String key = null;
		try {
		    byte[] uploadBytes = "hello qiniu cloud".getBytes("utf-8");
		    ByteArrayInputStream byteInputStream=new ByteArrayInputStream(uploadBytes);
		    Auth auth = Auth.create(accessKey, secretKey);
		    String upToken = auth.uploadToken(bucket);
		    try {
		        Response response = uploadManager.put(byteInputStream,key,upToken,null, null);
		        //解析上传成功的结果
		        DefaultPutRet putRet = new Gson().fromJson(response.bodyString(), DefaultPutRet.class);
		        String fileName = "七牛/云存储/qiniu.jpg";
		        String domainOfBucket = "http://devtools.qiniu.com";
		        String encodedFileName = URLEncoder.encode(fileName, "utf-8");
		        String finalUrl = String.format("%s/%s", domainOfBucket, encodedFileName);
		        System.out.println(finalUrl);
		    } catch (QiniuException ex) {
		        Response r = ex.response;
		        System.err.println(r.toString());
		        try {
		            System.err.println(r.bodyString());
		        } catch (QiniuException ex2) {
		        	ex2.printStackTrace();
		        }
		    }
		} catch (UnsupportedEncodingException ex) {
			ex.printStackTrace();
		}
	}

}
