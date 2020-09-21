package com.dxd.firstcrud.bean;

import java.util.HashMap;
import java.util.Map;

/**
 * @Description:firstcrud
 * @Created by Administrator on 2019/11/1 13:37
 * @Modified by:
 *
 * 因为Controller层方法的返回值可能是String类型，
 *
 */

public class Msg {

    //状态码 200表示成功   110表示失败
    private int code;
    //一些提示信息
    private String message;
    //String要返回信息的关键字，Object返回对象的值
    private Map<String,Object> objectMap=new HashMap<>();

    public static Msg success(){
        Msg result=new Msg();
        result.setCode(200);
        result.setMessage("处理成功");
        return result;
    }
    public static Msg failure(){
        Msg result=new Msg();
        result.setCode(100);
        result.setMessage("处理失败");
        return result;
    }

    public Msg add(String key,Object value){
        this.getObjectMap().put(key, value);
        return this;

    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Map<String, Object> getObjectMap() {
        return objectMap;
    }

    public void setObjectMap(Map<String, Object> objectMap) {
        this.objectMap = objectMap;
    }
}
