package com.javaee.ch17.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.javaee.ch17.utils.ImageUploadUtil;


@Controller
public class CKFileUpload {
    /**
     * ckeditor图片上传
     * 
     * @Title imageUpload
     * @param request
     * @param response
     * https://blog.csdn.net/saytime/java/article/details/51416411
     */
    @RequestMapping("imageUpload")
    public void imageUpload(HttpServletRequest request, HttpServletResponse response) {
        String DirectoryName = "/upload/ckeditor_files/";
        try {
            ImageUploadUtil.ckeditor(request, response, DirectoryName);
        } catch (IllegalStateException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
