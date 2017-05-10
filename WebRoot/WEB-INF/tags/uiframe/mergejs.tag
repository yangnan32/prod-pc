<%@ tag import="com.widget.framework.mergejs.UiframeUtil" %>
<%@ tag import="java.util.List" %>
<%@ tag import="java.util.ArrayList" %>
<%@ tag import="com.widget.utils.Configration" %>
<%@ tag import="java.io.File" %>
<%@ tag pageEncoding="UTF-8" %>
<%@attribute name="moduleName" rtexprvalue="true" required="true" description="模块名称,对应xml文件名前缀;" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    List<String> jsList=new ArrayList();
    if (UiframeUtil.uiframeConfig.getDeployMod()){
        //发布模式，获取合并后js
        moduleName=moduleName.replaceAll("/","-");
        File jsFile=new File(Configration.getWebApplicationRootPath()+UiframeUtil.compressedFilePath+moduleName+".js");
        if(jsFile.exists()==false){
            System.err.println("找不到合并后的文件" + jsFile.getAbsolutePath());
        }else {
            jsList.add(UiframeUtil.compressedFilePath+moduleName+".js");
        }
    }else{
        String xmlFileName= UiframeUtil.xmlBasePath+moduleName+".xml";
        File xmlFile=new File(xmlFileName);
        if(xmlFile.exists()==false){
            System.err.println("找不到模块配置文件" + xmlFileName);
        }else {
            jsList=UiframeUtil.loadJsByModule(xmlFile);
        }
    }
    for(String js:jsList){
%>
<script type="text/javascript" src="<%=basePath%><%=js%>"></script>
<%
    }
%>
