package com.iarchie.crm_v1.utils;

public class StringUtils {

    /**
     * 方法功能描述 判断非空
     * 　　* @Description: TODO
     * 　　* @param  string
     * 　　* @return boolean
     * 　　* @author georgedage
     * 　　* @date 2020/02/12 11:31
     *
     */
    public static boolean hasLength(String str) {
        return str != null && !"".equals(str.trim());
    }
}
