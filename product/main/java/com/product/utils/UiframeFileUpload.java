package com.product.utils;

import net.sf.json.JSONObject;
import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.util.Streams;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.Date;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by yangn on 2015/9/17.
 */
@Controller
@RequestMapping(value = "uiframeUpload")
public class UiframeFileUpload {

    public static final String allChar = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";

    /**
     * 返回一个定长的随机字符串(只包含大小写字母、数字)
     *
     * @param length
     *            随机字符串长度
     * @return 随机字符串
     */
    public static String generateString(int length) {
        StringBuffer sb = new StringBuffer();
        Random random = new Random();
        for (int i = 0; i < length; i++) {
            sb.append(allChar.charAt(random.nextInt(allChar.length())));
        }
        return sb.toString();
    }


    @RequestMapping(value = "iconUpload.action",method= RequestMethod.POST)
    public void fileUpload(HttpServletRequest request,HttpServletResponse response){
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        String realDir = request.getSession().getServletContext().getRealPath("");
        String contextpath = request.getContextPath();
        String basePath = request.getScheme() + "://"
                + request.getServerName() + ":" + request.getServerPort()
                + contextpath + "/";
        UiframeFileMsgVo msgVo = new UiframeFileMsgVo();
        try {
            String filePath = "iconlibrary/uploadfiles";
            String realPath = realDir+"\\"+filePath;
            //判断路径是否存在，不存在则创建
            File dir = new File(realPath);
            if(!dir.isDirectory())
                dir.mkdir();

            if(ServletFileUpload.isMultipartContent(request)){
                DiskFileItemFactory dff = new DiskFileItemFactory();
                dff.setRepository(dir);
                dff.setSizeThreshold(1024000);
                ServletFileUpload sfu = new ServletFileUpload(dff);
                FileItemIterator fii = null;
                fii = sfu.getItemIterator(request);
                String title = "";   //图片标题
                String url = "";    //图片地址
                String fileName = "";
                String state="success";
                String realFileName="";
                while(fii.hasNext()){
                    FileItemStream fis = fii.next();
                    try{
                        if(!fis.isFormField() && fis.getName().length()>0){
                            fileName = fis.getName();
                            Pattern reg=Pattern.compile("[.]jpg|png|jpeg|gif$");
                            Matcher matcher=reg.matcher(fileName);
                            if(!matcher.find()) {
                                state = "文件类型不允许！";
                                break;
                            }
//                            realFileName = new Date().getTime()+fileName.substring(fileName.lastIndexOf("."),fileName.length());
                            realFileName = new Date().getTime() + generateString(10);
                            url = realPath+"\\"+realFileName;
                            msgVo.setFileId(realFileName);
                            msgVo.setFileName(fileName);
                            msgVo.setFileActionMsg(state);
                            msgVo.setFileSize((long) 0);
                            BufferedInputStream in = new BufferedInputStream(fis.openStream());//获得文件输入流
                            FileOutputStream a = new FileOutputStream(new File(url));
                            BufferedOutputStream output = new BufferedOutputStream(a);
                            Streams.copy(in, output, true);//开始把文件写到你指定的上传文件夹
                        }else{
                            String fname = fis.getFieldName();
                            if(fname.indexOf("pictitle")!=-1){
                                BufferedInputStream in = new BufferedInputStream(fis.openStream());
                                byte c [] = new byte[10];
                                int n = 0;
                                while((n=in.read(c))!=-1){
                                    title = new String(c,0,n);
                                    break;
                                }
                            }
                        }

                    }catch(Exception e){
                        e.printStackTrace();
                    }
                }
                JSONObject returnobj = new JSONObject();
                returnobj.put("fileMsg", msgVo);
                try {
                    response.setContentType("text/html;charset=UTF-8");
                    response.getWriter().println(returnobj.toString());
                    response.setStatus(200);
                    response.getWriter().flush();
                    response.getWriter().close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }catch(Exception ee) {
            ee.printStackTrace();
        }
    }
}
