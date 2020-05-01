package com.iarchie.crm_v1.common;

import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.UUID;


/**
 * 文件上传工具类
 */
public class FileUploadUtils {

    public static String uploadFile(MultipartFile file, String path) throws IOException {
        String name = file.getOriginalFilename(); //上传文件的真实名
        String suffixName = name.substring(name.lastIndexOf("."));//截取拓展名
        String uuid = UUID.randomUUID().toString();
        String fileName = uuid + suffixName;
        //文件上传
        File tempFile = new File(path, fileName);
        if (!tempFile.getParentFile().exists()) {
            tempFile.getParentFile().mkdir();
        }
        if (tempFile.exists()) {
            tempFile.delete();
        }
        tempFile.createNewFile();
        file.transferTo(tempFile);
        return tempFile.getName();

    }

}
