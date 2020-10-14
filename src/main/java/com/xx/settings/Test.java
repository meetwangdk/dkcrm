package com.xx.settings;

import com.xx.utils.MD5Util;

public class Test {
    public static void main(String[] args) {
        String md5 = MD5Util.getMD5("123");
        System.out.println(md5);
    }
}
