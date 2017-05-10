<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0 
    * @created     : 12-5-16下午2:24
    * @team	    : 
    * @author      : yangn
    * @ps      : 使用ajaxfileupload插件封装的组件，单独维护
--%>
<%@tag pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ tag import="org.apache.commons.lang.StringUtils" %>
<%@ tag import="java.util.Date" %>

<!-- 标签属性 -->
<%@attribute name="id" rtexprvalue="true" required="true" description="控件ID,必填" %>
<%@attribute name="fileId" rtexprvalue="true" required="true" description="控件id隐藏域ID,必填" %>
<%@attribute name="fileValueId" rtexprvalue="true" required="true" description="控件value隐藏域ID,必填" %>
<%@attribute name="group" rtexprvalue="true" required="false" description="控件 群组class名称，根据class选择器选择所需" %>
<%@attribute name="idName" rtexprvalue="true"  required="false" description="控件下拉框name,后台根据name获取选择的值" %>
<%@attribute name="valueName" rtexprvalue="true"  required="false" description="控件的value值的name" %>
<%@attribute name="fileIdValue" rtexprvalue="true"  required="false" description="附件id的回显值" %>
<%@attribute name="fileNameValue" rtexprvalue="true"  required="false" description="附件name的回显值" %>
<%@attribute name="width" rtexprvalue="true"  required="false" description="控件宽度，不填则取默认值" %>
<%@attribute name="disabled" rtexprvalue="true"  required="false" description="是否可用,值为true或者false" %>
<%@attribute name="resetbtn" rtexprvalue="true"  required="false" description="是否可用,值为true或者false" %>
<%@attribute name="cls" rtexprvalue="true"  required="false" description="class样式" %>
<%@attribute name="fileUrl" rtexprvalue="true"  required="false" description="上传文件的url" %>
<%@attribute name="must" rtexprvalue="true"  required="false" description="是否必填，true或false" %>

<%
    long uuid=new Date().getTime();
    String disableText="";
    String autoLoad="true";
    String disableClass="";
    String disableBtnClass="";
    String fontText="";
    String nameText="";
    String idText="";
    String fileIdValueText="";
    String fileNameValueText="";

    if(StringUtils.isNotBlank(fileIdValue)){
        fileIdValueText="value='"+fileIdValue+"'";
    }else {
        fileIdValueText="";
    }

    if(StringUtils.isNotBlank(fileNameValue)){
        fileNameValueText="value='"+fileNameValue+"'";
    }else {
        fileNameValueText="";
    }

    if(StringUtils.isNotEmpty(disabled) && disabled.equalsIgnoreCase("true")){
        autoLoad="false";
        disableText="disabled='disabled'";
        disableClass="uiframeTextDisabled";
        disableBtnClass="uiframe-emptyTextColor";
    }

    if(StringUtils.isNotEmpty(resetbtn) && resetbtn.equalsIgnoreCase("true")){
        resetbtn="style='display:none'";
    }

    if(StringUtils.isNotBlank(valueName)){
        nameText="name='"+valueName+"'";
    }else {
        nameText="";
    }

    if(StringUtils.isNotBlank(idName)){
        idText="name='"+idName+"'";
    }else {
        idText="";
    }

    if(fileUrl==null||fileUrl.equalsIgnoreCase("")){
        fileUrl="192.168.4.27:8082";
    }

    if(width==null||width.equalsIgnoreCase("")){
        width="334";
    }
    float w=334;
    try{
        w=Float.parseFloat(width);
    }catch (NumberFormatException ex){
        w=334;
    }
%>
<div class="uiframe-file-container widget-file" id="file<%=id%><%=uuid%>" data-id="<%=id%>" data-url="<%=fileUrl%>" data-fileid="<%=fileId%>" data-filevalueid="<%=fileValueId%>" data-autoload="<%=autoLoad%>">
    <input type="hidden" id="${fileId}" <%=idText%> <%=fileIdValueText%> />
    <input type="hidden" id="${fileValueId}" <%=fileNameValueText%> <%=nameText%> />
    <input type="text" id="${id}"  <%=fileNameValueText%> name="txt_${fileId}" readonly="readonly" class="uiframe-fileinput ${cls} ${group} <%=disableClass%>" style="float: left;width:<%=w%>px;<%=fontText%>" <%=disableText%> >
    <span id="${id}Btn" class="uiframe-module-btn uiframe-cancel-btn uiframe-button-file <%=disableBtnClass%>" style="<%=fontText%>" >浏览</span>
    <c:choose>
        <c:when test="${not empty must and must=='true'}">
            <span class="mustWrite" style="margin-left: 4px;">*</span>
        </c:when>
    </c:choose>
    <span class="file-reset" id="${id}ClearBtn" <%=resetbtn%> >清空</span>
</div>

