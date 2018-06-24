package com.mumu.core.util;

import java.beans.IntrospectionException;
import java.beans.PropertyDescriptor;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Date;
import java.util.List;

import com.mumu.core.common.constant.dictmap.base.AbstractDictMap;
import com.mumu.core.common.constant.dictmap.factory.DictFieldWarpperFactory;
import com.mumu.core.support.StrKit;

/**
 * 对比两个对象的变化的工具类
 *
 * @author fengshuonan
 * @Date 2017/3/31 10:36
 */
public class Contrast {

    //记录每个修改字段的分隔符
    public static final String SEPARATOR = ";;;";
    
    private static final String KEY_SEPARATOR = ",";

    /**
     * 比较两个对象,并返回不一致的信息
     *
     * @author stylefeng
     * @Date 2017/5/9 19:34
     */
    @SuppressWarnings("rawtypes")
    public static String contrastObj(Object objOld, Object objNew) {
        String str = "";
        try {
            Class clazz = objOld.getClass();
            Field[] fields = objOld.getClass().getDeclaredFields();
            int i = 1;
            for (Field field : fields) {
                if ("serialVersionUID".equals(field.getName())) {
                    continue;
                }
                PropertyDescriptor pd = new PropertyDescriptor(field.getName(), clazz);
                Method getMethod = pd.getReadMethod();
                Object o1 = getMethod.invoke(objOld);
                Object o2 = getMethod.invoke(objNew);
                if (o1 == null || o2 == null) {
                    continue;
                }
                if (o1 instanceof Date) {
                    o1 = DateUtil.getDay((Date) o1);
                }
                if (!o1.toString().equals(o2.toString())) {
                    if (i != 1) {
                        str += SEPARATOR;
                    }
                    str += "字段名称" + field.getName() + ",旧值:" + o1 + ",新值:" + o2;
                    i++;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return str;
    }

    /**
     * 比较两个对象objOld和objNew,并输出不一致信息
     *
     * @author stylefeng
     * @Date 2017/5/9 19:34
     */
    @SuppressWarnings("rawtypes")
    public static String contrastObj(Class dictClass, String key, Object objOld, Object objNew) 
            throws IllegalAccessException, InstantiationException {
        AbstractDictMap dictMap = (AbstractDictMap) dictClass.newInstance();
        String str = "";
        try {
            Class clazz = objOld.getClass();
            Field[] fields = objOld.getClass().getDeclaredFields();
            int i = 1;
            str = parseMutiKey(dictMap, key, objOld);
            
            for (Field field : fields) {
                if ("serialVersionUID".equals(field.getName())) {
                    continue;
                }
                PropertyDescriptor pd = new PropertyDescriptor(field.getName(), clazz);
                Method getMethod = pd.getReadMethod();
                Object o1 = getMethod.invoke(objOld);
                Object o2 = getMethod.invoke(objNew);
                if (o1 == null || o2 == null) {
                    continue;
                }
                if (!o1.toString().equals(o2.toString())) {
                    if (i != 1) {
                        str += SEPARATOR;
                    }
                    String fieldName = dictMap.get(field.getName());
                    String fieldWarpperMethodName = dictMap.getFieldWarpperMethodName(field.getName());
                    if (fieldWarpperMethodName != null) {
                        Object o1Warpper = DictFieldWarpperFactory.createFieldWarpper(o1, fieldWarpperMethodName);
                        Object o2Warpper = DictFieldWarpperFactory.createFieldWarpper(o2, fieldWarpperMethodName);
                        str += "字段名称:" + fieldName + ",旧值:" + o1Warpper + ",新值:" + o2Warpper;
                    } else {
                        str += "字段名称:" + fieldName + ",旧值:" + o1 + ",新值:" + o2;
                    }
                    i++;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return str;
    }

    /**
     * 解析多个key(逗号隔开的)
     */
    @SuppressWarnings("unchecked")
    public static String parseMutiKey(AbstractDictMap dictMap, String key, Object obj) throws IntrospectionException, 
        IllegalAccessException, InvocationTargetException{
        if(obj instanceof List) {
            StringBuilder sb = new StringBuilder();
            List<Object> objs = (List<Object>)obj;
            for(int i= 0; i < objs.size(); i++) {
                sb.append(parseSimpleKey(dictMap, key, objs.get(i)));
            }
            return sb.toString();
        }else {
            return parseSimpleKey(dictMap, key, obj);
        }
    }
    
    @SuppressWarnings("rawtypes")
    private static String parseSimpleKey(AbstractDictMap dictMap, String key, Object obj) throws IntrospectionException, 
        IllegalAccessException, InvocationTargetException{
        Class clazz = obj.getClass();
        String[] keys = key.split(KEY_SEPARATOR);
        String str = null;
        if(ToolUtil.isNotEmpty(key)) {
            StringBuilder sb = new StringBuilder();
            for (String keyName : keys) {
                PropertyDescriptor pd = new PropertyDescriptor(keyName, clazz);
                Method getMethod = pd.getReadMethod();
                String value = getMethod.invoke(obj).toString();
                sb.append(dictMap.get(keyName) + "=" + value + ",");
            }
            str = StrKit.removeSuffix(sb.toString(), ",") + SEPARATOR;
        }
        return str;
    }

}