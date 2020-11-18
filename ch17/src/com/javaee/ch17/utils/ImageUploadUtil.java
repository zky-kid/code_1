package com.javaee.ch17.utils;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

/**
 * @ClassName: ImageUploadUtil
 * @Description: 图片上传工具类，包括ckeditor操作
 */
public class ImageUploadUtil {

    // 图片类型
    private static List<String> fileTypes = new ArrayList<String>();
    //private static final String tempFileDir = "/upload/ckeditor_files/";
    static {
        fileTypes.add(".jpg");
        fileTypes.add(".jpeg");
        fileTypes.add(".bmp");
        fileTypes.add(".gif");
        fileTypes.add(".png");
    }

    /**
     * 图片上传
     * 
     * @Title upload
     * @param request
     * @param DirectoryName
     *            文件上传目录：比如upload(无需带前面的/) upload/news ..
     * @return
     * @throws IllegalStateException
     * @throws IOException
     */
    public static String upload(HttpServletRequest request, String DirectoryName) throws IllegalStateException,
            IOException {
        // 创建一个通用的多部分解析器
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request.getSession().getServletContext());
        // 图片名称
        String fileName = null;
        // 判断 request 是否有文件上传,即多部分请求
        if (multipartResolver.isMultipart(request)) {
            // 转换成多部分request
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
            // 取得request中的所有文件名
            Iterator<String> iter = multiRequest.getFileNames();
            while (iter.hasNext()) {
                // 记录上传过程起始时的时间，用来计算上传时间
                // int pre = (int) System.currentTimeMillis();
                // 取得上传文件
                MultipartFile file = multiRequest.getFile(iter.next());
                if (file != null) {
                    // 取得当前上传文件的文件名称
                    String myFileName = file.getOriginalFilename();
                    // 如果名称不为“”,说明该文件存在，否则说明该文件不存在
                    if (myFileName.trim() != "") {
                        // 获得图片的原始名称
                        String originalFilename = file.getOriginalFilename();
                        // 获得图片后缀名称,如果后缀不为图片格式，则不上传
                        String suffix = originalFilename.substring(originalFilename.lastIndexOf(".")).toLowerCase();
                        if (!fileTypes.contains(suffix)) {
                            continue;
                        }
                        // 获得上传路径的绝对路径地址(/upload)-->
                        String realPath = request.getSession().getServletContext().getRealPath("/" + DirectoryName);
                        System.out.println(realPath);
                        // 如果路径不存在，则创建该路径
                        File realPathDirectory = new File(realPath);
                        if (realPathDirectory == null || !realPathDirectory.exists()) {
                            realPathDirectory.mkdirs();
                        }
                        // 重命名上传后的文件名 111112323.jpg
                        //fileName = DateUtil.format(new Date(), DateUtil.DATE_FORMAT_1) + suffix;//原版
                        fileName="sdfrg"+ suffix;
                        // 定义上传路径 .../upload/111112323.jpg
                        File uploadFile = new File(realPathDirectory + "\\" + fileName);
                        System.out.println(uploadFile);
                        file.transferTo(uploadFile);
                    }
                }
                // 记录上传该文件后的时间
                // int finaltime = (int) System.currentTimeMillis();
                // System.out.println(finaltime - pre);
            }
        }
        return fileName;
    }

    /**
     * ckeditor文件上传功能，回调，传回图片路径，实现预览效果。
     * 
     * @Title ckeditor
     * @param request
     * @param response
     * @param DirectoryName
     *            文件上传目录：比如upload(无需带前面的/) upload/..
     * @throws IOException
     */
    public static void ckeditor0(HttpServletRequest request, HttpServletResponse response, String DirectoryName)
            throws IOException {
        String fileName = upload(request, DirectoryName);
        // 结合ckeditor功能
        // imageContextPath为图片在服务器地址，如upload/123.jpg,非绝对路径
        String imageContextPath = request.getContextPath() + "/" + DirectoryName + "/" + fileName;
        response.setContentType("text/html;charset=UTF-8");
        String callback = request.getParameter("CKEditorFuncNum");
        PrintWriter out = response.getWriter();
        /*
        out.println("<script type=\"text/javascript\">");
        out.println("window.parent.CKEDITOR.tools.callFunction(" + callback + ",'" + imageContextPath + "',''" + ")");
        out.println("</script>");  
        
        {
"uploaded": 1,   //写死的
"fileName": filename,  //图片名
"url": url  //上传服务器的图片的url
}
        */

        out.println("{");
        out.println("'uploaded':1, 'fileName':"+fileName+", 'url':"+imageContextPath);
        out.println("}");
        out.flush();
        out.close();
    }
    public static void ckeditor(HttpServletRequest request, HttpServletResponse response, String DirectoryName)
            throws IOException {
    	//System.out.println("执行upload！");
        //String absouluteDir = ApplicationContext.getInstance().getWarRealPath()+tempFileDir;
    	//String absouluteDir = request.getServletContext().getRealPath(tempFileDir);//request.getContextPath()+tempFileDir;
    	String absouluteDir = request.getServletContext().getRealPath(DirectoryName);
    	File tmpFile = new File(absouluteDir);
        if (!tmpFile.exists()) {
            tmpFile.mkdirs(); // 不要用mkdir(); 因它只能创建一个文件夹而不能递归地连续创建涉及但缺的若干个文件夹。
        }
        DiskFileItemFactory factory = new DiskFileItemFactory();//设置工厂
        factory.setSizeThreshold(1024*100);                        //设置缓冲区大小
        factory.setRepository(tmpFile);                            //设置临时文件夹
        
        ServletFileUpload upload = new ServletFileUpload(factory);//设置解析器
        upload.setHeaderEncoding("UTF-8");
        try {
            List<FileItem> list = upload.parseRequest(request);//解析request返回文件List
            
            for(FileItem item:list){
                if(StringUtils.isBlank(item.getName())) 
                    continue;
                
                String fileName = item.getName();
                
                // 获得图片后缀名称,如果后缀不为图片格式，则不上传
                String suffix = fileName.substring(fileName.lastIndexOf(".")).toLowerCase();
                if (!fileTypes.contains(suffix)) {
                    response.setContentType("text/json;charset=UTF-8");
                    response.setCharacterEncoding("UTF-8");
                    PrintWriter out = response.getWriter();
                    String result = "{\"fileName\":\""+fileName+"\",\"uploaded\": 1,"
                            + "\"error\": { \"number\":\"001\", \"message\":\"文件类型不匹配，请上传jpg/jpeg/bmp/gif/png图片\" } }";
                    out.println(result);
                    out.flush();
                    out.close();
                    return;
                }
                
                String newFileName = UUID.randomUUID().toString()+fileName.substring(fileName.lastIndexOf("."));
                String imagePath = absouluteDir+newFileName;
                File imageFile = new File(imagePath);
                if(imageFile.exists()){
                    FileUtils.forceDelete(imageFile);
                }
                imageFile.createNewFile();
                FileUtils.writeByteArrayToFile(imageFile, item.get());
                item.delete();
                
                //返回图片项目路径
                //String imageContextPath = request.getContextPath() + tempFileDir +  newFileName;
                String imageContextPath = request.getContextPath() + DirectoryName +  newFileName;
                response.setContentType("text/json;charset=UTF-8");
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();
                out.println("{\"fileName\":\""+fileName+"\",\"uploaded\": 1,\"url\": \""+imageContextPath+"\"}");
                out.flush();
                out.close();
                
            }
        } catch (FileUploadException e) {
            // TODO 自动生成的 catch 块
            e.printStackTrace();
            
            response.setContentType("text/json;charset=UTF-8");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            out.println("{\"fileName\":'',\"uploaded\": 1,"
                    + "\"error\": { \"number\":\"002\", \"message\":\"上传图片出现异常，请重试\" } }");
            out.flush();
            out.close();
        }
    }    
}