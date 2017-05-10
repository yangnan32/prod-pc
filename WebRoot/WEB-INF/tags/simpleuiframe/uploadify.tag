<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0
    * @created     : 14-8-4下午3:24
    * @team     :
    * @author      : yangn
    * @ps      : 使用uploadify插件封装的组件，单独维护
--%>
<%@ tag pageEncoding="UTF-8"%>
<%@ tag import="org.apache.commons.lang.StringUtils" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="widget" tagdir="/WEB-INF/tags/simpleuiframe" %>
<!-- 标签属性 -->
<%@attribute name="id" rtexprvalue="true" required="true" description="控件ID,必填" %>
<%@attribute name="fileId" rtexprvalue="true" required="true" description="附件id隐藏域id,必填" %>
<%@attribute name="fileName" rtexprvalue="true" required="true" description="附件name隐藏域name,必填" %>
<%@attribute name="fileTypes" rtexprvalue="true" required="false" description="限制上传附件类型，例:*.jsp;*.pdf" %>
<%@attribute name="fileMax" rtexprvalue="true" required="false" description="限制每次附件上传的最大个数" %>
<%@attribute name="btnText" rtexprvalue="true" required="false" description="上传按钮名称" %>
<%@attribute name="valueMap" rtexprvalue="true" type="java.util.Map" description="回显数据对应的LinkedHashMap对象" required="false" %>
<%@attribute name="cls" rtexprvalue="true"  required="false" description="class样式" %>
<%@attribute name="fileUrl" rtexprvalue="true"  required="false" description="上传文件的url" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    request.setAttribute("basePath", basePath);

    if(fileTypes == null || fileTypes.equalsIgnoreCase("")){
        fileTypes="*.*";
    } else {
        fileTypes = fileTypes;
    }
    if(btnText == null || btnText.equalsIgnoreCase("")){
        btnText="请选择文件";
    } else {
        btnText = btnText;
    }


    if(fileUrl==null||fileUrl.equalsIgnoreCase("")){
        fileUrl= basePath +"/upload/";
    }

    int max = 20;
    try{
        max = Integer.parseInt(fileMax);
    }catch (NumberFormatException ex){
        max = 20;
    }
%>

<div class="widget-uploadify" data-id="<%=id%>" data-url="<%=fileUrl%>" data-fileid="${fileId}" data-filename="${fileName}" data-filemax="<%=max%>" data-btnname="<%=btnText%>" data-filetypes="<%=fileTypes%>">
    <input type="hidden" name="${fileId}" id="${fileId}"/>
    <input type="hidden" name="${fileName}"  id="${fileName}"/>
    <%--<div style="height:25px;">--%>
    <%--<widget:btnbutton id="${id}StartUpload" value="上传" />--%>
    <%--<widget:btnbutton id="${id}CancelUpload" value="取消" />--%>
    <%--<widget:btnbutton id="${id}ClearUpload" value="清空" />--%>
    <%--<widget:btnbutton id="${id}SuspendUpload" value="暂停" />--%>
    <%--<widget:btnbutton id="${id}EnableUpload" value="启用" />--%>
    <%--<widget:btnbutton id="${id}DisabledUpload" value="禁用" />--%>
    <%--</div>--%>
    <input id="${id}" name="${id}" type="file" multiple="true">
    <div id="${id}FileQueue" style="position:relative;overflow:auto;">
        <% if(valueMap != null && valueMap.size() > 0){ %>
        <c:forEach var="item" items="<%=valueMap%>" varStatus="s">
            <div class="uploadify-queue-item" id="${item.key}">
                <div class="cancel">
                    <a href="javascript:$('#<%=id%>').uploadify('cancel', '${item.key}', '${item.value}')">X</a>
                </div>
                <span class="fileName editFileName" editFileId="${item.key}">${item.value}</span>
                <span class="data"> — 上传成功</span>
                <div class="uploadify-progress">
                    <div class="uploadify-progress-bar" style="width:100%;"></div>
                </div>
            </div>
        </c:forEach>
        <% } %>
    </div>
</div>